using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.IO;
using System.Net;
using System.Text;
using System.Xml;
using Microsoft.SqlServer.Server;

/// <summary>
/// SQL Server CLR Assembly for dynamic SSRS report generation.
/// Provides stored procedures and functions to:
///   - Export reports to PDF, Excel, Word, CSV, XML, HTML, TIFF, MHTML
///   - Query report parameters dynamically
///   - List reports and folders on a report server
///   - Render reports with dynamic parameter binding
///
/// Uses the SSRS ReportExecution2005 and ReportService2010 SOAP endpoints.
/// </summary>
public class SSRSReportGenerator
{
    // ──────────────────────────────────────────────────────────────
    //  SOAP envelope templates
    // ──────────────────────────────────────────────────────────────

    private const string SoapLoadReportTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Body>
    <LoadReport xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <Report>{0}</Report>
    </LoadReport>
  </soap:Body>
</soap:Envelope>";

    private const string SoapSetParametersTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Header>
    <ExecutionHeader xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <ExecutionID>{0}</ExecutionID>
    </ExecutionHeader>
  </soap:Header>
  <soap:Body>
    <SetExecutionParameters xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <Parameters>{1}</Parameters>
      <ParameterLanguage>en-us</ParameterLanguage>
    </SetExecutionParameters>
  </soap:Body>
</soap:Envelope>";

    private const string SoapRenderTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Header>
    <ExecutionHeader xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <ExecutionID>{0}</ExecutionID>
    </ExecutionHeader>
  </soap:Header>
  <soap:Body>
    <Render xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <Format>{1}</Format>
      <DeviceInfo>{2}</DeviceInfo>
    </Render>
  </soap:Body>
</soap:Envelope>";

    private const string SoapGetParametersTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Body>
    <GetItemParameters xmlns=""http://schemas.microsoft.com/sqlserver/reporting/2010/03/01/ReportServer"">
      <ItemPath>{0}</ItemPath>
      <ForRendering>true</ForRendering>
    </GetItemParameters>
  </soap:Body>
</soap:Envelope>";

    private const string SoapListChildrenTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Body>
    <ListChildren xmlns=""http://schemas.microsoft.com/sqlserver/reporting/2010/03/01/ReportServer"">
      <ItemPath>{0}</ItemPath>
      <Recursive>{1}</Recursive>
    </ListChildren>
  </soap:Body>
</soap:Envelope>";

    private const string SoapGetParametersFromExecTemplate =
@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/""
               xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance""
               xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">
  <soap:Header>
    <ExecutionHeader xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"">
      <ExecutionID>{0}</ExecutionID>
    </ExecutionHeader>
  </soap:Header>
  <soap:Body>
    <GetExecutionInfo xmlns=""http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices"" />
  </soap:Body>
</soap:Envelope>";

    // ──────────────────────────────────────────────────────────────
    //  Namespace manager helper
    // ──────────────────────────────────────────────────────────────

    private static readonly string NsExec = "http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices";
    private static readonly string NsSoap = "http://schemas.xmlsoap.org/soap/envelope/";

    private static XmlNamespaceManager BuildNsMgr(XmlDocument doc)
    {
        var nsMgr = new XmlNamespaceManager(doc.NameTable);
        nsMgr.AddNamespace("soap", NsSoap);
        nsMgr.AddNamespace("rs", NsExec);
        return nsMgr;
    }

    // ──────────────────────────────────────────────────────────────
    //  HTTP helpers
    // ──────────────────────────────────────────────────────────────

