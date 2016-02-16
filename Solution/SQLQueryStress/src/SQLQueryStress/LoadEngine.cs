#region

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Threading;

#endregion

namespace SQLQueryStress
{
    internal class LoadEngine
    {
        private static readonly Queue<QueryOutput> QueryOutInfo = new Queue<QueryOutput>();
        private readonly bool _collectIoStats;
        private readonly bool _collectTimeStats;
        private readonly List<SqlCommand> _commandPool = new List<SqlCommand>();
        private readonly int _commandTimeout;

        private readonly string _connectionString;
        private readonly bool _forceDataRetrieval;
        private readonly int _iterations;
        private readonly string _paramConnectionString;
        private readonly Dictionary<string, string> _paramMappings;
        //private readonly List<Queue<queryOutput>> queryOutInfoPool = new List<Queue<queryOutput>>();        
        private readonly string _paramQuery;
        private readonly string _query;
        private readonly List<Thread> _threadPool = new List<Thread>();
        private readonly int _threads;

        public LoadEngine(string connectionString, string query, int threads, int iterations, string paramQuery, Dictionary<string, string> paramMappings,
            string paramConnectionString, int commandTimeout, bool collectIoStats, bool collectTimeStats, bool forceDataRetrieval)
        {
            //Set the min pool size so that the pool does not have
            //to get allocated in real-time
            var builder = new SqlConnectionStringBuilder(connectionString) {MinPoolSize = threads};

            _connectionString = builder.ConnectionString;
            _query = query;
            _threads = threads;
            _iterations = iterations;
            _paramQuery = paramQuery;
            _paramMappings = paramMappings;
            _paramConnectionString = paramConnectionString;
            _commandTimeout = commandTimeout;
            _collectIoStats = collectIoStats;
            _collectTimeStats = collectTimeStats;
            _forceDataRetrieval = forceDataRetrieval;
        }

        public static bool ExecuteCommand(string connectionString, string sql)
        {
            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
        }

