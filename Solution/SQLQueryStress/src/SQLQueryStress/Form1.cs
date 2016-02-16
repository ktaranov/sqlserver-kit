#region

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Windows.Forms;
using SQLQueryStress.Properties;

#endregion

/*********************************************
TODO, version 1.0::::
 * figure out how to capture change of selection in parameter definer
 * Bug: Dotfuscated version crashes in some cases (need to verify this)
 * Bug: Dotfuscated version can't load non-dotfuscated .sqlstress files
 * 
 * Throw a message box if param database has not been selected, or if can't connect (if parameterization is on)
 * repaint exception window when datatable is updated
  * Bug w/ stats sometimes going blank ??
 *********************************************/

namespace SQLQueryStress
{
    public partial class Form1 : Form
    {
        private const string Dashes = "---";

        //Has this run been cancelled?
        private bool _cancelled;
        //Exceptions that occurred
        private Dictionary<string, int> _exceptions;

        //The exception viewer window
        private DataViewer _exceptionViewer;
        //Exit as soon as cancellation is finished?
        private bool _exitOnComplete;

        /* Configuration local */
        private QueryStressSettings _settings = new QueryStressSettings();

        //start of the load
        private TimeSpan _start;
        //total CPU time in milliseconds
        private double _totalCpuTime;

        //total elapsed time in milliseconds
        private double _totalElapsedTime;

        //total exceptions
        private int _totalExceptions;

        //threads * iterations
        private int _totalExpectedIterations;
        /* Runtime locals */

        //total iterations that have run
        private int _totalIterations;

        //Same comments as above for these two...
        private double _totalLogicalReads;
        private int _totalReadMessages;

        //This is the total time as reported by the client
        private double _totalTime;
        //Number of query requests that returned time messages
        //Note:: Average times will be computed by:
        // A) Add up all results from time messages returned by 
        //    each query output
        // B) If the query returned one or more time messages,
        //    increment the totalTimeMessages counter
        // C) Add the TOTAL of all messages to the total counters
        // D) Divide to find the actual time
        //TODO: Find out why elapsed time is not accurate in 
        //some cases.  For instance, look at time reported for
        //WAITFOR DELAY '00:00:05'  (1300 ms?? WTF??)
        private int _totalTimeMessages;

        public Form1(string configFile) : this()
        {
            OpenConfigFile(configFile);
        }

        public Form1()
        {
            InitializeComponent();

            saveFileDialog1.DefaultExt = "sqlstress";
            saveFileDialog1.Filter = @"SQLQueryStress Configuration Files|*.sqlstress";
            saveFileDialog1.FileOk += saveFileDialog1_FileOk;

            openFileDialog1.DefaultExt = "sqlstress";
            openFileDialog1.Filter = @"SQLQueryStress Configuration Files|*.sqlstress";
            openFileDialog1.FileOk += openFileDialog1_FileOk;
        }

        private void aboutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var a = new AboutBox();
            a.ShowDialog();
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            ((LoadEngine) e.Argument).StartLoad(backgroundWorker1);
        }

        private void backgroundWorker1_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            var output = (LoadEngine.QueryOutput) e.UserState;

            _totalIterations++;

            if (output.LogicalReads > 0)
            {
                _totalReadMessages++;
                _totalLogicalReads += output.LogicalReads;
            }

            if (output.ElapsedTime > 0)
            {
                _totalTimeMessages++;
                _totalCpuTime += output.CpuTime;
                _totalElapsedTime += output.ElapsedTime;
            }

            _totalTime += output.Time.TotalMilliseconds;

