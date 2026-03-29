using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Xml;
using Microsoft.SqlServer.Server;

/// <summary>
/// Extended SSRS Report Generator features:
///   - Data-driven export (reads config from a SQL table to batch-export reports)
///   - Email report as attachment
///   - SharePoint integrated mode support
///   - URL Access rendering
///   - Local RDL file rendering via ReportViewer (LocalReport mode)
/// </summary>
public class SSRSReportGeneratorExtended
{
    // ──────────────────────────────────────────────────────────────
    //  SOAP / HTTP helpers (shared with main class)
    // ──────────────────────────────────────────────────────────────

    private static HttpWebRequest CreateRequest(string url, string method,
        string username, string password, string domain)
    {
        var request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = method;
        request.Timeout = 600000;

        if (!string.IsNullOrEmpty(username))
        {
            if (!string.IsNullOrEmpty(domain))
                request.Credentials = new NetworkCredential(username, password, domain);
            else
                request.Credentials = new NetworkCredential(username, password);
        }
        else
        {
            request.UseDefaultCredentials = true;
        }

        return request;
    }

    private static string XmlEscape(string value)
    {
        if (string.IsNullOrEmpty(value)) return "";
        return value.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;")
                     .Replace("\"", "&quot;").Replace("'", "&apos;");
    }

    // ──────────────────────────────────────────────────────────────
    //  URL Access rendering (alternative to SOAP)
    // ──────────────────────────────────────────────────────────────

