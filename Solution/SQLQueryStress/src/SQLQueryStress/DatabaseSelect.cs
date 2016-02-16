#region

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Windows.Forms;
using SQLQueryStress.Properties;

#endregion

namespace SQLQueryStress
{
    public partial class DatabaseSelect : Form
    {
        private readonly ConnectionInfo _localMainConnectionInfo;
        private readonly Form1.QueryStressSettings _settings;
        private ConnectionInfo _localParamConnectionInfo;

        public DatabaseSelect(Form1.QueryStressSettings settings)
        {
            _settings = settings;
            _localMainConnectionInfo = (ConnectionInfo) settings.MainDbConnectionInfo.Clone();

            if (settings.ShareDbSettings)
            {
                _localParamConnectionInfo = (ConnectionInfo) settings.MainDbConnectionInfo.Clone();
            }
            else
            {
                _localParamConnectionInfo = (ConnectionInfo) settings.ParamDbConnectionInfo.Clone();
            }

            InitializeComponent();

            server_textBox.Text = _localMainConnectionInfo.Server;

            if (_localMainConnectionInfo.IntegratedAuth)
            {
                authentication_comboBox.SelectedIndex = 0;
                login_textBox.Enabled = false;
                password_textBox.Enabled = false;
            }
            else
            {
                authentication_comboBox.SelectedIndex = 1;
                login_textBox.Text = _localMainConnectionInfo.Login;
                password_textBox.Text = _localMainConnectionInfo.Password;
            }

            if (_localMainConnectionInfo.Database.Length > 0)
            {
                db_comboBox.Items.Add(_localMainConnectionInfo.Database);
                db_comboBox.SelectedIndex = 0;
            }

            if (!settings.ShareDbSettings)
            {
                pm_server_textBox.Text = _localParamConnectionInfo.Server;

                if (_localParamConnectionInfo.IntegratedAuth)
                {
                    pm_authentication_comboBox.SelectedIndex = 0;
                    pm_login_textBox.Enabled = false;
                    pm_password_textBox.Enabled = false;
                }
                else
                {
                    pm_authentication_comboBox.SelectedIndex = 1;
                    pm_login_textBox.Text = _localParamConnectionInfo.Login;
                    pm_password_textBox.Text = _localParamConnectionInfo.Password;
                }

                if (_localParamConnectionInfo.Database.Length > 0)
                {
                    pm_db_comboBox.Items.Add(_localParamConnectionInfo.Database);
                    pm_db_comboBox.SelectedIndex = 0;
                }
            }
            else
                pm_authentication_comboBox.SelectedIndex = 0;

            shareSettings_checkBox.Checked = settings.ShareDbSettings;

            authentication_comboBox.SelectedIndexChanged += authentication_comboBox_SelectedIndexChanged;
            pm_authentication_comboBox.SelectedIndexChanged += pm_authentication_comboBox_SelectedIndexChanged;

            db_comboBox.Click += db_comboBox_Click;
            pm_db_comboBox.Click += pm_db_comboBox_Click;
        }

        private void authentication_comboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (authentication_comboBox.SelectedIndex == 0)
            {
                login_textBox.Enabled = false;
                password_textBox.Enabled = false;
            }
            else
            {
                login_textBox.Enabled = true;
                password_textBox.Enabled = true;
            }
        }

        private void cancel_button_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void db_comboBox_Click(object sender, EventArgs e)
        {
            SaveLocalSettings();

            var selectedItem = (string) db_comboBox.SelectedItem;

            var sql = "" + "SELECT name " + "FROM master..sysdatabases " + "ORDER BY name";

            using (var conn = new SqlConnection(_localMainConnectionInfo.ConnectionString))
            {
                var comm = new SqlCommand(sql, conn);

                var databases = new List<string>();

                try
                {
                    conn.Open();

                    var reader = comm.ExecuteReader();

                    while (reader.Read())
                    {
                        databases.Add((string) reader[0]);
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Number != 4060)
                        MessageBox.Show(Resources.ConnFail);
                    else
                    {
                        //Clear the db, try again
                        db_comboBox.Items.Clear();
                        db_comboBox_Click(null, null);
                        return;
                    }
                }

                db_comboBox.DataSource = databases.ToArray();

                if (selectedItem != null)
                    if (db_comboBox.Items.Contains(selectedItem))
                        db_comboBox.SelectedItem = selectedItem;
            }
        }

        private void ok_button_Click(object sender, EventArgs e)
        {
            SaveLocalSettings();
            pm_saveLocalSettings();

            _localMainConnectionInfo.CopyTo(_settings.MainDbConnectionInfo);
            _localParamConnectionInfo.CopyTo(_settings.ParamDbConnectionInfo);
            _settings.ShareDbSettings = shareSettings_checkBox.Checked;

            Dispose();
        }

