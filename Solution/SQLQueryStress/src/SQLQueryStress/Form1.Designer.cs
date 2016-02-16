using System.Windows.Forms;

namespace SQLQueryStress
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (backgroundWorker1.CancellationPending)
                System.Windows.Forms.MessageBox.Show("Please wait while background threads are cancelled.");
            else if (backgroundWorker1.IsBusy)
            {
                if (System.Windows.Forms.MessageBox.Show(
                "A test is currently running.  Cancel and shut down?",
                "Really Close?",
                System.Windows.Forms.MessageBoxButtons.YesNo,
                System.Windows.Forms.MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
                {
                    cancel_button_Click(new System.String(' ', 0), null);
                }
            }
            else
            {
                if (disposing && (components != null))
                {
                    components.Dispose();
                }
                base.Dispose(disposing);
            }
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.query_textBox = new System.Windows.Forms.RichTextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.fileToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.optionsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveSettingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.loadSettingsToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.exitToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.helpToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.aboutToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.go_button = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.iterations_numericUpDown = new System.Windows.Forms.NumericUpDown();
            this.threads_numericUpDown = new System.Windows.Forms.NumericUpDown();
            this.cancel_button = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.backgroundWorker1 = new System.ComponentModel.BackgroundWorker();
            this.label5 = new System.Windows.Forms.Label();
            this.avgSeconds_textBox = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.totalExceptions_textBox = new System.Windows.Forms.Label();
            this.mainUITimer = new System.Windows.Forms.Timer(this.components);
            this.label8 = new System.Windows.Forms.Label();
            this.elapsedTime_textBox = new System.Windows.Forms.Label();
            this.perfCounterTimer = new System.Windows.Forms.Timer(this.components);
            this.database_button = new System.Windows.Forms.Button();
            this.iterationsSecond_textBox = new System.Windows.Forms.Label();
            this.exceptions_button = new System.Windows.Forms.Button();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.label9 = new System.Windows.Forms.Label();
            this.cpuTime_textBox = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.actualSeconds_textBox = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.logicalReads_textBox = new System.Windows.Forms.Label();
            this.db_label = new System.Windows.Forms.Label();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.tableLayoutPanel2 = new System.Windows.Forms.TableLayoutPanel();
            this.param_button = new System.Windows.Forms.Button();
            this.tableLayoutPanel4 = new System.Windows.Forms.TableLayoutPanel();
            this.btnFreeCache = new System.Windows.Forms.Button();
            this.btnCleanBuffer = new System.Windows.Forms.Button();
            this.tableLayoutPanel3 = new System.Windows.Forms.TableLayoutPanel();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.iterations_numericUpDown)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.threads_numericUpDown)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            this.tableLayoutPanel2.SuspendLayout();
            this.tableLayoutPanel4.SuspendLayout();
            this.tableLayoutPanel3.SuspendLayout();
            this.SuspendLayout();
            // 
            // query_textBox
            // 
            this.query_textBox.AcceptsTab = true;
            this.query_textBox.AllowDrop = true;
            this.query_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.query_textBox.Location = new System.Drawing.Point(3, 3);
            this.query_textBox.Name = "query_textBox";
            this.query_textBox.Size = new System.Drawing.Size(317, 354);
            this.query_textBox.TabIndex = 0;
            this.query_textBox.Text = "";
            this.query_textBox.WordWrap = false;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(9, 32);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(40, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Query";
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.SystemColors.MenuBar;
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.fileToolStripMenuItem,
            this.helpToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(733, 24);
            this.menuStrip1.TabIndex = 2;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // fileToolStripMenuItem
            // 
            this.fileToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripSeparator1,
            this.optionsToolStripMenuItem,
            this.saveSettingsToolStripMenuItem,
            this.loadSettingsToolStripMenuItem,
            this.exitToolStripMenuItem});
            this.fileToolStripMenuItem.Name = "fileToolStripMenuItem";
            this.fileToolStripMenuItem.Size = new System.Drawing.Size(37, 20);
            this.fileToolStripMenuItem.Text = "File";
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(142, 6);
            // 
            // optionsToolStripMenuItem
            // 
            this.optionsToolStripMenuItem.Name = "optionsToolStripMenuItem";
            this.optionsToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.optionsToolStripMenuItem.Text = "Options";
            this.optionsToolStripMenuItem.Click += new System.EventHandler(this.optionsToolStripMenuItem_Click);
            // 
            // saveSettingsToolStripMenuItem
            // 
            this.saveSettingsToolStripMenuItem.Name = "saveSettingsToolStripMenuItem";
            this.saveSettingsToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.saveSettingsToolStripMenuItem.Text = "Save Settings";
            this.saveSettingsToolStripMenuItem.Click += new System.EventHandler(this.saveSettingsToolStripMenuItem_Click);
            // 
            // loadSettingsToolStripMenuItem
            // 
            this.loadSettingsToolStripMenuItem.Name = "loadSettingsToolStripMenuItem";
            this.loadSettingsToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.loadSettingsToolStripMenuItem.Text = "Load Settings";
            this.loadSettingsToolStripMenuItem.Click += new System.EventHandler(this.loadSettingsToolStripMenuItem_Click);
            // 
            // exitToolStripMenuItem
            // 
            this.exitToolStripMenuItem.Name = "exitToolStripMenuItem";
            this.exitToolStripMenuItem.Size = new System.Drawing.Size(145, 22);
            this.exitToolStripMenuItem.Text = "Exit";
            this.exitToolStripMenuItem.Click += new System.EventHandler(this.exitToolStripMenuItem_Click);
            // 
            // helpToolStripMenuItem
            // 
            this.helpToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.aboutToolStripMenuItem});
            this.helpToolStripMenuItem.Name = "helpToolStripMenuItem";
            this.helpToolStripMenuItem.Size = new System.Drawing.Size(44, 20);
            this.helpToolStripMenuItem.Text = "Help";
            // 
            // aboutToolStripMenuItem
            // 
            this.aboutToolStripMenuItem.Name = "aboutToolStripMenuItem";
            this.aboutToolStripMenuItem.Size = new System.Drawing.Size(107, 22);
            this.aboutToolStripMenuItem.Text = "About";
            this.aboutToolStripMenuItem.Click += new System.EventHandler(this.aboutToolStripMenuItem_Click);
            // 
            // go_button
            // 
            this.go_button.Dock = System.Windows.Forms.DockStyle.Fill;
            this.go_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.go_button.Location = new System.Drawing.Point(3, 3);
            this.go_button.Name = "go_button";
            this.go_button.Size = new System.Drawing.Size(92, 40);
            this.go_button.TabIndex = 3;
            this.go_button.Text = "GO";
            this.go_button.UseVisualStyleBackColor = true;
            this.go_button.Click += new System.EventHandler(this.go_button_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(3, 152);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(196, 14);
            this.label2.TabIndex = 5;
            this.label2.Text = "Number of Iterations";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(3, 202);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(196, 14);
            this.label3.TabIndex = 7;
            this.label3.Text = "Number of Threads";
            // 
            // iterations_numericUpDown
            // 
            this.iterations_numericUpDown.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.iterations_numericUpDown.Location = new System.Drawing.Point(3, 169);
            this.iterations_numericUpDown.Maximum = new decimal(new int[] {
            100000,
            0,
            0,
            0});
            this.iterations_numericUpDown.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.iterations_numericUpDown.Name = "iterations_numericUpDown";
            this.iterations_numericUpDown.Size = new System.Drawing.Size(196, 20);
            this.iterations_numericUpDown.TabIndex = 8;
            this.iterations_numericUpDown.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // threads_numericUpDown
            // 
            this.threads_numericUpDown.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.threads_numericUpDown.Location = new System.Drawing.Point(3, 219);
            this.threads_numericUpDown.Maximum = new decimal(new int[] {
            200,
            0,
            0,
            0});
            this.threads_numericUpDown.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.threads_numericUpDown.Name = "threads_numericUpDown";
            this.threads_numericUpDown.Size = new System.Drawing.Size(196, 20);
            this.threads_numericUpDown.TabIndex = 9;
            this.threads_numericUpDown.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // cancel_button
            // 
            this.cancel_button.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cancel_button.Enabled = false;
            this.cancel_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cancel_button.Location = new System.Drawing.Point(101, 3);
            this.cancel_button.Name = "cancel_button";
            this.cancel_button.Size = new System.Drawing.Size(92, 40);
            this.cancel_button.TabIndex = 11;
            this.cancel_button.Text = "Cancel";
            this.cancel_button.UseVisualStyleBackColor = true;
            this.cancel_button.Click += new System.EventHandler(this.cancel_button_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(205, 152);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(196, 14);
            this.label4.TabIndex = 12;
            this.label4.Text = "Iterations Completed";
            // 
            // backgroundWorker1
            // 
            this.backgroundWorker1.WorkerReportsProgress = true;
            this.backgroundWorker1.WorkerSupportsCancellation = true;
            this.backgroundWorker1.DoWork += new System.ComponentModel.DoWorkEventHandler(this.backgroundWorker1_DoWork);
            this.backgroundWorker1.ProgressChanged += new System.ComponentModel.ProgressChangedEventHandler(this.backgroundWorker1_ProgressChanged);
            this.backgroundWorker1.RunWorkerCompleted += new System.ComponentModel.RunWorkerCompletedEventHandler(this.backgroundWorker1_RunWorkerCompleted);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(205, 202);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(196, 14);
            this.label5.TabIndex = 14;
            this.label5.Text = "Client Seconds/Iteration (Avg)";
            // 
            // avgSeconds_textBox
            // 
            this.avgSeconds_textBox.BackColor = System.Drawing.Color.Black;
            this.avgSeconds_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.avgSeconds_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.avgSeconds_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.avgSeconds_textBox.ForeColor = System.Drawing.Color.Lime;
            this.avgSeconds_textBox.Location = new System.Drawing.Point(205, 219);
            this.avgSeconds_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.avgSeconds_textBox.Name = "avgSeconds_textBox";
            this.avgSeconds_textBox.Size = new System.Drawing.Size(196, 30);
            this.avgSeconds_textBox.TabIndex = 13;
            this.avgSeconds_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // progressBar1
            // 
            this.progressBar1.BackColor = System.Drawing.SystemColors.Control;
            this.progressBar1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.progressBar1.Location = new System.Drawing.Point(205, 69);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(196, 30);
            this.progressBar1.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.progressBar1.TabIndex = 15;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(205, 52);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(196, 14);
            this.label6.TabIndex = 16;
            this.label6.Text = "Progress";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(205, 252);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(196, 14);
            this.label7.TabIndex = 18;
            this.label7.Text = "Total Exceptions";
            // 
            // totalExceptions_textBox
            // 
            this.totalExceptions_textBox.BackColor = System.Drawing.Color.Black;
            this.totalExceptions_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.totalExceptions_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.totalExceptions_textBox.ForeColor = System.Drawing.Color.Red;
            this.totalExceptions_textBox.Location = new System.Drawing.Point(3, 3);
            this.totalExceptions_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.totalExceptions_textBox.Name = "totalExceptions_textBox";
            this.totalExceptions_textBox.Size = new System.Drawing.Size(155, 30);
            this.totalExceptions_textBox.TabIndex = 17;
            this.totalExceptions_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.totalExceptions_textBox.Click += new System.EventHandler(this.totalExceptions_textBox_Click);
            // 
            // mainUITimer
            // 
            this.mainUITimer.Tick += new System.EventHandler(this.mainUITimer_Tick);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(205, 102);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(196, 14);
            this.label8.TabIndex = 20;
            this.label8.Text = "Elapsed Time";
            // 
            // elapsedTime_textBox
            // 
            this.elapsedTime_textBox.BackColor = System.Drawing.Color.Black;
            this.elapsedTime_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.elapsedTime_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.elapsedTime_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.elapsedTime_textBox.ForeColor = System.Drawing.Color.Lime;
            this.elapsedTime_textBox.Location = new System.Drawing.Point(205, 119);
            this.elapsedTime_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.elapsedTime_textBox.Name = "elapsedTime_textBox";
            this.elapsedTime_textBox.Size = new System.Drawing.Size(196, 30);
            this.elapsedTime_textBox.TabIndex = 19;
            this.elapsedTime_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // perfCounterTimer
            // 
            this.perfCounterTimer.Interval = 2500;
            // 
            // database_button
            // 
            this.database_button.Dock = System.Windows.Forms.DockStyle.Fill;
            this.database_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.database_button.Location = new System.Drawing.Point(3, 69);
            this.database_button.Name = "database_button";
            this.database_button.Size = new System.Drawing.Size(196, 30);
            this.database_button.TabIndex = 22;
            this.database_button.Text = "Database";
            this.database_button.UseVisualStyleBackColor = true;
            this.database_button.Click += new System.EventHandler(this.database_button_Click);
            // 
            // iterationsSecond_textBox
            // 
            this.iterationsSecond_textBox.BackColor = System.Drawing.Color.Black;
            this.iterationsSecond_textBox.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.iterationsSecond_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.iterationsSecond_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.iterationsSecond_textBox.ForeColor = System.Drawing.Color.Lime;
            this.iterationsSecond_textBox.Location = new System.Drawing.Point(205, 169);
            this.iterationsSecond_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.iterationsSecond_textBox.Name = "iterationsSecond_textBox";
            this.iterationsSecond_textBox.Size = new System.Drawing.Size(196, 30);
            this.iterationsSecond_textBox.TabIndex = 23;
            this.iterationsSecond_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // exceptions_button
            // 
            this.exceptions_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.exceptions_button.Location = new System.Drawing.Point(164, 3);
            this.exceptions_button.Name = "exceptions_button";
            this.exceptions_button.Size = new System.Drawing.Size(27, 23);
            this.exceptions_button.TabIndex = 24;
            this.exceptions_button.Text = "...";
            this.exceptions_button.UseVisualStyleBackColor = true;
            this.exceptions_button.Click += new System.EventHandler(this.exceptions_button_Click);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(3, 252);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(196, 14);
            this.label9.TabIndex = 26;
            this.label9.Text = "CPU Seconds/Iteration (Avg)";
            // 
            // cpuTime_textBox
            // 
            this.cpuTime_textBox.BackColor = System.Drawing.Color.Black;
            this.cpuTime_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.cpuTime_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.cpuTime_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cpuTime_textBox.ForeColor = System.Drawing.Color.Lime;
            this.cpuTime_textBox.Location = new System.Drawing.Point(3, 269);
            this.cpuTime_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.cpuTime_textBox.Name = "cpuTime_textBox";
            this.cpuTime_textBox.Size = new System.Drawing.Size(196, 30);
            this.cpuTime_textBox.TabIndex = 25;
            this.cpuTime_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(3, 302);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(196, 14);
            this.label10.TabIndex = 28;
            this.label10.Text = "Actual Seconds/Iteration (Avg)";
            // 
            // actualSeconds_textBox
            // 
            this.actualSeconds_textBox.BackColor = System.Drawing.Color.Black;
            this.actualSeconds_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.actualSeconds_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.actualSeconds_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.actualSeconds_textBox.ForeColor = System.Drawing.Color.Lime;
            this.actualSeconds_textBox.Location = new System.Drawing.Point(3, 319);
            this.actualSeconds_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.actualSeconds_textBox.Name = "actualSeconds_textBox";
            this.actualSeconds_textBox.Size = new System.Drawing.Size(196, 30);
            this.actualSeconds_textBox.TabIndex = 27;
            this.actualSeconds_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label12.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.Location = new System.Drawing.Point(205, 302);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(196, 14);
            this.label12.TabIndex = 30;
            this.label12.Text = "Logical Reads/Iteration (Avg)";
            // 
            // logicalReads_textBox
            // 
            this.logicalReads_textBox.BackColor = System.Drawing.Color.Black;
            this.logicalReads_textBox.Cursor = System.Windows.Forms.Cursors.Default;
            this.logicalReads_textBox.Dock = System.Windows.Forms.DockStyle.Fill;
            this.logicalReads_textBox.Font = new System.Drawing.Font("Courier New", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.logicalReads_textBox.ForeColor = System.Drawing.Color.Lime;
            this.logicalReads_textBox.Location = new System.Drawing.Point(205, 319);
            this.logicalReads_textBox.Margin = new System.Windows.Forms.Padding(3);
            this.logicalReads_textBox.Name = "logicalReads_textBox";
            this.logicalReads_textBox.Size = new System.Drawing.Size(196, 30);
            this.logicalReads_textBox.TabIndex = 29;
            this.logicalReads_textBox.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // db_label
            // 
            this.db_label.AutoSize = true;
            this.db_label.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.db_label.Location = new System.Drawing.Point(55, 32);
            this.db_label.Name = "db_label";
            this.db_label.Size = new System.Drawing.Size(0, 13);
            this.db_label.TabIndex = 31;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 202F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 202F));
            this.tableLayoutPanel1.Controls.Add(this.logicalReads_textBox, 1, 12);
            this.tableLayoutPanel1.Controls.Add(this.label12, 1, 11);
            this.tableLayoutPanel1.Controls.Add(this.label2, 0, 5);
            this.tableLayoutPanel1.Controls.Add(this.iterations_numericUpDown, 0, 6);
            this.tableLayoutPanel1.Controls.Add(this.threads_numericUpDown, 0, 8);
            this.tableLayoutPanel1.Controls.Add(this.label3, 0, 7);
            this.tableLayoutPanel1.Controls.Add(this.database_button, 0, 2);
            this.tableLayoutPanel1.Controls.Add(this.label9, 0, 9);
            this.tableLayoutPanel1.Controls.Add(this.label10, 0, 11);
            this.tableLayoutPanel1.Controls.Add(this.cpuTime_textBox, 0, 10);
            this.tableLayoutPanel1.Controls.Add(this.flowLayoutPanel1, 1, 10);
            this.tableLayoutPanel1.Controls.Add(this.actualSeconds_textBox, 0, 12);
            this.tableLayoutPanel1.Controls.Add(this.label7, 1, 9);
            this.tableLayoutPanel1.Controls.Add(this.avgSeconds_textBox, 1, 8);
            this.tableLayoutPanel1.Controls.Add(this.label5, 1, 7);
            this.tableLayoutPanel1.Controls.Add(this.iterationsSecond_textBox, 1, 6);
            this.tableLayoutPanel1.Controls.Add(this.label4, 1, 5);
            this.tableLayoutPanel1.Controls.Add(this.label6, 1, 1);
            this.tableLayoutPanel1.Controls.Add(this.label8, 1, 3);
            this.tableLayoutPanel1.Controls.Add(this.progressBar1, 1, 2);
            this.tableLayoutPanel1.Controls.Add(this.elapsedTime_textBox, 1, 4);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel2, 1, 0);
            this.tableLayoutPanel1.Controls.Add(this.param_button, 0, 4);
            this.tableLayoutPanel1.Controls.Add(this.tableLayoutPanel4, 0, 0);
            this.tableLayoutPanel1.Location = new System.Drawing.Point(326, 3);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 14;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 52F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 14F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 36F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(404, 354);
            this.tableLayoutPanel1.TabIndex = 32;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.totalExceptions_textBox);
            this.flowLayoutPanel1.Controls.Add(this.exceptions_button);
            this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(205, 269);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(196, 30);
            this.flowLayoutPanel1.TabIndex = 31;
            // 
            // tableLayoutPanel2
            // 
            this.tableLayoutPanel2.ColumnCount = 2;
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.Controls.Add(this.cancel_button, 1, 0);
            this.tableLayoutPanel2.Controls.Add(this.go_button, 0, 0);
            this.tableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel2.Location = new System.Drawing.Point(205, 3);
            this.tableLayoutPanel2.Name = "tableLayoutPanel2";
            this.tableLayoutPanel2.RowCount = 1;
            this.tableLayoutPanel2.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel2.Size = new System.Drawing.Size(196, 46);
            this.tableLayoutPanel2.TabIndex = 32;
            // 
            // param_button
            // 
            this.param_button.Dock = System.Windows.Forms.DockStyle.Fill;
            this.param_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.param_button.Location = new System.Drawing.Point(3, 119);
            this.param_button.Name = "param_button";
            this.param_button.Size = new System.Drawing.Size(196, 30);
            this.param_button.TabIndex = 21;
            this.param_button.Text = "Parameter Substitution";
            this.param_button.UseVisualStyleBackColor = true;
            this.param_button.Click += new System.EventHandler(this.param_button_Click);
            // 
            // tableLayoutPanel4
            // 
            this.tableLayoutPanel4.ColumnCount = 2;
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel4.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel4.Controls.Add(this.btnFreeCache, 1, 0);
            this.tableLayoutPanel4.Controls.Add(this.btnCleanBuffer, 0, 0);
            this.tableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel4.Location = new System.Drawing.Point(3, 3);
            this.tableLayoutPanel4.Name = "tableLayoutPanel4";
            this.tableLayoutPanel4.RowCount = 2;
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel4.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel4.Size = new System.Drawing.Size(196, 46);
            this.tableLayoutPanel4.TabIndex = 33;
            // 
            // btnFreeCache
            // 
            this.btnFreeCache.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnFreeCache.Location = new System.Drawing.Point(99, 1);
            this.btnFreeCache.Margin = new System.Windows.Forms.Padding(1);
            this.btnFreeCache.Name = "btnFreeCache";
            this.btnFreeCache.Size = new System.Drawing.Size(96, 21);
            this.btnFreeCache.TabIndex = 1;
            this.btnFreeCache.Text = "Free Cache";
            this.btnFreeCache.UseVisualStyleBackColor = true;
            this.btnFreeCache.Click += new System.EventHandler(this.btnFreeCache_Click);
            // 
            // btnCleanBuffer
            // 
            this.btnCleanBuffer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.btnCleanBuffer.Location = new System.Drawing.Point(1, 1);
            this.btnCleanBuffer.Margin = new System.Windows.Forms.Padding(1);
            this.btnCleanBuffer.Name = "btnCleanBuffer";
            this.btnCleanBuffer.Size = new System.Drawing.Size(96, 21);
            this.btnCleanBuffer.TabIndex = 0;
            this.btnCleanBuffer.Text = "Clean Buffers";
            this.btnCleanBuffer.UseVisualStyleBackColor = true;
            this.btnCleanBuffer.Click += new System.EventHandler(this.btnCleanBuffer_Click);
            // 
            // tableLayoutPanel3
            // 
            this.tableLayoutPanel3.ColumnCount = 2;
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel3.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle());
            this.tableLayoutPanel3.Controls.Add(this.query_textBox, 0, 0);
            this.tableLayoutPanel3.Controls.Add(this.tableLayoutPanel1, 1, 0);
            this.tableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel3.Location = new System.Drawing.Point(0, 24);
            this.tableLayoutPanel3.Name = "tableLayoutPanel3";
            this.tableLayoutPanel3.RowCount = 1;
            this.tableLayoutPanel3.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel3.Size = new System.Drawing.Size(733, 360);
            this.tableLayoutPanel3.TabIndex = 33;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.ClientSize = new System.Drawing.Size(733, 384);
            this.Controls.Add(this.tableLayoutPanel3);
            this.Controls.Add(this.db_label);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MainMenuStrip = this.menuStrip1;
            this.MaximizeBox = false;
            this.MinimumSize = new System.Drawing.Size(749, 423);
            this.Name = "Form1";
            this.Text = "SQLQueryStress";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.iterations_numericUpDown)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.threads_numericUpDown)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel1.PerformLayout();
            this.flowLayoutPanel1.ResumeLayout(false);
            this.tableLayoutPanel2.ResumeLayout(false);
            this.tableLayoutPanel4.ResumeLayout(false);
            this.tableLayoutPanel3.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RichTextBox query_textBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.Button go_button;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.NumericUpDown iterations_numericUpDown;
        private System.Windows.Forms.NumericUpDown threads_numericUpDown;
        private System.Windows.Forms.Button cancel_button;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ToolStripMenuItem fileToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem exitToolStripMenuItem;
        private System.ComponentModel.BackgroundWorker backgroundWorker1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label avgSeconds_textBox;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label totalExceptions_textBox;
        private System.Windows.Forms.Timer mainUITimer;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label elapsedTime_textBox;
        private System.Windows.Forms.Timer perfCounterTimer;
        private System.Windows.Forms.ToolStripMenuItem helpToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem aboutToolStripMenuItem;
        private System.Windows.Forms.Button database_button;
        private System.Windows.Forms.Label iterationsSecond_textBox;
        private System.Windows.Forms.ToolStripMenuItem saveSettingsToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem loadSettingsToolStripMenuItem;
        private System.Windows.Forms.Button exceptions_button;
        private System.Windows.Forms.SaveFileDialog saveFileDialog1;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label cpuTime_textBox;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label actualSeconds_textBox;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label logicalReads_textBox;
        private System.Windows.Forms.ToolStripMenuItem optionsToolStripMenuItem;
        private System.Windows.Forms.Label db_label;
        private TableLayoutPanel tableLayoutPanel1;
        private FlowLayoutPanel flowLayoutPanel1;
        private TableLayoutPanel tableLayoutPanel2;
        private Button param_button;
        private TableLayoutPanel tableLayoutPanel3;
        private TableLayoutPanel tableLayoutPanel4;
        private Button btnFreeCache;
        private Button btnCleanBuffer;
    }
}

