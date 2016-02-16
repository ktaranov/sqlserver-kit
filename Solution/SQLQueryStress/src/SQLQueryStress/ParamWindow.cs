#region

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using SQLQueryStress.Properties;

#endregion

namespace SQLQueryStress
{
    public partial class ParamWindow : Form
    {
        //load query defined in the main form
        private readonly string _outerQuery;

        //parameter values from the parameter query defined in this form
        private readonly Dictionary<string, string> _paramValues = new Dictionary<string, string>();

        //Query Stress Settings
        private readonly Form1.QueryStressSettings _settings;

        //Variables from the load query
        private string[] _queryVariables;

        public ParamWindow(Form1.QueryStressSettings settings, string outerQuery)
        {
            InitializeComponent();

            _settings = settings;

            _outerQuery = outerQuery;

            paramQueryTextBox.Text = (string) settings.ParamQuery.Clone();

            columnMapGrid.Columns[0].SortMode = DataGridViewColumnSortMode.NotSortable;
            columnMapGrid.Columns[1].SortMode = DataGridViewColumnSortMode.NotSortable;
            columnMapGrid.Columns[2].SortMode = DataGridViewColumnSortMode.NotSortable;

            //TODO: Which event to handle?!?!
            columnMapGrid.CellEndEdit += columnMapGrid_CellValueChanged;

            if ((outerQuery.Length > 0) && (paramQueryTextBox.Text.Length > 0))
            {
                getColumnsButton_Click("constructor", null);
            }
        }

        private void cancelButton_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void columnMapGrid_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            //handle changes to the parameter column
            if (e.ColumnIndex == 2)
            {
                var theRow = columnMapGrid.Rows[e.RowIndex];
                var combo = (DataGridViewComboBoxCell) theRow.Cells[2];

                if (combo.Value != null)
                {
                    var colType = _paramValues[(string) combo.Value];
                    theRow.Cells[1].Value = colType;
                }
                else
                {
                    theRow.Cells[1].Value = "";
                }
            }
        }

        private void database_button_Click(object sender, EventArgs e)
        {
            var dbSelect = new DatabaseSelect(_settings) {StartPosition = FormStartPosition.CenterParent};
            dbSelect.ShowDialog();
        }

        private void getColumnsButton_Click(object sender, EventArgs e)
        {
            _queryVariables = GetParams();

            SqlDataReader reader = null;

            var dbInfo = _settings.ShareDbSettings ? _settings.MainDbConnectionInfo : _settings.ParamDbConnectionInfo;

            if (!dbInfo.TestConnection())
            {
                MessageBox.Show(Resources.MustSetValidDatabaseConn);
                return;
            }

            using (var conn = new SqlConnection(dbInfo.ConnectionString))
            {
                try
                {
                    var comm = new SqlCommand(paramQueryTextBox.Text, conn);
                    conn.Open();
                    reader = comm.ExecuteReader(CommandBehavior.SchemaOnly);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                if (reader != null)
                {
                    columnMapGrid.Rows.Clear();
                    _paramValues.Clear();

                    for (var i = 0; i < reader.FieldCount; i++)
                    {
                        _paramValues.Add(reader.GetName(i), reader.GetDataTypeName(i));
                    }

                    reader.Dispose();

                    foreach (var variable in _queryVariables)
                    {
                        var colOrdinal = columnMapGrid.Rows.Add();
                        var row = columnMapGrid.Rows[colOrdinal];
                        row.Cells[0].Value = variable;
                        row.Cells[0].ReadOnly = true;

                        //placeholder for columntype
                        row.Cells[1].Value = "";
                        row.Cells[1].ReadOnly = true;

                        var combo = new DataGridViewComboBoxCell();

                        combo.Items.Add("");

                        string s = sender as string;
                        bool checkParam = s != null && s == "constructor" && _settings.ParamMappings.ContainsKey(variable);

                        foreach (var paramName in _paramValues.Keys)
                        {
                            combo.Items.Add(paramName);

                            if (checkParam)
                            {
                                if (_settings.ParamMappings[variable] == paramName)
                                {
                                    combo.Value = paramName;
                                    row.Cells[1].Value = _paramValues[paramName];
                                }
                            }
                        }

                        row.Cells[2] = combo;
                    }
                }
            }
        }

        private string[] GetParams()
        {
            //Find all SQL variables:
            //'@', preceeded by '=', ',', or any white space character
            //then, any "word" character
            //Finally, '=', ',', or any white space, repeated 0 or more times 
            //(in the case of end-of-string, will be 0 times)
            var r = new Regex(@"(?<=[=,\s\(])@\w{1,}(?=[=,\s\)]?)");

            var output = new List<string>();

            foreach (Match m in r.Matches(_outerQuery))
            {
                var lowerVal = m.Value.ToLower();
                if (!output.Contains(lowerVal))
                    output.Add(m.Value.ToLower());
            }

            if (output.Count == 0)
                MessageBox.Show(Resources.NoVarsWereIdentified);

            return output.ToArray();
        }

        private void okButton_Click(object sender, EventArgs e)
        {
            _settings.ParamQuery = paramQueryTextBox.Text;

            var localParamMappings = new Dictionary<string, string>();
            foreach (DataGridViewRow row in columnMapGrid.Rows)
            {
                if ((string) row.Cells[2].Value != "")
                    localParamMappings.Add((string) row.Cells[0].Value, (string) row.Cells[2].Value);
            }

            _settings.ParamMappings = localParamMappings;

            Dispose();
        }
    }
}