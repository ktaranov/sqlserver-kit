#region

using System;
using System.Windows.Forms;

#endregion

namespace SQLQueryStress
{
    internal static class Program
    {
        /// <summary>
        ///     The main entry point for the application.
        /// </summary>
        [STAThread]
        private static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            Form1 f = args.Length > 0 ? new Form1(args[0]) : new Form1();

            f.StartPosition = FormStartPosition.CenterScreen;
            Application.Run(f);
        }
    }
}