        private void pm_authentication_comboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (pm_authentication_comboBox.SelectedIndex == 0)
            {
                pm_login_textBox.Enabled = false;
                pm_password_textBox.Enabled = false;
            }
            else
            {
                pm_login_textBox.Enabled = true;
                pm_password_textBox.Enabled = true;
            }
        }

        private void pm_db_comboBox_Click(object sender, EventArgs e)
        {
            pm_saveLocalSettings();

            var selectedItem = (string) pm_db_comboBox.SelectedItem;

            var sql = "" + "SELECT name " + "FROM master..sysdatabases " + "ORDER BY name";

            using (var conn = new SqlConnection(_localParamConnectionInfo.ConnectionString))
            {
                var comm = new SqlCommand(sql, conn);

                var databases = new List<string>();

                try
                {
                    conn.Open();

                    var reader = comm.ExecuteReader();

                    while (reader.Read())
                        databases.Add((string) reader[0]);
                }
                catch (SqlException ex)
                {
                    if (ex.Number != 4060)
                        MessageBox.Show(Resources.ConnFail);
                    else
                    {
                        //Clear the db, try again
                        pm_db_comboBox.Items.Clear();
                        pm_db_comboBox_Click(null, null);
                        return;
                    }
                }

                pm_db_comboBox.DataSource = databases.ToArray();

                if (selectedItem != null)
                    if (pm_db_comboBox.Items.Contains(selectedItem))
                        pm_db_comboBox.SelectedItem = selectedItem;
            }
        }

        private void pm_saveLocalSettings()
        {
            if (!shareSettings_checkBox.Checked)
            {
                _localParamConnectionInfo.Server = pm_server_textBox.Text;
                _localParamConnectionInfo.IntegratedAuth = pm_authentication_comboBox.SelectedIndex == 0;

                if (_localParamConnectionInfo.IntegratedAuth)
                {
                    _localParamConnectionInfo.Login = "";
                    _localParamConnectionInfo.Password = "";
                }
                else
                {
                    _localParamConnectionInfo.Login = pm_login_textBox.Text;
                    _localParamConnectionInfo.Password = pm_password_textBox.Text;
                }

                _localParamConnectionInfo.Database = pm_db_comboBox.SelectedItem != null ? pm_db_comboBox.SelectedItem.ToString() : "";
            }
            else
                _localParamConnectionInfo = new ConnectionInfo();
        }

        private void pm_test_button_Click(object sender, EventArgs e)
        {
            pm_saveLocalSettings();

            MessageBox.Show(_localParamConnectionInfo.TestConnection() ? Resources.ConnSucc : Resources.ConnFail);
        }

        private void SaveLocalSettings()
        {
            _localMainConnectionInfo.Server = server_textBox.Text;
            _localMainConnectionInfo.IntegratedAuth = authentication_comboBox.SelectedIndex == 0;

            if (_localMainConnectionInfo.IntegratedAuth)
            {
                _localMainConnectionInfo.Login = "";
                _localMainConnectionInfo.Password = "";
            }
            else
            {
                _localMainConnectionInfo.Login = login_textBox.Text;
                _localMainConnectionInfo.Password = password_textBox.Text;
            }

            _localMainConnectionInfo.Database = db_comboBox.SelectedItem != null ? db_comboBox.SelectedItem.ToString() : "";
        }

        private void shareSettings_checkBox_CheckedChanged(object sender, EventArgs e)
        {
            if (shareSettings_checkBox.Checked)
            {
                pm_server_textBox.Enabled = false;
                pm_authentication_comboBox.Enabled = false;
                pm_login_textBox.Enabled = false;
                pm_password_textBox.Enabled = false;
                pm_db_comboBox.Enabled = false;
                pm_test_button.Enabled = false;
            }
            else
            {
                pm_server_textBox.Enabled = true;
                pm_authentication_comboBox.Enabled = true;

                if (pm_authentication_comboBox.SelectedIndex == 1)
                {
                    pm_login_textBox.Enabled = true;
                    pm_password_textBox.Enabled = true;
                }
                pm_db_comboBox.Enabled = true;
                pm_test_button.Enabled = true;
            }
        }

        private void test_button_Click(object sender, EventArgs e)
        {
            SaveLocalSettings();

            MessageBox.Show(_localMainConnectionInfo.TestConnection() ? Resources.ConnSucc : Resources.ConnFail);
        }

        [Serializable]
        public class ConnectionInfo : ICloneable
        {
            public string Database;
            public bool IntegratedAuth;
            public string Login;
            public string Password;

            public string Server;
            public Form1.QueryStressSettings Settings;

            public ConnectionInfo()
            {
                Server = "";
                IntegratedAuth = true;
                Login = "";
                Password = "";
                Database = "";
            }

            public ConnectionInfo(Form1.QueryStressSettings settings)
            {
                Server = "";
                IntegratedAuth = true;
                Login = "";
                Password = "";
                Database = "";
                Settings = settings;
            }

            public string ConnectionString
            {
                get
                {
                    var build = new SqlConnectionStringBuilder {DataSource = Server, IntegratedSecurity = IntegratedAuth};
                    if (!IntegratedAuth)
                    {
                        build.UserID = Login;
                        build.Password = Password;
                    }

                    if (Database.Length > 0)
                        build.InitialCatalog = Database;

                    if (Settings != null)
                    {
                        build.ConnectTimeout = Settings.ConnectionTimeout;
                        build.Pooling = Settings.EnableConnectionPooling;
                        build.MaxPoolSize = Settings.NumThreads * 2;
                    }

                    return build.ConnectionString;
                }
            }

            #region ICloneable Members

            public object Clone()
            {
                var newConnInfo = new ConnectionInfo();
                CopyTo(newConnInfo);

                return newConnInfo;
            }

            #endregion

            public void CopyTo(ConnectionInfo to)
            {
                to.Server = Server;
                to.IntegratedAuth = IntegratedAuth;
                to.Login = Login;
                to.Password = Password;
                to.Database = Database;
            }

            public bool TestConnection()
            {
                if ((Server == "") || ((IntegratedAuth == false) && (Login == "" || Password == "")))
                    return false;

                using (var conn = new SqlConnection(ConnectionString))
                {
                    try
                    {
                        conn.Open();
                    }
                    catch
                    {
                        return false;
                    }
                }

                return true;
            }
        }
    }
}