            if (output.E != null)
            {
                _totalExceptions++;
                string theMessage;

                //strip the time stats, if they showed up as part
                //of the exception
                if (_settings.CollectTimeStats)
                {
                    var matchPos = output.E.Message.IndexOf("SQL Server parse and compile time:", StringComparison.Ordinal);

                    theMessage = matchPos > -1 ? output.E.Message.Substring(0, matchPos - 2) : output.E.Message;
                }
                else
                {
                    theMessage = output.E.Message;
                }

                if (!_exceptions.ContainsKey(theMessage))
                {
                    _exceptions.Add(theMessage, 1);
                }
                else
                {
                    _exceptions[theMessage] += 1;
                }

                //TODO: Get this working? -- Repaint exceptions as they occur?
                /*
                if ((exceptionViewer != null) && (exceptionViewer.WindowState == FormWindowState.Normal))
                {
                    exceptionViewer.Invoke(new System.Threading.ThreadStart(exceptionViewer.Repaint));
                }
                 */
            }
        }

        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            mainUITimer.Stop();

            UpdateUi();

            go_button.Enabled = true;
            cancel_button.Enabled = false;
            threads_numericUpDown.Enabled = true;
            iterations_numericUpDown.Enabled = true;

            if (!_cancelled)
                progressBar1.Value = 100;

            ((BackgroundWorker) sender).Dispose();

            db_label.Text = "";

            if (_exitOnComplete)
            {
                Dispose();
            }
        }

        private void cancel_button_Click(object sender, EventArgs e)
        {
            cancel_button.Enabled = false;

            backgroundWorker1.CancelAsync();

            _cancelled = true;

            if (sender is string)
            {
                _exitOnComplete = true;
            }
        }

        private void database_button_Click(object sender, EventArgs e)
        {
            var dbselect = new DatabaseSelect(_settings) {StartPosition = FormStartPosition.CenterParent};
            dbselect.ShowDialog();
        }

        private void exceptions_button_Click(object sender, EventArgs e)
        {
            totalExceptions_textBox_Click(null, null);
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void go_button_Click(object sender, EventArgs e)
        {
            if (!_settings.MainDbConnectionInfo.TestConnection())
            {
                MessageBox.Show(Resources.MustSetValidDbConnInfo);
                return;
            }

            _cancelled = false;
            _exitOnComplete = false;

            _exceptions = new Dictionary<string, int>();

            _totalIterations = 0;
            _totalTime = 0;
            _totalCpuTime = 0;
            _totalElapsedTime = 0;
            _totalTimeMessages = 0;
            _totalLogicalReads = 0;
            _totalReadMessages = 0;
            _totalExceptions = 0;

            iterationsSecond_textBox.Text = "0";
            avgSeconds_textBox.Text = "0.0";
            actualSeconds_textBox.Text = Dashes;
            cpuTime_textBox.Text = Dashes;
            logicalReads_textBox.Text = Dashes;
            go_button.Enabled = false;
            cancel_button.Enabled = true;
            iterations_numericUpDown.Enabled = false;
            threads_numericUpDown.Enabled = false;

            progressBar1.Value = 0;

            SaveSettingsFromForm1();

            _totalExpectedIterations = _settings.NumThreads * _settings.NumIterations;

            var paramConnectionInfo = _settings.ShareDbSettings ? _settings.MainDbConnectionInfo : _settings.ParamDbConnectionInfo;
            db_label.Text = "" + "Server: " + paramConnectionInfo.Server +
                            (paramConnectionInfo.Database.Length > 0 ? "  //  Database: " + paramConnectionInfo.Database : "");

            var engine = new LoadEngine(_settings.MainDbConnectionInfo.ConnectionString, _settings.MainQuery, _settings.NumThreads, _settings.NumIterations,
                _settings.ParamQuery, _settings.ParamMappings, paramConnectionInfo.ConnectionString, _settings.CommandTimeout, _settings.CollectIoStats,
                _settings.CollectTimeStats, _settings.ForceDataRetrieval);
            backgroundWorker1.RunWorkerAsync(engine);

            _start = new TimeSpan(DateTime.Now.Ticks);

            mainUITimer.Start();
        }

        private void loadSettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            openFileDialog1.ShowDialog();
        }

        private void mainUITimer_Tick(object sender, EventArgs e)
        {
            UpdateUi();
        }

        private void OpenConfigFile(string fileName)
        {
            FileStream fs = null;

            try
            {
                fs = new FileStream(fileName, FileMode.Open);
                var bf = new BinaryFormatter();

                _settings = (QueryStressSettings) bf.Deserialize(fs);
            }
            catch
            {
                MessageBox.Show(Resources.ErrLoadingSettings);
            }
            finally
            {
                if (fs != null)
                    fs.Dispose();
            }

            query_textBox.Text = _settings.MainQuery;
            threads_numericUpDown.Value = _settings.NumThreads;
            iterations_numericUpDown.Value = _settings.NumIterations;
        }

        private void openFileDialog1_FileOk(object sender, EventArgs e)
        {
            OpenConfigFile(openFileDialog1.FileName);
        }

        private void optionsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var options = new Options(_settings);
            options.ShowDialog();
        }

        private void param_button_Click(object sender, EventArgs e)
        {
            var p = new ParamWindow(_settings, query_textBox.Text) {StartPosition = FormStartPosition.CenterParent};
            p.ShowDialog();
        }

        private void saveFileDialog1_FileOk(object sender, EventArgs e)
        {
            FileStream fs = null;

            try
            {
                fs = new FileStream(saveFileDialog1.FileName, FileMode.Create);
                var bf = new BinaryFormatter();

                bf.Serialize(fs, _settings);
            }
            catch
            {
                MessageBox.Show(Resources.ErrorSavingSettings);
            }
            finally
            {
                if (fs != null)
                    fs.Dispose();
            }
        }

        private void SaveSettingsFromForm1()
        {
            _settings.MainQuery = query_textBox.Text;
            _settings.NumThreads = (int) threads_numericUpDown.Value;
            _settings.NumIterations = (int) iterations_numericUpDown.Value;
        }

        private void saveSettingsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SaveSettingsFromForm1();
            saveFileDialog1.ShowDialog();
        }

        private void totalExceptions_textBox_Click(object sender, EventArgs e)
        {
            _exceptionViewer = new DataViewer {StartPosition = FormStartPosition.CenterParent, Text = Resources.Exceptions};



            var dt = new DataTable();
            dt.Columns.Add("Count");
            dt.Columns.Add("Exception");

            if (_exceptions != null)
            {
                var values = _exceptions.Values.GetEnumerator();

                foreach (var ex in _exceptions.Keys)
                {
                    values.MoveNext();
                    var count = values.Current;
                    dt.Rows.Add(count, ex);
                }
            }

            _exceptionViewer.DataView = dt;

            _exceptionViewer.ShowDialog();
        }

        private void UpdateUi()
        {
            iterationsSecond_textBox.Text = _totalIterations.ToString();
            var avgIterations = _totalIterations == 0 ? 0.0 : _totalTime / _totalIterations / 1000;
            var avgCpu = _totalTimeMessages == 0 ? 0.0 : _totalCpuTime / _totalTimeMessages / 1000;
            var avgActual = _totalTimeMessages == 0 ? 0.0 : _totalElapsedTime / _totalTimeMessages / 1000;
            var avgReads = _totalReadMessages == 0 ? 0.0 : _totalLogicalReads / _totalReadMessages;

            avgSeconds_textBox.Text = avgIterations.ToString("0.0000");
            cpuTime_textBox.Text = _totalTimeMessages == 0 ? "---" : avgCpu.ToString("0.0000");
            actualSeconds_textBox.Text = _totalTimeMessages == 0 ? "---" : avgActual.ToString("0.0000");
            logicalReads_textBox.Text = _totalReadMessages == 0 ? "---" : avgReads.ToString("0.0000");

            totalExceptions_textBox.Text = _totalExceptions.ToString();
            progressBar1.Value = (int) (_totalIterations / (decimal) _totalExpectedIterations * 100);

            var end = new TimeSpan(DateTime.Now.Ticks);
            end = end.Subtract(_start);

            var theTime = end.ToString();

            //Some systems return "hh:mm:ss" instead of "hh:mm:ss.0000" if
            //there is no fractional part of the second.  I'm not sure
            //why, but this fixes it for now.
            if (theTime.Length > 8)
                elapsedTime_textBox.Text = theTime.Substring(0, 13);
            else
                elapsedTime_textBox.Text = theTime + ".0000";
        }

        [Serializable]
        public class QueryStressSettings
        {
            /// <summary>
            ///     Collect I/O stats?
            /// </summary>
            public bool CollectIoStats;

            /// <summary>
            ///     Collect time stats?
            /// </summary>
            public bool CollectTimeStats;

            /// <summary>
            ///     command timeout
            /// </summary>
            public int CommandTimeout;

            /// <summary>
            ///     Connection Timeout
            /// </summary>
            public int ConnectionTimeout;

            /// <summary>
            ///     Enable pooling?
            /// </summary>
            public bool EnableConnectionPooling;

            /// <summary>
            ///     Force the client to retrieve all data?
            /// </summary>
            public bool ForceDataRetrieval;

            /// <summary>
            ///     Connection info for the DB in which to run the test
            /// </summary>
            public DatabaseSelect.ConnectionInfo MainDbConnectionInfo;

            /// <summary>
            ///     main query to test
            /// </summary>
            public string MainQuery;

            /// <summary>
            ///     Number of iterations to run per thread
            /// </summary>
            public int NumIterations;

            /// <summary>
            ///     Number of threads to test with
            /// </summary>
            public int NumThreads;

            /// <summary>
            ///     Connection info for the DB from which to get the paramaters
            /// </summary>
            public DatabaseSelect.ConnectionInfo ParamDbConnectionInfo;

            /// <summary>
            ///     mapped parameters
            /// </summary>
            public Dictionary<string, string> ParamMappings;

            /// <summary>
            ///     query from which to take parameters
            /// </summary>
            public string ParamQuery;

            /// <summary>
            ///     Should the main db and param db share the same settings?
            ///     If so, use main db settings for the params
            /// </summary>
            public bool ShareDbSettings;

            public QueryStressSettings()
            {
                MainDbConnectionInfo = new DatabaseSelect.ConnectionInfo(this);
                ShareDbSettings = true;
                ParamDbConnectionInfo = new DatabaseSelect.ConnectionInfo();
                MainQuery = "";
                ParamQuery = "";
                NumThreads = 1;
                NumIterations = 1;
                ParamMappings = new Dictionary<string, string>();
                ConnectionTimeout = 15;
                CommandTimeout = 0;
                EnableConnectionPooling = true;
                CollectIoStats = true;
                CollectTimeStats = true;
                ForceDataRetrieval = false;
            }

            [OnDeserialized]
            private void FixSettings(StreamingContext context)
            {
                ConnectionTimeout = ConnectionTimeout == 0 ? 15 : ConnectionTimeout;
            }
        }

        private void btnCleanBuffer_Click(object sender, EventArgs e)
        {
            MessageBox.Show(LoadEngine.ExecuteCommand(_settings.MainDbConnectionInfo.ConnectionString, "DBCC DROPCLEANBUFFERS")
                ? "Buffers cleared"
                : "Errors encountered");
        }

        private void btnFreeCache_Click(object sender, EventArgs e)
        {
            MessageBox.Show(LoadEngine.ExecuteCommand(_settings.MainDbConnectionInfo.ConnectionString, "DBCC FREEPROCCACHE")
                ? "Cache freed"
                : "Errors encountered");
        }
    }
}