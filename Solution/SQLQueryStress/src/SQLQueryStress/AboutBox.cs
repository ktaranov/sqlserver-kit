#region

using System;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Windows.Forms;

#endregion

namespace SQLQueryStress
{
    internal partial class AboutBox : Form
    {
        public AboutBox()
        {
            InitializeComponent();

            //  Initialize the AboutBox to display the product information from the assembly information.
            //  Change assembly information settings for your application through either:
            //  - Project->Properties->Application->Assembly Information
            //  - AssemblyInfo.cs
            Text = string.Format("About {0}", AssemblyTitle);
            labelProductName.Text = AssemblyProduct;
            labelVersion.Text = string.Format("Version {0}", AssemblyVersion);
            labelCopyright.Text = AssemblyCopyright;
            labelCompanyName.Text = AssemblyCompany;
            /*this.textBoxDescription.Text = //AssemblyDescription;
                @"SQL Server Query Load Test Tool

- Enter the query or batch to be tested in the Query textbox
- The query will be run concurrently by the number of threads specified in the Number of Threads textbox
- Each thread will run the query as many times as specified in the Number of Iterations textbox
- Parameter Substitution allows you to dynamically replace variables in your query with values taken from another query.  For instance, you can define the following batch:

SELECT *
FROM sys.databases
WHERE [name] = @db_name

If you then go into the Parameter Substitution window, you can enter the following query into the Parameter Query textbox:

SELECT [name]
FROM sys.databases

Click the Get Columns button and use the grid to assign the @db_name parameter to the 'name' column.  During the test, the values used for @db_name will be taken from the 'name' column.  If there are more iterations than unique values, the tool will loop back to the beginning of the list and will keep looping until the test is complete.

- Once queries and optional parameterization are complete, use the GO button to start the test.  The following information is reported by the tool:

. Elapsed Time: The amount of time spent, starting the moment the GO button is clicked and ending the moment the test stops
. Iterations Completed: The number of times the query has been executed, aggregated for all threads
. Client Seconds/Iteration (Avg): The average amount of time the client waited for each execution of the query being tested. This timing is taken on the client.
. Total Exceptions: The number of exceptions that occurred. Click on the ellipsis button to see the messages of the actual exceptions.
. CPU Seconds/Iteration (Avg): The average number of seconds of CPU time spent processing the batch, as reported by SQL Server. This number includes both processing and execution time.
. Actual Seconds/Iteration (Avg): The average number of seconds elapsed for execution of the batch, as reported by SQL Server. This number includes both processing and execution time.
. Logical Reads/Iteration (Avg): The average number of logical reads required by the batch, as reported by SQL Server.

To stop testing, click the Cancel button.  Note that cancellation of a test may take some time if several threads are being used, as the test will not be stopped until all threads have successfully been aborted.  The UI may continue to update while the test is being cancelled, as additional data is collected.

Settings for a test, including the query, database information, and parameter assignments, can be saved and re-loaded using the File menu.  Keep in mind that all database information is persisted -- do not save sensitive database passwords!";
             */
        }

        public sealed override string Text
        {
            get { return base.Text; }
            set { base.Text = value; }
        }

        private void okButton_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void textBoxDescription_Click(object sender, EventArgs e)
        {
            Process.Start("https://github.com/ErikEJ/SqlQueryStress");
        }

        #region Assembly Attribute Accessors

        public string AssemblyTitle
        {
            get
            {
                // Get all Title attributes on this assembly
                var attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof (AssemblyTitleAttribute), false);
                // If there is at least one Title attribute
                if (attributes.Length > 0)
                {
                    // Select the first one
                    var titleAttribute = (AssemblyTitleAttribute) attributes[0];
                    // If it is not an empty string, return it
                    if (titleAttribute.Title != "")
                        return titleAttribute.Title;
                }
                // If there was no Title attribute, or if the Title attribute was the empty string, return the .exe name
                return Path.GetFileNameWithoutExtension(Assembly.GetExecutingAssembly().CodeBase);
            }
        }

        public string AssemblyVersion
        {
            get { return Assembly.GetExecutingAssembly().GetName().Version.ToString(); }
        }

        public string AssemblyDescription
        {
            get
            {
                // Get all Description attributes on this assembly
                var attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof (AssemblyDescriptionAttribute), false);
                // If there aren't any Description attributes, return an empty string
                if (attributes.Length == 0)
                    return "";
                // If there is a Description attribute, return its value
                return ((AssemblyDescriptionAttribute) attributes[0]).Description;
            }
        }

        public string AssemblyProduct
        {
            get
            {
                // Get all Product attributes on this assembly
                var attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof (AssemblyProductAttribute), false);
                // If there aren't any Product attributes, return an empty string
                if (attributes.Length == 0)
                    return "";
                // If there is a Product attribute, return its value
                return ((AssemblyProductAttribute) attributes[0]).Product;
            }
        }

        public string AssemblyCopyright
        {
            get
            {
                // Get all Copyright attributes on this assembly
                var attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof (AssemblyCopyrightAttribute), false);
                // If there aren't any Copyright attributes, return an empty string
                if (attributes.Length == 0)
                    return "";
                // If there is a Copyright attribute, return its value
                return ((AssemblyCopyrightAttribute) attributes[0]).Copyright;
            }
        }

        public string AssemblyCompany
        {
            get
            {
                // Get all Company attributes on this assembly
                var attributes = Assembly.GetExecutingAssembly().GetCustomAttributes(typeof (AssemblyCompanyAttribute), false);
                // If there aren't any Company attributes, return an empty string
                if (attributes.Length == 0)
                    return "";
                // If there is a Company attribute, return its value
                return ((AssemblyCompanyAttribute) attributes[0]).Company;
            }
        }

        #endregion
    }
}