        public void StartLoad(BackgroundWorker worker)
        {
            var useParams = false;

            var badParams = new List<string>();
            foreach (var theKey in _paramMappings.Keys)
            {
                if ((_paramMappings[theKey] == null) || (_paramMappings[theKey].Length == 0))
                {
                    badParams.Add(theKey);
                }
            }

            foreach (var theKey in badParams)
            {
                _paramMappings.Remove(theKey);
            }

            //Need some parameters?
            if (_paramMappings.Count > 0)
            {
                ParamServer.Initialize(_paramQuery, _paramConnectionString, _paramMappings);
                useParams = true;
            }

            //Initialize the connection pool            
            var conn = new SqlConnection(_connectionString);
            //TODO: use this or not??
            SqlConnection.ClearPool(conn);
            conn.Open();
            conn.Dispose();

            //make sure the run cancelled flag is not set
            QueryInput.RunCancelled = false;

            //Spin up the load threads
            for (var i = 0; i < _threads; i++)
            {
                conn = new SqlConnection(_connectionString);

                //TODO: Figure out how to make this option work (maybe)
                //conn.FireInfoMessageEventOnUserErrors = true;

                SqlCommand statsComm = null;

                var queryComm = new SqlCommand {CommandTimeout = _commandTimeout, Connection = conn, CommandText = _query};

                if (useParams)
                {
                    queryComm.Parameters.AddRange(ParamServer.GetParams());
                }

                var setStatistics = (_collectIoStats ? @"SET STATISTICS IO ON;" : "") + (_collectTimeStats ? @"SET STATISTICS TIME ON;" : "");

                if (setStatistics.Length > 0)
                {
                    statsComm = new SqlCommand {CommandTimeout = _commandTimeout, Connection = conn, CommandText = setStatistics};
                }

                //Queue<queryOutput> queryOutInfo = new Queue<queryOutput>();

                var input = new QueryInput(statsComm, queryComm,
//                    this.queryOutInfo,
                    _iterations, _forceDataRetrieval);

                var theThread = new Thread(input.StartLoadThread) {Priority = ThreadPriority.BelowNormal};

                _threadPool.Add(theThread);
                _commandPool.Add(queryComm);
                //queryOutInfoPool.Add(queryOutInfo);
            }

            //Start the load threads
            for (var i = 0; i < _threads; i++)
            {
                _threadPool[i].Start();
            }

            //Start reading the queue...
            var finishedThreads = 0;
            var cancelled = false;

            while (finishedThreads < _threads)
            {
//                for (int i = 0; i < threads; i++)
//                {
                // try
                // {
                QueryOutput theOut = null;
                //lock (queryOutInfoPool[i])
                lock (QueryOutInfo)
                {
                    //if (queryOutInfoPool[i].Count > 0)
                    //theOut = (queryOutput)queryOutInfoPool[i].Dequeue();
                    if (QueryOutInfo.Count > 0)
                        theOut = QueryOutInfo.Dequeue();
                    else
                        Monitor.Wait(QueryOutInfo);
                }

                if (theOut != null)
                {
                    //Report output to the UI
                    worker.ReportProgress((int) (finishedThreads / (decimal) _threads * 100), theOut);

                    //TODO: Make this actually remove the queue from the pool so that it's not checked again -- maintain this with a bitmap, perhaps?
                    if (theOut.Finished)
                        finishedThreads++;
                }
                /* }
                    catch (InvalidOperationException e)
                    {
                    }
                    */

                /*
                        if (theOut != null)
                            Thread.Sleep(200);
                        else
                            Thread.Sleep(10);
                     */
                //               }

                //TODO: Remove this ?
                GC.Collect();

                if (worker.CancellationPending && !cancelled)
                {
                    QueryInput.RunCancelled = true;

                    //First, kill connections as fast as possible
                    SqlConnection.ClearAllPools();

                    //for each 20 threads, create a new thread dedicated
                    //to killing them
                    var threadNum = _threadPool.Count;

                    var killerThreads = new List<Thread>();
                    while (threadNum > 0)
                    {
                        var i = threadNum <= 20 ? 0 : threadNum - 20;

                        var killThreads = new Thread[threadNum - i < 1 ? threadNum : threadNum - i];
                        var killCommands = new SqlCommand[threadNum - i < 1 ? threadNum : threadNum - i];

                        _threadPool.CopyTo(i, killThreads, 0, killThreads.Length);
                        _commandPool.CopyTo(i, killCommands, 0, killCommands.Length);

                        for (var j = threadNum - 1; j >= i; j--)
                        {
                            _threadPool.RemoveAt(j);
                            _commandPool.RemoveAt(j);
                        }

                        var kill = new ThreadKiller(killThreads, killCommands);
                        var killer = new Thread(kill.KillEm);
                        killer.Start();
                        Thread.Sleep(0);

                        killerThreads.Add(killer);

                        threadNum = i;
                    }

                    //wait for the kill threads to return
                    //before exiting...
                    foreach (var theThread in killerThreads)
                    {
                        theThread.Join();
                    }

                    cancelled = true;
                }
            }

            //clear any remaining messages -- these are almost certainly
            //execeptions due to thread cancellation
            //queryOutInfo.Clear();
        }


        //TODO: Monostate pattern to be investigated (class is never instantiated)
        private class ParamServer
        {
            private static int _currentRow;
            private static int _numRows;

            //The actual params that will be filled
            private static SqlParameter[] _outputParams;
            //Map the param columns to ordinals in the data table
            private static int[] _paramDtMappings;
            private static DataTable _theParams;

            public static void GetNextRow_Values(SqlParameterCollection newParam)
            {
                var rowNum = Interlocked.Increment(ref _currentRow);
                var dr = _theParams.Rows[rowNum % _numRows];

                for (var i = 0; i < _outputParams.Length; i++)
                {
                    newParam[i].Value = dr[_paramDtMappings[i]];
                }
            }

            public static SqlParameter[] GetParams()
            {
                var newParam = new SqlParameter[_outputParams.Length];

                for (var i = 0; i < _outputParams.Length; i++)
                {
                    newParam[i] = (SqlParameter) ((ICloneable) _outputParams[i]).Clone();
                }

                return newParam;
            }

