namespace SQLQueryStress
{
    partial class ParamWindow
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
            this.columnMapGrid = new System.Windows.Forms.DataGridView();
            this.Column = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Datatype = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Parameter = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.paramQueryTextBox = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.getColumnsButton = new System.Windows.Forms.Button();
            this.okButton = new System.Windows.Forms.Button();
            this.cancelButton = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.database_button = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.columnMapGrid)).BeginInit();
            this.SuspendLayout();
            // 
            // columnMapGrid
            // 
            this.columnMapGrid.AllowUserToAddRows = false;
            this.columnMapGrid.AllowUserToDeleteRows = false;
            this.columnMapGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.columnMapGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Column,
            this.Datatype,
            this.Parameter});
            this.columnMapGrid.Location = new System.Drawing.Point(12, 274);
            this.columnMapGrid.Name = "columnMapGrid";
            this.columnMapGrid.ShowEditingIcon = false;
            this.columnMapGrid.Size = new System.Drawing.Size(435, 185);
            this.columnMapGrid.TabIndex = 0;
            // 
            // Column
            // 
            this.Column.HeaderText = "Parameter";
            this.Column.Name = "Column";
            this.Column.Width = 130;
            // 
            // Datatype
            // 
            this.Datatype.HeaderText = "Datatype";
            this.Datatype.Name = "Datatype";
            this.Datatype.Width = 130;
            // 
            // Parameter
            // 
            this.Parameter.HeaderText = "Column";
            this.Parameter.Name = "Parameter";
            this.Parameter.Width = 130;
            // 
            // paramQueryTextBox
            // 
            this.paramQueryTextBox.AcceptsReturn = true;
            this.paramQueryTextBox.AcceptsTab = true;
            this.paramQueryTextBox.AllowDrop = true;
            this.paramQueryTextBox.Location = new System.Drawing.Point(12, 26);
            this.paramQueryTextBox.Multiline = true;
            this.paramQueryTextBox.Name = "paramQueryTextBox";
            this.paramQueryTextBox.ScrollBars = System.Windows.Forms.ScrollBars.Both;
            this.paramQueryTextBox.Size = new System.Drawing.Size(435, 186);
            this.paramQueryTextBox.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 10);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(101, 13);
            this.label1.TabIndex = 2;
            this.label1.Text = "Parameter Query";
            // 
            // getColumnsButton
            // 
            this.getColumnsButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.getColumnsButton.Location = new System.Drawing.Point(15, 219);
            this.getColumnsButton.Name = "getColumnsButton";
            this.getColumnsButton.Size = new System.Drawing.Size(98, 23);
            this.getColumnsButton.TabIndex = 3;
            this.getColumnsButton.Text = "Get Columns";
            this.getColumnsButton.UseVisualStyleBackColor = true;
            this.getColumnsButton.Click += new System.EventHandler(this.getColumnsButton_Click);
            // 
            // okButton
            // 
            this.okButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.okButton.Location = new System.Drawing.Point(291, 465);
            this.okButton.Name = "okButton";
            this.okButton.Size = new System.Drawing.Size(75, 23);
            this.okButton.TabIndex = 4;
            this.okButton.Text = "OK";
            this.okButton.UseVisualStyleBackColor = true;
            this.okButton.Click += new System.EventHandler(this.okButton_Click);
            // 
            // cancelButton
            // 
            this.cancelButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.cancelButton.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cancelButton.Location = new System.Drawing.Point(372, 465);
            this.cancelButton.Name = "cancelButton";
            this.cancelButton.Size = new System.Drawing.Size(75, 23);
            this.cancelButton.TabIndex = 5;
            this.cancelButton.Text = "Cancel";
            this.cancelButton.UseVisualStyleBackColor = true;
            this.cancelButton.Click += new System.EventHandler(this.cancelButton_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(12, 258);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(122, 13);
            this.label2.TabIndex = 6;
            this.label2.Text = "Parameter Mappings";
            // 
            // database_button
            // 
            this.database_button.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.database_button.Location = new System.Drawing.Point(119, 219);
            this.database_button.Name = "database_button";
            this.database_button.Size = new System.Drawing.Size(94, 23);
            this.database_button.TabIndex = 7;
            this.database_button.Text = "Database";
            this.database_button.UseVisualStyleBackColor = true;
            this.database_button.Click += new System.EventHandler(this.database_button_Click);
            // 
            // ParamWindow
            // 
            this.AcceptButton = this.okButton;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.cancelButton;
            this.ClientSize = new System.Drawing.Size(462, 500);
            this.Controls.Add(this.database_button);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cancelButton);
            this.Controls.Add(this.okButton);
            this.Controls.Add(this.getColumnsButton);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.paramQueryTextBox);
            this.Controls.Add(this.columnMapGrid);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "ParamWindow";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.Text = "Parameter Substitution";
            ((System.ComponentModel.ISupportInitialize)(this.columnMapGrid)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox paramQueryTextBox;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button getColumnsButton;
        private System.Windows.Forms.Button okButton;
        private System.Windows.Forms.Button cancelButton;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button database_button;
        private System.Windows.Forms.DataGridView columnMapGrid;
        private System.Windows.Forms.DataGridViewTextBoxColumn Column;
        private System.Windows.Forms.DataGridViewTextBoxColumn Datatype;
        private System.Windows.Forms.DataGridViewTextBoxColumn Parameter;
    }
}