    private static HttpWebRequest CreateSoapRequest(string url, string soapAction,
        string username, string password, string domain)
    {
        var request = (HttpWebRequest)WebRequest.Create(url);
        request.Method = "POST";
        request.ContentType = "text/xml; charset=utf-8";
        request.Headers.Add("SOAPAction", soapAction);
        request.Timeout = 600000; // 10 minutes

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
            // Capture the SOAP fault detail from the response body
            if (wex.Response != null)
            {
                try
                {
                    using (var errStream = wex.Response.GetResponseStream())
                    using (var reader = new System.IO.StreamReader(errStream))
                    {
                        string faultBody = reader.ReadToEnd();

                        // Try to extract the SOAP fault message
                        var faultDoc = new XmlDocument();
                        faultDoc.LoadXml(faultBody);
                        var faultString = faultDoc.SelectSingleNode("//*[local-name()='faultstring']");
                        var detail = faultDoc.SelectSingleNode("//*[local-name()='Detail']")
                            ?? faultDoc.SelectSingleNode("//*[local-name()='detail']");
                        var message = faultDoc.SelectSingleNode("//*[local-name()='Message']");

                        string errorMsg = "SSRS SOAP Fault: ";
                        if (faultString != null) errorMsg += faultString.InnerText;
                        if (message != null) errorMsg += " | " + message.InnerText;
                        if (detail != null && message == null) errorMsg += " | " + detail.InnerText;

                        throw new Exception(errorMsg, wex);
                    }
                }
                catch (Exception parseEx)
                {
                    if (parseEx.InnerException == wex) throw;
                    // If we can't parse the fault, throw the original
                }
            }
            throw;
        }
    }

    private static byte[] SendSoapRequestRaw(HttpWebRequest request, string soapBody)
    {
        byte[] bodyBytes = Encoding.UTF8.GetBytes(soapBody);
        request.ContentLength = bodyBytes.Length;

        using (var stream = request.GetRequestStream())
        {
            stream.Write(bodyBytes, 0, bodyBytes.Length);
        }

        using (var response = request.GetResponse())
        using (var responseStream = response.GetResponseStream())
        using (var ms = new MemoryStream())
        {
            byte[] buffer = new byte[8192];
            int read;
            while ((read = responseStream.Read(buffer, 0, buffer.Length)) > 0)
                ms.Write(buffer, 0, read);
            return ms.ToArray();
        }
    }

    private static string XmlEscape(string value)
    {
        if (string.IsNullOrEmpty(value)) return "";
        return value.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;")
                     .Replace("\"", "&quot;").Replace("'", "&apos;");
    }

    // ──────────────────────────────────────────────────────────────
    //  Core: Load report and get execution ID
    // ──────────────────────────────────────────────────────────────

    private static string LoadReport(string serverUrl, string reportPath,
        string username, string password, string domain)
    {
        string execUrl = serverUrl.TrimEnd('/') + "/ReportExecution2005.asmx";
        string soap = string.Format(SoapLoadReportTemplate, XmlEscape(reportPath));

        var request = CreateSoapRequest(execUrl,
            "http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices/LoadReport",
            username, password, domain);

        var doc = SendSoapRequest(request, soap);
        var nsMgr = BuildNsMgr(doc);

        var execIdNode = doc.SelectSingleNode("//rs:LoadReportResponse/rs:executionInfo/rs:ExecutionID", nsMgr);
        if (execIdNode == null)
            execIdNode = doc.SelectSingleNode("//*[local-name()='ExecutionID']");

        if (execIdNode == null)
            throw new Exception("Failed to load report. Could not retrieve ExecutionID. Response: "
                + doc.OuterXml.Substring(0, Math.Min(doc.OuterXml.Length, 500)));

        return execIdNode.InnerText;
    }

    // ──────────────────────────────────────────────────────────────
    //  Core: Set parameters on loaded execution
    // ──────────────────────────────────────────────────────────────

    private static void SetParameters(string serverUrl, string executionId,
        string parametersXml, string username, string password, string domain)
    {
        if (string.IsNullOrEmpty(parametersXml)) return;

        string execUrl = serverUrl.TrimEnd('/') + "/ReportExecution2005.asmx";
        string soap = string.Format(SoapSetParametersTemplate, executionId, parametersXml);

        var request = CreateSoapRequest(execUrl,
            "http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices/SetExecutionParameters",
            username, password, domain);

        SendSoapRequest(request, soap);
    }

    // ──────────────────────────────────────────────────────────────
    //  Core: Render report
    // ──────────────────────────────────────────────────────────────

    private static byte[] RenderReport(string serverUrl, string executionId,
        string format, string deviceInfo, string username, string password, string domain)
    {
        string execUrl = serverUrl.TrimEnd('/') + "/ReportExecution2005.asmx";
        string soap = string.Format(SoapRenderTemplate, executionId,
            XmlEscape(format), XmlEscape(deviceInfo ?? ""));

        var request = CreateSoapRequest(execUrl,
            "http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices/Render",
            username, password, domain);

        var doc = SendSoapRequest(request, soap);
        var resultNode = doc.SelectSingleNode("//*[local-name()='Result']");

        if (resultNode == null)
            throw new Exception("Render failed. No result node in response.");

        return Convert.FromBase64String(resultNode.InnerText);
    }

    // ──────────────────────────────────────────────────────────────
    //  Parameter XML builder from delimited string
    //  Format: "ParamName1=Value1;ParamName2=Value2"
    //  Multi-value: "ParamName1=Val1,Val2,Val3;ParamName2=ValA"
    // ──────────────────────────────────────────────────────────────

    private static string BuildParametersXml(string parameterString)
    {
        if (string.IsNullOrEmpty(parameterString)) return "";

        var sb = new StringBuilder();
        string[] pairs = parameterString.Split(';');

        foreach (string pair in pairs)
        {
            string trimmed = pair.Trim();
            if (string.IsNullOrEmpty(trimmed)) continue;

            int eqIdx = trimmed.IndexOf('=');
            if (eqIdx < 0) continue;

            string name = trimmed.Substring(0, eqIdx).Trim();
            string value = trimmed.Substring(eqIdx + 1).Trim();

            // Support multi-value parameters (comma-separated)
            string[] values = value.Split(',');
            foreach (string v in values)
            {
                sb.AppendFormat(
                    "<ParameterValue><Name>{0}</Name><Value>{1}</Value></ParameterValue>",
                    XmlEscape(name), XmlEscape(v.Trim()));
            }
        }

        return sb.ToString();
    }

    // ══════════════════════════════════════════════════════════════
    //  PUBLIC CLR STORED PROCEDURES
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Exports an SSRS report and returns the content as VARBINARY(MAX).
    /// Supported formats: PDF, EXCELOPENXML, EXCEL, WORDOPENXML, WORD,
    ///   CSV, XML, HTML4.0, HTML5, MHTML, IMAGE (TIFF), PPTX
    /// </summary>
    [SqlProcedure]
    public static void ExportReport(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString exportFormat,
        SqlString parameters,       // "Param1=Val1;Param2=Val2"
        SqlString deviceInfo,       // optional XML device info
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value;
            string path = reportPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = parameters.IsNull ? null : parameters.Value;
            string devInfo = deviceInfo.IsNull ? null : deviceInfo.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            string executionId = LoadReport(srv, path, user, pass, dom);

            string paramsXml = BuildParametersXml(parms);
            SetParameters(srv, executionId, paramsXml, user, pass, dom);

            byte[] result = RenderReport(srv, executionId, fmt, devInfo, user, pass, dom);

            // Send result set back
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
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    /// <summary>
    /// Exports an SSRS report and saves it to a file on disk.
    /// </summary>
    [SqlProcedure]
    public static void ExportReportToFile(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString exportFormat,
        SqlString parameters,
        SqlString outputFilePath,
        SqlString deviceInfo,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value;
            string path = reportPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = parameters.IsNull ? null : parameters.Value;
            string outPath = outputFilePath.Value;
            string devInfo = deviceInfo.IsNull ? null : deviceInfo.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            string executionId = LoadReport(srv, path, user, pass, dom);

            string paramsXml = BuildParametersXml(parms);
            SetParameters(srv, executionId, paramsXml, user, pass, dom);

            byte[] result = RenderReport(srv, executionId, fmt, devInfo, user, pass, dom);

            // Ensure output directory exists
            string dir = Path.GetDirectoryName(outPath);
            if (!string.IsNullOrEmpty(dir) && !Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            File.WriteAllBytes(outPath, result);

            SqlContext.Pipe.Send(string.Format("Report exported successfully to {0} ({1} bytes, format: {2})",
                outPath, result.Length, fmt));
        }
        catch (Exception ex)
        {
            SqlContext.Pipe.Send("ERROR: " + ex.Message);
            throw;
        }
    }

    /// <summary>
    /// Returns the parameters defined on an SSRS report, including
    /// name, type, nullable, allow blank, multi-value, default values, and valid values.
    /// Uses LoadReport + GetExecutionInfo via the ReportExecution2005 endpoint
    /// (same endpoint used for rendering, proven to work).
    /// </summary>
    [SqlProcedure]
    public static void GetReportParameters(
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

            // Step 1: Load the report to get an execution ID
            string executionId = LoadReport(srv, path, user, pass, dom);

            // Step 2: Call GetExecutionInfo to retrieve parameters
            string execUrl = srv + "/ReportExecution2005.asmx";
            string soap = string.Format(SoapGetParametersFromExecTemplate, executionId);

            var request = CreateSoapRequest(execUrl,
                "http://schemas.microsoft.com/sqlserver/2005/06/30/reporting/reportingservices/GetExecutionInfo",
                user, pass, dom);

            var doc = SendSoapRequest(request, soap);

            SqlDataRecord record = new SqlDataRecord(
                new SqlMetaData("Name", SqlDbType.NVarChar, 256),
                new SqlMetaData("DataType", SqlDbType.NVarChar, 50),
                new SqlMetaData("Nullable", SqlDbType.Bit),
                new SqlMetaData("AllowBlank", SqlDbType.Bit),
                new SqlMetaData("MultiValue", SqlDbType.Bit),
                new SqlMetaData("Prompt", SqlDbType.NVarChar, 1000),
                new SqlMetaData("PromptUser", SqlDbType.Bit),
                new SqlMetaData("DefaultValues", SqlDbType.NVarChar, 4000),
                new SqlMetaData("ValidValues", SqlDbType.NVarChar, 4000),
                new SqlMetaData("QueryBased", SqlDbType.Bit)
            );

            SqlContext.Pipe.SendResultsStart(record);

            // GetExecutionInfo returns parameters under ReportParameter nodes
            var paramNodes = doc.GetElementsByTagName("ReportParameter");
            foreach (XmlNode paramNode in paramNodes)
            {
                string name = GetChildText(paramNode, "Name");
                string dataType = GetChildText(paramNode, "Type");

                bool nullable = GetChildBool(paramNode, "Nullable");
                bool allowBlank = GetChildBool(paramNode, "AllowBlank");
                bool multiValue = GetChildBool(paramNode, "MultiValue");
                string prompt = GetChildText(paramNode, "Prompt");
                bool promptUser = GetChildBool(paramNode, "PromptUser");

                // Collect default values
                var defaults = new List<string>();
                var defaultNodes = paramNode.SelectNodes("*[local-name()='DefaultValues']/*[local-name()='Value']");
                if (defaultNodes != null)
                    foreach (XmlNode dv in defaultNodes)
                        defaults.Add(dv.InnerText);

                // Collect valid values
                var valids = new List<string>();
                var validNodes = paramNode.SelectNodes("*[local-name()='ValidValues']/*[local-name()='ValidValue']");
                if (validNodes != null)
                {
                    foreach (XmlNode vv in validNodes)
                    {
                        string label = GetChildText(vv, "Label");
                        string val = GetChildText(vv, "Value");
                        valids.Add(string.IsNullOrEmpty(label) ? val : label + "=" + val);
                    }
                }

                bool queryBased = GetChildBool(paramNode, "QueryParameter");

                record.SetSqlString(0, name);
                record.SetSqlString(1, dataType);
                record.SetBoolean(2, nullable);
                record.SetBoolean(3, allowBlank);
                record.SetBoolean(4, multiValue);
                record.SetSqlString(5, string.IsNullOrEmpty(prompt) ? SqlString.Null : new SqlString(prompt));
                record.SetBoolean(6, promptUser);
                record.SetSqlString(7, defaults.Count > 0
                    ? new SqlString(string.Join(",", defaults.ToArray()))
                    : SqlString.Null);
                record.SetSqlString(8, valids.Count > 0
                    ? new SqlString(string.Join("|", valids.ToArray()))
                    : SqlString.Null);
                record.SetBoolean(9, queryBased);

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

    /// <summary>
    /// Lists reports and folders on the SSRS server under a given path.
    /// </summary>
    [SqlProcedure]
    public static void ListReports(
        SqlString serverUrl,
        SqlString folderPath,
        SqlBoolean recursive,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value.TrimEnd('/');
            string folder = folderPath.IsNull ? "/" : folderPath.Value;
            bool recurse = recursive.IsNull ? false : recursive.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            string svcUrl = srv + "/ReportService2010.asmx";
            string soap = string.Format(SoapListChildrenTemplate,
                XmlEscape(folder), recurse.ToString().ToLower());

            var request = CreateSoapRequest(svcUrl,
                "http://schemas.microsoft.com/sqlserver/reporting/2010/03/01/ReportServer/ListChildren",
                user, pass, dom);

            var doc = SendSoapRequest(request, soap);

            SqlDataRecord record = new SqlDataRecord(
                new SqlMetaData("ItemPath", SqlDbType.NVarChar, 1000),
                new SqlMetaData("Name", SqlDbType.NVarChar, 256),
                new SqlMetaData("TypeName", SqlDbType.NVarChar, 100),
                new SqlMetaData("Description", SqlDbType.NVarChar, 4000),
                new SqlMetaData("Hidden", SqlDbType.Bit),
                new SqlMetaData("CreationDate", SqlDbType.NVarChar, 50),
                new SqlMetaData("ModifiedDate", SqlDbType.NVarChar, 50)
            );

            SqlContext.Pipe.SendResultsStart(record);

            var items = doc.GetElementsByTagName("CatalogItem");
            foreach (XmlNode item in items)
            {
                record.SetSqlString(0, GetChildText(item, "Path"));
                record.SetSqlString(1, GetChildText(item, "Name"));
                record.SetSqlString(2, GetChildText(item, "TypeName"));
                string desc = GetChildText(item, "Description");
                record.SetSqlString(3, string.IsNullOrEmpty(desc) ? SqlString.Null : new SqlString(desc));
                record.SetBoolean(4, GetChildBool(item, "Hidden"));
                record.SetSqlString(5, GetChildText(item, "CreationDate"));
                record.SetSqlString(6, GetChildText(item, "ModifiedDate"));
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

    // ══════════════════════════════════════════════════════════════
    //  PUBLIC CLR SCALAR FUNCTIONS
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Returns report content as VARBINARY(MAX) - usable in SELECT statements.
    /// </summary>
    [SqlFunction(DataAccess = DataAccessKind.None,
        SystemDataAccess = SystemDataAccessKind.None,
        IsDeterministic = false)]
    public static SqlBinary fn_ExportReport(
        SqlString serverUrl,
        SqlString reportPath,
        SqlString exportFormat,
        SqlString parameters,
        SqlString deviceInfo,
        SqlString username,
        SqlString password,
        SqlString domain)
    {
        try
        {
            string srv = serverUrl.Value;
            string path = reportPath.Value;
            string fmt = exportFormat.IsNull ? "PDF" : exportFormat.Value.ToUpper();
            string parms = parameters.IsNull ? null : parameters.Value;
            string devInfo = deviceInfo.IsNull ? null : deviceInfo.Value;
            string user = username.IsNull ? null : username.Value;
            string pass = password.IsNull ? null : password.Value;
            string dom = domain.IsNull ? null : domain.Value;

            string executionId = LoadReport(srv, path, user, pass, dom);

            string paramsXml = BuildParametersXml(parms);
            SetParameters(srv, executionId, paramsXml, user, pass, dom);

            byte[] result = RenderReport(srv, executionId, fmt, devInfo, user, pass, dom);
            return new SqlBinary(result);
        }
        catch (Exception ex)
        {
            throw new Exception("fn_ExportReport failed: " + ex.Message, ex);
        }
    }

    /// <summary>
    /// Returns the suggested file extension for a given export format.
    /// </summary>
    [SqlFunction(IsDeterministic = true)]
    public static SqlString fn_GetFormatExtension(SqlString exportFormat)
    {
        if (exportFormat.IsNull) return SqlString.Null;

        switch (exportFormat.Value.ToUpper())
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

    /// <summary>
    /// Validates an export format string. Returns 1 if valid, 0 if not.
    /// </summary>
    [SqlFunction(IsDeterministic = true)]
    public static SqlBoolean fn_IsValidFormat(SqlString exportFormat)
    {
        if (exportFormat.IsNull) return SqlBoolean.False;

        switch (exportFormat.Value.ToUpper())
        {
            case "PDF":
            case "EXCELOPENXML":
            case "EXCEL":
            case "WORDOPENXML":
            case "WORD":
            case "CSV":
            case "XML":
            case "HTML4.0":
            case "HTML5":
            case "MHTML":
            case "IMAGE":
            case "PPTX":
                return SqlBoolean.True;
            default:
                return SqlBoolean.False;
        }
    }

    // ══════════════════════════════════════════════════════════════
    //  PUBLIC CLR TABLE-VALUED FUNCTION
    // ══════════════════════════════════════════════════════════════

    /// <summary>
    /// Returns all supported export formats as a table.
    /// </summary>
    [SqlFunction(FillRowMethodName = "FillFormatRow",
        TableDefinition = "FormatName NVARCHAR(50), Extension NVARCHAR(10), Description NVARCHAR(200)")]
    public static System.Collections.IEnumerable fn_ListExportFormats()
    {
        var formats = new List<string[]>();
        formats.Add(new[] { "PDF", ".pdf", "Adobe PDF document" });
        formats.Add(new[] { "EXCELOPENXML", ".xlsx", "Microsoft Excel 2007+ workbook (Open XML)" });
        formats.Add(new[] { "EXCEL", ".xls", "Microsoft Excel 97-2003 workbook" });
        formats.Add(new[] { "WORDOPENXML", ".docx", "Microsoft Word 2007+ document (Open XML)" });
        formats.Add(new[] { "WORD", ".doc", "Microsoft Word 97-2003 document" });
        formats.Add(new[] { "CSV", ".csv", "Comma-separated values" });
        formats.Add(new[] { "XML", ".xml", "XML data" });
        formats.Add(new[] { "HTML4.0", ".html", "HTML 4.0 web page" });
        formats.Add(new[] { "HTML5", ".html", "HTML5 web page" });
        formats.Add(new[] { "MHTML", ".mhtml", "MIME HTML web archive" });
        formats.Add(new[] { "IMAGE", ".tiff", "TIFF image" });
        formats.Add(new[] { "PPTX", ".pptx", "Microsoft PowerPoint 2007+ presentation" });
        return formats;
    }

    public static void FillFormatRow(object obj, out SqlString formatName,
        out SqlString extension, out SqlString description)
    {
        string[] row = (string[])obj;
        formatName = row[0];
        extension = row[1];
        description = row[2];
    }

    // ──────────────────────────────────────────────────────────────
    //  XML helper methods
    // ──────────────────────────────────────────────────────────────

    private static string GetChildText(XmlNode parent, string localName)
    {
        var child = parent.SelectSingleNode("*[local-name()='" + localName + "']");
        return child != null ? child.InnerText : "";
    }

    private static bool GetChildBool(XmlNode parent, string localName)
    {
        string text = GetChildText(parent, localName);
        return !string.IsNullOrEmpty(text) && text.Equals("true", StringComparison.OrdinalIgnoreCase);
    }
}