            public static void Initialize(string paramQuery, string connString, Dictionary<string, string> paramMappings)
            {
                var a = new SqlDataAdapter(paramQuery, connString);
                _theParams = new DataTable();
                a.Fill(_theParams);

                _numRows = _theParams.Rows.Count;

                _outputParams = new SqlParameter[paramMappings.Keys.Count];
                _paramDtMappings = new int[paramMappings.Keys.Count];

                //Populate the array of parameters that will be cloned and filled
                //on each request
                var i = 0;
                foreach (var parameterName in paramMappings.Keys)
                {
                    _outputParams[i] = new SqlParameter {ParameterName = parameterName};
                    var paramColumn = paramMappings[parameterName];

                    //if there is a param mapped to this column
                    if (paramColumn != null)
                        _paramDtMappings[i] = _theParams.Columns[paramColumn].Ordinal;

                    i++;
                }
            }
        }

        private class QueryInput
        {
            [ThreadStatic] private static QueryOutput _outInfo;

            private static bool _runCancelled;
            //This regex is used to find the number of logical reads
            //in the messages collection returned in the queryOutput class
            private static readonly Regex FindReads = new Regex(@"(?:Table \'\w{1,}\'. Scan count \d{1,}, logical reads )(\d{1,})", RegexOptions.Compiled);

            //This regex is used to find the CPU and elapsed time
            //in the messages collection returned in the queryOutput class
            private static readonly Regex FindTimes =
                new Regex(
                    @"(?:SQL Server Execution Times:|SQL Server parse and compile time:)(?:\s{1,}CPU time = )(\d{1,})(?: ms,\s{1,}elapsed time = )(\d{1,})",
                    RegexOptions.Compiled);

            private readonly SqlCommand _queryComm;

            private readonly SqlCommand _statsComm;

            //private static Dictionary<int, List<string>> theInfoMessages = new Dictionary<int, List<string>>();

            private readonly Stopwatch _sw = new Stopwatch();
            private readonly bool _forceDataRetrieval;
            //          private readonly Queue<queryOutput> queryOutInfo;
            private readonly int _iterations;

            public QueryInput(SqlCommand statsComm, SqlCommand queryComm,
//                Queue<queryOutput> queryOutInfo,
                int iterations, bool forceDataRetrieval)
            {
                _statsComm = statsComm;
                _queryComm = queryComm;
//                this.queryOutInfo = queryOutInfo;
                _iterations = iterations;
                _forceDataRetrieval = forceDataRetrieval;

                //Prepare the infoMessages collection, if we are collecting statistics
                //if (stats_comm != null)
                //    theInfoMessages.Add(stats_comm.Connection.GetHashCode(), new List<string>());
            }

            public static bool RunCancelled
            {
                set { _runCancelled = value; }
            }

            private static void GetInfoMessages(object sender, SqlInfoMessageEventArgs args)
            {
                foreach (SqlError err in args.Errors)
                {
                    var matches = FindReads.Split(err.Message);

                    //we have a read
                    if (matches.Length > 1)
                    {
                        _outInfo.LogicalReads += Convert.ToInt32(matches[1]);
                        continue;
                    }

                    matches = FindTimes.Split(err.Message);

                    //we have times
                    if (matches.Length > 1)
                    {
                        _outInfo.CpuTime += Convert.ToInt32(matches[1]);
                        _outInfo.ElapsedTime += Convert.ToInt32(matches[2]);
                    }
                }
            }