    private static byte[] RenderViaUrlAccess(string serverUrl, string reportPath,
        string format, string urlParameters, string username, string password, string domain)
    {
        // Build URL: http://server/ReportServer?/Folder/Report&rs:Format=PDF&rs:Command=Render&Param=Val
        string url = serverUrl.TrimEnd('/') + "?" + reportPath
            + "&rs:Format=" + Uri.EscapeDataString(format)
            + "&rs:Command=Render";

        if (!string.IsNullOrEmpty(urlParameters))
            url += "&" + urlParameters;

        var request = CreateRequest(url, "GET", username, password, domain);

        using (var response = request.GetResponse())
        using (var stream = response.GetResponseStream())
        using (var ms = new MemoryStream())
        {
            byte[] buffer = new byte[8192];
            int read;
            while ((read = stream.Read(buffer, 0, buffer.Length)) > 0)
                ms.Write(buffer, 0, read);
            return ms.ToArray();
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  URL Access export procedure
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Exports a report using the SSRS URL Access method.
    /// Parameters are passed in URL query string format: "Year=2024&Month=1&Category=Sales"
    /// This method is simpler than SOAP and works with both native and SharePoint mode.
    /// </summary>
    [SqlProcedure]
    public static void ExportReportUrlAccess(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString exportFormat,
        SqlString urlParameters,     // URL format: "Param1=Val1&Param2=Val2"
        SqlString outputFilePath,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value;
            string path = reportPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = urlParameters.IsNull ? null : urlParameters.Value;
            string outPath = outputFilePath.IsNull ? null : outputFilePath.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            byte[] result = RenderViaUrlAccess(srv, path, fmt, parms, user, pass, dom);

            if (!string.IsNullOrEmpty(outPath))
            {
                string dir = Path.GetDirectoryName(outPath);
                if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
                    Directory.CreateDirectory(dir);

                File.WriteAllBytes(outPath, result);
                SqlContext.Pipe.Send(string.Format("Report exported via URL Access to {0} ({1} bytes)",
                    outPath, result.Length));
            }
            else
            {
                SqlDataRecord record = new SqlDataRecord(
                    new SqlMetaData("ReportData", SqlDbType.VarBinary, SqlMetaData.Max),
                    new SqlMetaData("Format", SqlDbType.NVarChar, 50),
                    new SqlMetaData("SizeBytes", SqlDbType.BigInt)
                );
                SqlContext.Pipe.SendResultsStart(record);
                record.SetSqlBinary(0, new SqlBinary(result));
                record.SetSqlString(1, new SqlString(fmt));
                record.SetSqlInt64(2, result.LongLength);
                SqlContext.Pipe.SendResultsRow(record);
                SqlContext.Pipe.SendResultsEnd();
            }
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  SharePoint integrated mode export
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Exports a report from SSRS in SharePoint integrated mode.
    /// The report path is a SharePoint URL, e.g.:
    ///   http://sharepointserver/sites/mysite/Reports/MyReport.rdl
    /// </summary>
    [SqlProcedure]
    public static void ExportReportSharePoint(
        SqlString sharePointUrl,       // e.g. http://sharepoint/sites/mysite
        SqlString reportLibraryPath,   // e.g. /sites/mysite/Reports/MyReport.rdl
        SqlString exportFormat,
        SqlString urlParameters,
        SqlString outputFilePath,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string spUrl = sharePointUrl.Value.TrimEnd('/');
            string rptPath = reportLibraryPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = urlParameters.IsNull ? "" : urlParameters.Value;
            string outPath = outputFilePath.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            // SharePoint integrated mode uses the _vti_bin/ReportServer endpoint
            string url = spUrl + "/_vti_bin/ReportServer?"
                + Uri.EscapeDataString(rptPath)
                + "&rs:Format=" + Uri.EscapeDataString(fmt)
                + "&rs:Command=Render";

            if (!string.IsNullOrEmpty(parms))
                url += "&" + parms;

            var request = CreateRequest(url, "GET", user, pass, dom);

            byte[] result;
            using (var response = request.GetResponse())
            using (var stream = response.GetResponseStream())
            using (var ms = new MemoryStream())
            {
                byte[] buffer = new byte[8192];
                int read;
                while ((read = stream.Read(buffer, 0, buffer.Length)) > 0)
                    ms.Write(buffer, 0, read);
                result = ms.ToArray();
            }

            string dir = Path.GetDirectoryName(outPath);
            if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            File.WriteAllBytes(outPath, result);
            SqlContext.Pipe.Send(string.Format("SharePoint report exported to {0} ({1} bytes)",
                outPath, result.Length));
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  Email report as attachment
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Exports a report and emails it as an attachment.
    /// Supports multiple recipients (semicolon-separated).
    /// </summary>
    [SqlProcedure]
    public static void EmailReport(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString exportFormat,
        SqlString parameters,
        SqlString smtpServer,
        SqlInt32  smtpPort,
        SqlBoolean smtpUseSsl,
        SqlString smtpUsername,
        SqlString smtpPassword,
        SqlString fromAddress,
        SqlString toAddresses,        // semicolon-separated
        SqlString ccAddresses,        // semicolon-separated, optional
        SqlString subject,
        SqlString body,
        SqlString ssrsUsername,
        SqlString ssrsPassword,
        SqlString ssrsDomain)
    {
        try
        {
            string srv = serverUrl.Value;
            string path = reportPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = parameters.IsNull ? null : parameters.Value;

            // Render the report using URL Access
            byte[] reportBytes = RenderViaUrlAccess(srv, path, fmt, parms,
                ssrsUsername.IsNull ? null : ssrsUsername.Value,
                ssrsPassword.IsNull ? null : ssrsPassword.Value,
                ssrsDomain.IsNull ? null : ssrsDomain.Value);

            // Determine file extension
            string ext = GetExtension(fmt);
            string reportName = path.Contains("/")
                ? path.Substring(path.LastIndexOf('/') + 1)
                : path;
            string attachmentName = reportName + ext;

            // Build email
            using (var message = new MailMessage())
            {
                message.From = new MailAddress(fromAddress.Value);
                message.Subject = subject.IsNull ? "Report: " + reportName : subject.Value;
                message.Body = body.IsNull
                    ? "Please find the attached report."
                    : body.Value;
                message.IsBodyHtml = false;

                // Add TO recipients
                foreach (string addr in toAddresses.Value.Split(';'))
                {
                    string trimmed = addr.Trim();
                    if (!string.IsNullOrEmpty(trimmed))
                        message.To.Add(new MailAddress(trimmed));
                }

                // Add CC recipients
                if (!ccAddresses.IsNull && !string.IsNullOrEmpty(ccAddresses.Value))
                {
                    foreach (string addr in ccAddresses.Value.Split(';'))
                    {
                        string trimmed = addr.Trim();
                        if (!string.IsNullOrEmpty(trimmed))
                            message.CC.Add(new MailAddress(trimmed));
                    }
                }

                // Attach report
                using (var ms = new MemoryStream(reportBytes))
                {
                    var attachment = new Attachment(ms, attachmentName, GetMimeType(fmt));
                    message.Attachments.Add(attachment);

                    // Send
                    using (var client = new SmtpClient(smtpServer.Value))
                    {
                        client.Port = smtpPort.IsNull ? 25 : smtpPort.Value;
                        client.EnableSsl = !smtpUseSsl.IsNull && smtpUseSsl.Value;

                        if (!smtpUsername.IsNull && !string.IsNullOrEmpty(smtpUsername.Value))
                            client.Credentials = new NetworkCredential(
                                smtpUsername.Value, smtpPassword.IsNull ? "" : smtpPassword.Value);
                        else
                            client.UseDefaultCredentials = true;

                        client.Send(message);
                    }
                }
            }

            SqlContext.Pipe.Send(string.Format("Report emailed successfully to {0} ({1} bytes, format: {2})",
                toAddresses.Value, reportBytes.Length, fmt));
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  Data-driven export: reads config from a SQL table
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Reads export jobs from a configuration table and executes them.
    /// The config table must have columns:
    ///   JobId, ServerUrl, ReportPath, ExportFormat, Parameters,
    ///   OutputFilePath, EmailTo, EmailSubject, IsActive
    ///
    /// Results are logged to a status table if provided.
    /// Uses the current SQL connection via context connection.
    /// </summary>
    [SqlProcedure]
    public static void DataDrivenExport(
        SqlString configQuery,        // SELECT query returning job rows
        SqlString outputFolder,       // base output folder (can use {ReportName}, {Format}, {Date} tokens)
        SqlString smtpServer,         // optional: SMTP server for email delivery
        SqlInt32  smtpPort,
        SqlString smtpFrom,
        SqlString statusTableName,    // optional: table to log results (schema: JobId, Status, Message, ExportedAt)
        SqlString ssrsUsername,
        SqlString ssrsPassword,
        SqlString ssrsDomain)
    {
        try
        {
            string query = configQuery.Value;
            string baseFolder = outputFolder.IsNull ? null : outputFolder.Value;
            string smtp = smtpServer.IsNull ? null : smtpServer.Value;
            int port = smtpPort.IsNull ? 25 : smtpPort.Value;
            string from = smtpFrom.IsNull ? null : smtpFrom.Value;
            string statusTable = statusTableName.IsNull ? null : statusTableName.Value;
            string user = ssrsUsername.IsNull ? null : ssrsUsername.Value;
            string pass = ssrsPassword.IsNull ? null : ssrsPassword.Value;
            string dom = ssrsDomain.IsNull ? null : ssrsDomain.Value;

            int successCount = 0;
            int failCount = 0;

            using (var conn = new SqlConnection("context connection=true"))
            {
                conn.Open();

                using (var cmd = new SqlCommand(query, conn))
                using (var reader = cmd.ExecuteReader())
                {
                    // Collect jobs first (can't nest commands on context connection)
                    var jobs = new List<Dictionary<string, string>>();

                    while (reader.Read())
                    {
                        var job = new Dictionary<string, string>();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string colName = reader.GetName(i).ToLower();
                            job[colName] = reader.IsDBNull(i) ? null : reader[i].ToString();
                        }
                        jobs.Add(job);
                    }
                    reader.Close();

                    foreach (var job in jobs)
                    {
                        string jobId = GetDictValue(job, "jobid");
                        string srvUrl = GetDictValue(job, "serverurl");
                        string rptPath = GetDictValue(job, "reportpath");
                        string fmt = GetDictValue(job, "exportformat") ?? "PDF";
                        string parms = GetDictValue(job, "parameters");
                        string filePath = GetDictValue(job, "outputfilepath");
                        string emailTo = GetDictValue(job, "emailto");
                        string emailSubject = GetDictValue(job, "emailsubject");
                        string isActive = GetDictValue(job, "isactive");

                        if (isActive != null && (isActive == "0" || isActive.Equals("false", StringComparison.OrdinalIgnoreCase)))
                            continue;

                        string status = "Success";
                        string message = "";

                        try
                        {
                            // Resolve output path with tokens
                            string resolvedPath = filePath;
                            if (!string.IsNullOrEmpty(baseFolder) && string.IsNullOrEmpty(filePath))
                            {
                                string rptName = rptPath.Contains("/")
                                    ? rptPath.Substring(rptPath.LastIndexOf('/') + 1)
                                    : rptPath;
                                string ext = GetExtension(fmt);
                                resolvedPath = baseFolder.TrimEnd('\\') + "\\" + rptName
                                    + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ext;
                            }

                            if (!string.IsNullOrEmpty(resolvedPath))
                            {
                                resolvedPath = ResolveTokens(resolvedPath, rptPath, fmt);
                            }

                            // Render report via URL Access
                            byte[] reportData = RenderViaUrlAccess(srvUrl, rptPath, fmt,
                                parms, user, pass, dom);

                            // Save to file
                            if (!string.IsNullOrEmpty(resolvedPath))
                            {
                                string dir = Path.GetDirectoryName(resolvedPath);
                                if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
                                    Directory.CreateDirectory(dir);

                                File.WriteAllBytes(resolvedPath, reportData);
                                message = "Exported to " + resolvedPath + " (" + reportData.Length + " bytes)";
                            }

                            // Email if configured
                            if (!string.IsNullOrEmpty(emailTo) && !string.IsNullOrEmpty(smtp))
                            {
                                string rptName = rptPath.Contains("/")
                                    ? rptPath.Substring(rptPath.LastIndexOf('/') + 1)
                                    : rptPath;
                                string ext = GetExtension(fmt);

                                using (var msg = new MailMessage())
                                {
                                    msg.From = new MailAddress(from ?? "reports@localhost");
                                    foreach (string addr in emailTo.Split(';'))
                                    {
                                        string trimmed = addr.Trim();
                                        if (!string.IsNullOrEmpty(trimmed))
                                            msg.To.Add(trimmed);
                                    }
                                    msg.Subject = emailSubject ?? "Report: " + rptName;
                                    msg.Body = "Please find the attached report.";

                                    using (var ms = new MemoryStream(reportData))
                                    {
                                        msg.Attachments.Add(new Attachment(ms, rptName + ext, GetMimeType(fmt)));
                                        using (var client = new SmtpClient(smtp, port))
                                        {
                                            client.UseDefaultCredentials = true;
                                            client.Send(msg);
                                        }
                                    }
                                }

                                message += (message.Length > 0 ? "; " : "") + "Emailed to " + emailTo;
                            }

                            successCount++;
                        }
                        catch (Exception ex)
                        {
                            status = "Failed";
                            message = ex.Message;
                            failCount++;
                        }

                        // Log status
                        if (!string.IsNullOrEmpty(statusTable) && !string.IsNullOrEmpty(jobId))
                        {
                            try
                            {
                                string insertSql = string.Format(
                                    "INSERT INTO {0} (JobId, Status, Message, ExportedAt) VALUES (@JobId, @Status, @Message, GETDATE())",
                                    statusTable);
                                using (var logCmd = new SqlCommand(insertSql, conn))
                                {
                                    logCmd.Parameters.AddWithValue("@JobId", jobId);
                                    logCmd.Parameters.AddWithValue("@Status", status);
                                    logCmd.Parameters.AddWithValue("@Message", message);
                                    logCmd.ExecuteNonQuery();
                                }
                            }
                            catch { /* Don't fail the job if logging fails */ }
                        }

                        SqlContext.Pipe.Send(string.Format("Job {0}: {1} - {2}", jobId ?? "?", status, message));
                    }
                }
            }

            SqlContext.Pipe.Send(string.Format(
                "Data-driven export complete. Success: {0}, Failed: {1}", successCount, failCount));
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  Report subscription management
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Lists active subscriptions for a report on the SSRS server.
    /// </summary>
    [SqlProcedure]
    public static void ListReportSubscriptions(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value.TrimEnd('/');
            string path = reportPath.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            string svcUrl = srv + "/ReportService2010.asmx";

            string soap = string.Format(
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
  <soap:Body>
    <ListSubscriptions xmlns=""http://schemas.microsoft.com/sqlserver/reporting/2010/03/01/ReportServer"">
      <ItemPathOrSiteURL>{0}</ItemPathOrSiteURL>
    </ListSubscriptions>
  </soap:Body>
</soap:Envelope>", XmlEscape(path));

            var request = CreateSoapRequest(svcUrl,
                "http://schemas.microsoft.com/sqlserver/reporting/2010/03/01/ReportServer/ListSubscriptions",
                user, pass, dom);

            var doc = SendSoapRequest(request, soap);

            SqlDataRecord record = new SqlDataRecord(
                new SqlMetaData("SubscriptionID", SqlDbType.NVarChar, 256),
                new SqlMetaData("Owner", SqlDbType.NVarChar, 256),
                new SqlMetaData("Description", SqlDbType.NVarChar, 4000),
                new SqlMetaData("Status", SqlDbType.NVarChar, 256),
                new SqlMetaData("LastExecuted", SqlDbType.NVarChar, 50),
                new SqlMetaData("DeliveryExtension", SqlDbType.NVarChar, 256),
                new SqlMetaData("IsActive", SqlDbType.Bit)
            );

            SqlContext.Pipe.SendResultsStart(record);

            var subNodes = doc.GetElementsByTagName("Subscription");
            foreach (XmlNode sub in subNodes)
            {
                record.SetSqlString(0, GetChildText(sub, "SubscriptionID"));
                record.SetSqlString(1, GetChildText(sub, "Owner"));
                record.SetSqlString(2, GetChildText(sub, "Description"));
                record.SetSqlString(3, GetChildText(sub, "Status"));
                record.SetSqlString(4, GetChildText(sub, "LastExecuted"));
                record.SetSqlString(5, GetChildText(sub, "DeliveryExtension"));
                string active = GetChildText(sub, "IsActive");
                record.SetBoolean(6, !string.IsNullOrEmpty(active) &&
                    active.Equals("true", StringComparison.OrdinalIgnoreCase));
                SqlContext.Pipe.SendResultsRow(record);
            }

            SqlContext.Pipe.SendResultsEnd();
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    // ──────────────────────────────────────────────────────────────
    //  Helper methods
    // ──────────────────────────────────────────────────────────────

    private static HttpWebRequest CreateSoapRequest(string url, string soapAction,
        string username, string password, string domain)
    {
        var request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = "POST";
        request.ContentType = "text/xml; charset=utf-8";
        request.Headers.Add("SOAPAction", soapAction);
        request.Timeout = 600000;

        if (!string.IsNullOrEmpty(username))
        {
            if (!string.IsNullOrEmpty(domain))
                request.Credentials = new NetworkCredential(username, password, domain);
            else
                request.Credentials = new NetworkCredential(username, password);
        }
        else
        {
            request.UseDefaultCredentials = true;
        }

        return request;
    }

    private static XmlDocument SendSoapRequest(HttpWebRequest request, string soapBody)
    {
        byte[] bodyBytes = Encoding.UTF8.GetBytes(soapBody);
        request.ContentLength = bodyBytes.Length;

        using (var stream = request.GetRequestStream())
        {
            stream.Write(bodyBytes, 0, bodyBytes.Length);
        }

        try
        {
            using (var response = request.GetResponse())
            using (var responseStream = response.GetResponseStream())
            {
                var doc = new XmlDocument();
                doc.Load(responseStream);
                return doc;
            }
        }
        catch (WebException wex)
        {
            if (wex.Response != null)
            {
                try
                {
                    using (var errStream = wex.Response.GetResponseStream())
                    using (var reader = new StreamReader(errStream))
                    {
                        string faultBody = reader.ReadToEnd();
                        var faultDoc = new XmlDocument();
                        faultDoc.LoadXml(faultBody);
                        var faultString = faultDoc.SelectSingleNode("//*[local-name()='faultstring']");
                        var message = faultDoc.SelectSingleNode("//*[local-name()='Message']");

                        string errorMsg = "SSRS SOAP Fault: ";
                        if (faultString != null) errorMsg += faultString.InnerText;
                        if (message != null) errorMsg += " | " + message.InnerText;

                        throw new Exception(errorMsg, wex);
                    }
                }
                catch (Exception parseEx)
                {
                    if (parseEx.InnerException == wex) throw;
                }
            }
            throw;
        }
    }

    private static string GetChildText(XmlNode parent, string localName)
    {
        var child = parent.SelectSingleNode("*[local-name()='" + localName + "']");
        return child != null ? child.InnerText : "";
    }

    private static string GetDictValue(Dictionary<string, string> dict, string key)
    {
        string value;
        return dict.TryGetValue(key, out value) ? value : null;
    }

    private static string GetExtension(string format)
    {
        switch ((format ?? "").ToUpper())
        {
            case "PDF": return ".pdf";
            case "EXCELOPENXML": return ".xlsx";
            case "EXCEL": return ".xls";
            case "WORDOPENXML": return ".docx";
            case "WORD": return ".doc";
            case "CSV": return ".csv";
            case "XML": return ".xml";
            case "HTML4.0":
            case "HTML5": return ".html";
            case "MHTML": return ".mhtml";
            case "IMAGE": return ".tiff";
            case "PPTX": return ".pptx";
            default: return ".bin";
        }
    }

    private static string GetMimeType(string format)
    {
        switch ((format ?? "").ToUpper())
        {
            case "PDF": return "application/pdf";
            case "EXCELOPENXML": return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            case "EXCEL": return "application/vnd.ms-excel";
            case "WORDOPENXML": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "WORD": return "application/msword";
            case "CSV": return "text/csv";
            case "XML": return "application/xml";
            case "HTML4.0":
            case "HTML5": return "text/html";
            case "MHTML": return "message/rfc822";
            case "IMAGE": return "image/tiff";
            case "PPTX": return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            default: return "application/octet-stream";
        }
    }

    private static string ResolveTokens(string path, string reportPath, string format)
    {
        string reportName = reportPath.Contains("/")
            ? reportPath.Substring(reportPath.LastIndexOf('/') + 1)
            : reportPath;

        return path
            .Replace("{ReportName}", reportName)
            .Replace("{Format}", format)
            .Replace("{Date}", DateTime.Now.ToString("yyyyMMdd"))
            .Replace("{DateTime}", DateTime.Now.ToString("yyyyMMdd_HHmmss"))
            .Replace("{Year}", DateTime.Now.Year.ToString())
            .Replace("{Month}", DateTime.Now.Month.ToString("D2"))
            .Replace("{Day}", DateTime.Now.Day.ToString("D2"));
    }
}
