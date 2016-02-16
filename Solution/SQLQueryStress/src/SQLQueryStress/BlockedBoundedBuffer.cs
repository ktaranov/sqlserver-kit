#region

using System.Threading;

#endregion

namespace SQLQueryStress
{
    public class BlockedBoundedBuffer<T>
    {
        private readonly T[] _buffer;
        private int _count;

        private int _readNumber;
        private int _writeNumber;

        public BlockedBoundedBuffer(int bufferSize)
        {
            _buffer = new T[bufferSize];
            _readNumber = -1;
            _writeNumber = -1;
            _count = 0;
        }

        public T Dequeue()
        {
            while (_count == 0)
            {
                lock (_buffer)
                {
                    Monitor.Wait(_buffer);
                }
            }

            int read;

            do
            {
                read = Interlocked.Increment(ref _readNumber);

                if (read >= _buffer.Length)
                {
                    lock (_buffer)
                    {
                        if (read >= _buffer.Length)
                        {
                            Interlocked.Exchange(ref _readNumber, 0);
                            Interlocked.Exchange(ref _writeNumber, -1);
                            Monitor.PulseAll(_buffer);
                        }
                    }
                }
                else
                    break;
            } while (true);

            Interlocked.Decrement(ref _count);

            return _buffer[read];
        }

        public void Enqueue(T input)
        {
            int write;

            do
            {
                write = Interlocked.Increment(ref _writeNumber);
                if (write >= _buffer.Length)
                {
                    lock (_buffer)
                    {
                        Monitor.Wait(_buffer);
                    }
                }
                else
                    break;
            } while (true);

            _buffer[write] = input;

            if (Interlocked.Increment(ref _count) == 1)
            {
                lock (_buffer)
                {
                    Monitor.PulseAll(_buffer);
                }
            }
        }
    }
}