            public void StartLoadThread()
            {
                try
                {
                    //do the work
                    using (var conn = _queryComm.Connection)
                    {
                        SqlInfoMessageEventHandler handler = GetInfoMessages;

                        for (var i = 0; i < _iterations; i++)
                        {
                            if (_runCancelled)
                                throw new Exception();

                            Exception outException = null;

                            try
                            {
                                //initialize the outInfo structure
                                _outInfo = new QueryOutput();

                                conn.Open();

                                //set up the statistics gathering
                                if (_statsComm != null)
                                {
                                    _statsComm.ExecuteNonQuery();
                                    Thread.Sleep(0);
                                    conn.InfoMessage += handler;
                                }

                                //Params are assigned only once -- after that, their values are dynamically retrieved
                                if (_queryComm.Parameters.Count > 0)
                                {
                                    ParamServer.GetNextRow_Values(_queryComm.Parameters);
                                }

                                _sw.Start();

                                //TODO: This could be made better
                                if (_forceDataRetrieval)
                                {
                                    var reader = _queryComm.ExecuteReader();
                                    Thread.Sleep(0);

                                    do
                                    {
                                        Thread.Sleep(0);

                                        while (reader.Read())
                                        {
                                            //grab the first column to force the row down the pipe
                                            var x = reader[0];
                                            Thread.Sleep(0);
                                        }
                                    } while (reader.NextResult());
                                }
                                else
                                {
                                    _queryComm.ExecuteNonQuery();
                                    Thread.Sleep(0);
                                }

                                _sw.Stop();
                            }
                            catch (Exception e)
                            {
                                if (_runCancelled)
                                    throw;
                                else
                                    outException = e;

                                if (_sw.IsRunning)
                                {
                                    _sw.Stop();
                                }
                            }
                            finally
                            {
                                //Clean up the connection
                                if (_statsComm != null)
                                    conn.InfoMessage -= handler;
                            }

                            var finished = i == _iterations - 1;

                            //List<string> infoMessages = null;

                            //infoMessages = (stats_comm != null) ? theInfoMessages[connectionHashCode] : null;

                            /*
                            queryOutput theout = new queryOutput(
                                outException,
                                sw.Elapsed,
                                finished,
                                (infoMessages == null || infoMessages.Count == 0) ? null : infoMessages.ToArray());
                             */

                            _outInfo.E = outException;
                            _outInfo.Time = _sw.Elapsed;
                            _outInfo.Finished = finished;

                            lock (QueryOutInfo)
                            {
                                QueryOutInfo.Enqueue(_outInfo);
                                Monitor.Pulse(QueryOutInfo);
                            }

                            //Prep the collection for the next round
                            //if (infoMessages != null && infoMessages.Count > 0)
                            //    infoMessages.Clear();

                            _sw.Reset();
                        }
                    }
                }
                catch
                {
                    if (_runCancelled)
                    {
                        //queryOutput theout = new queryOutput(null, new TimeSpan(0), true, null);
                        _outInfo.Time = new TimeSpan(0);
                        _outInfo.Finished = true;

                        lock (QueryOutInfo)
                        {
                            QueryOutInfo.Enqueue(_outInfo);
                        }
                    }
                    else
                        throw;
                }
            }
        }

        public class QueryOutput
        {
            public int CpuTime;
            public Exception E;
            public int ElapsedTime;
            public bool Finished;
            public int LogicalReads;
            public TimeSpan Time;

            /*
            public queryOutput(
                Exception e, 
                TimeSpan time, 
                bool finished,
                string[] infoMessages)
            {
                this.e = e;
                this.time = time;
                this.finished = finished;
                this.infoMessages = infoMessages;
            }
             */
        }

        private class ThreadKiller
        {
            private readonly SqlCommand[] _theCommands;
            private readonly Thread[] _theThreads;

            public ThreadKiller(Thread[] theThreads, SqlCommand[] theCommands)
            {
                _theThreads = theThreads;
                _theCommands = theCommands;
            }

            public void KillEm()
            {
                foreach (var comm in _theCommands)
                {
                    comm.Cancel();
                    comm.Connection.Dispose();
                    comm.Connection = null;
                    comm.Dispose();
                    Thread.Sleep(0);
                }

                var keepKilling = true;

                while (keepKilling)
                {
                    keepKilling = false;

                    foreach (var theThread in _theThreads)
                    {
                        if (theThread.IsAlive)
                        {
                            keepKilling = true;
                            theThread.Abort();
                            Thread.Sleep(0);
                        }
                    }
                }
            }
        }
    }
}