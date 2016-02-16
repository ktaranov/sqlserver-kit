#region

using System;
using System.Windows.Forms;

#endregion

namespace SQLQueryStress
{
    public partial class Options : Form
    {
        private readonly Form1.QueryStressSettings _settings;

        public Options(Form1.QueryStressSettings settings)
        {
            _settings = settings;

            InitializeComponent();

            connectionTimeout_numericUpDown.Value = settings.ConnectionTimeout;
            commandTimeout_numericUpDown.Value = settings.CommandTimeout;
            connectionPooling_checkBox.Checked = settings.EnableConnectionPooling;
            IOStatistics_checkBox.Checked = settings.CollectIoStats;
            timeStatistics_checkBox.Checked = settings.CollectTimeStats;
            clientDataRetrieval_checkBox.Checked = settings.ForceDataRetrieval;
        }

        private void cancel_button_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void ok_button_Click(object sender, EventArgs e)
        {
            _settings.ConnectionTimeout = (int) connectionTimeout_numericUpDown.Value;
            _settings.CommandTimeout = (int) commandTimeout_numericUpDown.Value;
            _settings.EnableConnectionPooling = connectionPooling_checkBox.Checked;
            _settings.CollectIoStats = IOStatistics_checkBox.Checked;
            _settings.CollectTimeStats = timeStatistics_checkBox.Checked;
            _settings.ForceDataRetrieval = clientDataRetrieval_checkBox.Checked;

            Dispose();
        }
    }
}