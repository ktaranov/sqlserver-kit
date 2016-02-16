namespace SQLQueryStress
{
    partial class DatabaseSelect
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
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.server_textBox = new System.Windows.Forms.TextBox();
            this.authentication_comboBox = new System.Windows.Forms.ComboBox();
            this.login_textBox = new System.Windows.Forms.TextBox();
            this.password_textBox = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.cancel_button = new System.Windows.Forms.Button();
            this.test_button = new System.Windows.Forms.Button();
            this.ok_button = new System.Windows.Forms.Button();
            this.db_comboBox = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.pm_test_button = new System.Windows.Forms.Button();
            this.shareSettings_checkBox = new System.Windows.Forms.CheckBox();
            this.pm_db_comboBox = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.pm_password_textBox = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.pm_server_textBox = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.pm_login_textBox = new System.Windows.Forms.TextBox();
            this.pm_authentication_comboBox = new System.Windows.Forms.ComboBox();
            this.label10 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(6, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(44, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Server";
            // 
            // server_textBox
            // 
            this.server_textBox.Location = new System.Drawing.Point(9, 55);
            this.server_textBox.Name = "server_textBox";
            this.server_textBox.Size = new System.Drawing.Size(231, 20);
            this.server_textBox.TabIndex = 1;
            // 
            // authentication_comboBox
            // 
            this.authentication_comboBox.FormattingEnabled = true;
            this.authentication_comboBox.Items.AddRange(new object[] {
            "Integrated Authentication",
            "SQL Server Authentication"});
            this.authentication_comboBox.Location = new System.Drawing.Point(9, 94);
            this.authentication_comboBox.Name = "authentication_comboBox";
            this.authentication_comboBox.Size = new System.Drawing.Size(231, 21);
            this.authentication_comboBox.TabIndex = 2;
            // 
            // login_textBox
            // 
            this.login_textBox.Location = new System.Drawing.Point(9, 134);
            this.login_textBox.Name = "login_textBox";
            this.login_textBox.Size = new System.Drawing.Size(231, 20);
            this.login_textBox.TabIndex = 3;
            // 
            // password_textBox
            // 
            this.password_textBox.Location = new System.Drawing.Point(9, 173);
            this.password_textBox.Name = "password_textBox";
            this.password_textBox.Size = new System.Drawing.Size(231, 20);
            this.password_textBox.TabIndex = 4;
            this.password_textBox.UseSystemPasswordChar = true;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(9, 157);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(61, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Password";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(6, 118);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(38, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Login";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(6, 78);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(89, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "Authentication";
            // 
            // cancel_button
            // 
            this.cancel_button.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.cancel_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cancel_button.Location = new System.Drawing.Point(430, 286);
            this.cancel_button.Name = "cancel_button";
            this.cancel_button.Size = new System.Drawing.Size(80, 23);
            this.cancel_button.TabIndex = 8;
            this.cancel_button.Text = "Cancel";
            this.cancel_button.UseVisualStyleBackColor = true;
            this.cancel_button.Click += new System.EventHandler(this.cancel_button_Click);
            // 
            // test_button
            // 
            this.test_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.test_button.Location = new System.Drawing.Point(120, 239);
            this.test_button.Name = "test_button";
            this.test_button.Size = new System.Drawing.Size(120, 23);
            this.test_button.TabIndex = 9;
            this.test_button.Text = "Test Connection";
            this.test_button.UseVisualStyleBackColor = true;
            this.test_button.Click += new System.EventHandler(this.test_button_Click);
            // 
            // ok_button
            // 
            this.ok_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.ok_button.Location = new System.Drawing.Point(344, 286);
            this.ok_button.Name = "ok_button";
            this.ok_button.Size = new System.Drawing.Size(80, 23);
            this.ok_button.TabIndex = 10;
            this.ok_button.Text = "OK";
            this.ok_button.UseVisualStyleBackColor = true;
            this.ok_button.Click += new System.EventHandler(this.ok_button_Click);
            // 
            // db_comboBox
            // 
            this.db_comboBox.FormattingEnabled = true;
            this.db_comboBox.Location = new System.Drawing.Point(9, 212);
            this.db_comboBox.Name = "db_comboBox";
            this.db_comboBox.Size = new System.Drawing.Size(231, 21);
            this.db_comboBox.TabIndex = 11;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(6, 196);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(106, 13);
            this.label5.TabIndex = 12;
            this.label5.Text = "Default Database";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.db_comboBox);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.password_textBox);
            this.groupBox1.Controls.Add(this.test_button);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.server_textBox);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.login_textBox);
            this.groupBox1.Controls.Add(this.authentication_comboBox);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(246, 268);
            this.groupBox1.TabIndex = 13;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Main Load Settings";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.pm_test_button);
            this.groupBox2.Controls.Add(this.shareSettings_checkBox);
            this.groupBox2.Controls.Add(this.pm_db_comboBox);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.pm_password_textBox);
            this.groupBox2.Controls.Add(this.label7);
            this.groupBox2.Controls.Add(this.pm_server_textBox);
            this.groupBox2.Controls.Add(this.label8);
            this.groupBox2.Controls.Add(this.label9);
            this.groupBox2.Controls.Add(this.pm_login_textBox);
            this.groupBox2.Controls.Add(this.pm_authentication_comboBox);
            this.groupBox2.Controls.Add(this.label10);
            this.groupBox2.Location = new System.Drawing.Point(264, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(246, 268);
            this.groupBox2.TabIndex = 14;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Parameterization Settings";
            // 
            // pm_test_button
            // 
            this.pm_test_button.Enabled = false;
            this.pm_test_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.pm_test_button.Location = new System.Drawing.Point(123, 239);
            this.pm_test_button.Name = "pm_test_button";
            this.pm_test_button.Size = new System.Drawing.Size(120, 23);
            this.pm_test_button.TabIndex = 15;
            this.pm_test_button.Text = "Test Connection";
            this.pm_test_button.UseVisualStyleBackColor = true;
            this.pm_test_button.Click += new System.EventHandler(this.pm_test_button_Click);
            // 
            // shareSettings_checkBox
            // 
            this.shareSettings_checkBox.AutoSize = true;
            this.shareSettings_checkBox.Checked = true;
            this.shareSettings_checkBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.shareSettings_checkBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.shareSettings_checkBox.Location = new System.Drawing.Point(12, 19);
            this.shareSettings_checkBox.Name = "shareSettings_checkBox";
            this.shareSettings_checkBox.Size = new System.Drawing.Size(177, 17);
            this.shareSettings_checkBox.TabIndex = 13;
            this.shareSettings_checkBox.Text = "Share Connection Settings";
            this.shareSettings_checkBox.UseVisualStyleBackColor = true;
            this.shareSettings_checkBox.CheckedChanged += new System.EventHandler(this.shareSettings_checkBox_CheckedChanged);
            // 
            // pm_db_comboBox
            // 
            this.pm_db_comboBox.Enabled = false;
            this.pm_db_comboBox.FormattingEnabled = true;
            this.pm_db_comboBox.Location = new System.Drawing.Point(9, 212);
            this.pm_db_comboBox.Name = "pm_db_comboBox";
            this.pm_db_comboBox.Size = new System.Drawing.Size(231, 21);
            this.pm_db_comboBox.TabIndex = 11;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(6, 196);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(106, 13);
            this.label6.TabIndex = 12;
            this.label6.Text = "Default Database";
            // 
            // pm_password_textBox
            // 
            this.pm_password_textBox.Enabled = false;
            this.pm_password_textBox.Location = new System.Drawing.Point(9, 173);
            this.pm_password_textBox.Name = "pm_password_textBox";
            this.pm_password_textBox.Size = new System.Drawing.Size(231, 20);
            this.pm_password_textBox.TabIndex = 4;
            this.pm_password_textBox.UseSystemPasswordChar = true;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(9, 157);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(61, 13);
            this.label7.TabIndex = 5;
            this.label7.Text = "Password";
            // 
            // pm_server_textBox
            // 
            this.pm_server_textBox.Enabled = false;
            this.pm_server_textBox.Location = new System.Drawing.Point(9, 55);
            this.pm_server_textBox.Name = "pm_server_textBox";
            this.pm_server_textBox.Size = new System.Drawing.Size(231, 20);
            this.pm_server_textBox.TabIndex = 1;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(6, 39);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(44, 13);
            this.label8.TabIndex = 0;
            this.label8.Text = "Server";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(6, 78);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(89, 13);
            this.label9.TabIndex = 7;
            this.label9.Text = "Authentication";
            // 
            // pm_login_textBox
            // 
            this.pm_login_textBox.Enabled = false;
            this.pm_login_textBox.Location = new System.Drawing.Point(9, 134);
            this.pm_login_textBox.Name = "pm_login_textBox";
            this.pm_login_textBox.Size = new System.Drawing.Size(231, 20);
            this.pm_login_textBox.TabIndex = 3;
            // 
            // pm_authentication_comboBox
            // 
            this.pm_authentication_comboBox.Enabled = false;
            this.pm_authentication_comboBox.FormattingEnabled = true;
            this.pm_authentication_comboBox.Items.AddRange(new object[] {
            "Integrated Authentication",
            "SQL Server Authentication"});
            this.pm_authentication_comboBox.Location = new System.Drawing.Point(9, 94);
            this.pm_authentication_comboBox.Name = "pm_authentication_comboBox";
            this.pm_authentication_comboBox.Size = new System.Drawing.Size(231, 21);
            this.pm_authentication_comboBox.TabIndex = 2;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(6, 118);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(38, 13);
            this.label10.TabIndex = 6;
            this.label10.Text = "Login";
            // 
            // DatabaseSelect
            // 
            this.AcceptButton = this.ok_button;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.cancel_button;
            this.ClientSize = new System.Drawing.Size(524, 320);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.ok_button);
            this.Controls.Add(this.cancel_button);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "DatabaseSelect";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.Text = "Database Select";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox server_textBox;
        private System.Windows.Forms.ComboBox authentication_comboBox;
        private System.Windows.Forms.TextBox login_textBox;
        private System.Windows.Forms.TextBox password_textBox;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button cancel_button;
        private System.Windows.Forms.Button test_button;
        private System.Windows.Forms.Button ok_button;
        private System.Windows.Forms.ComboBox db_comboBox;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.CheckBox shareSettings_checkBox;
        private System.Windows.Forms.ComboBox pm_db_comboBox;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox pm_password_textBox;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox pm_server_textBox;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox pm_login_textBox;
        private System.Windows.Forms.ComboBox pm_authentication_comboBox;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Button pm_test_button;
    }
}