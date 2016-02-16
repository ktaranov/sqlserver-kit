#region

using System;
using System.Data;
using System.Windows.Forms;

#endregion

namespace SQLQueryStress
{
    public partial class DataViewer : Form
    {
        public DataViewer()
        {
            InitializeComponent();
        }

        public DataTable DataView { get; set; }

        private void Form2_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = DataView;

            var columnWidth = (dataGridView1.Width - 41) / DataView.Columns.Count;

            foreach (DataGridViewColumn col in dataGridView1.Columns)
                col.Width = columnWidth;
        }

        public void Repaint()
        {
            dataGridView1.Invalidate();
        }
    }
}