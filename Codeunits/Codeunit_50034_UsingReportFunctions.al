codeunit 50034 "Using Report Functions"
{
    trigger OnRun()
    begin
        // Use the REPORT.RUNREQUESTPAGE function to run the request page to get report parameters
        XmlParameters := REPORT.RUNREQUESTPAGE(Report::Statement);
        CurrentUser := USERID;

        // Save the request page parameters to the database table
        // Cleanup
        IF ReportParameters.GET(116, CurrentUser) THEN
            ReportParameters.DELETE;
        ReportParameters.SETAUTOCALCFIELDS(Parameters);
        ReportParameters.ReportID := 116;
        ReportParameters.UserID := CurrentUser;
        ReportParameters.Parameters.CREATEOUTSTREAM(OStream, TEXTENCODING::UTF8);
        //MESSAGE(XmlParameters);
        OStream.WRITETEXT(XmlParameters);
        ReportParameters.INSERT;
        CLEAR(ReportParameters);
        XmlParameters := '';

        // Read the request page parameters from the database table
        ReportParameters.SETAUTOCALCFIELDS(Parameters);
        ReportParameters.GET(116, CurrentUser);
        ReportParameters.Parameters.CREATEINSTREAM(IStream, TEXTENCODING::UTF8);
        IStream.READTEXT(XmlParameters);

        // Use the REPORT.SAVEAS function to save the report as a PDF file

        ReportID := Report::"Statement";
        TempBlob.CreateOutStream(OStream, TextEncoding::UTF8);
        REPORT.SAVEAS(ReportID, XmlParameters, REPORTFORMAT::Pdf, OStream);
        TempBlob.CreateInStream(IStream);

        //Naveen B2BUPG
        // ClientTempPath := TEMPORARYPATH + '\Cust_Statement.pdf';
        // Content.CREATE(ClientTempPath);

        // Content.CREATEOUTSTREAM(OStream);

        // REPORT.SAVEAS(Report::Statement, XmlParameters, REPORTFORMAT::Pdf, OStream);

        // Content.CLOSE;
        ReportParameters.GET(116, CurrentUser);
        //MESSAGE(FORMAT(ReportParameters.ToEmail));
        // SmtpSetup.GET;
        CLEAR(lTxtMergeBody);
        EmailMessage.Create(ReportParameters.ToEmail, 'Customer Statement', '', TRUE);
        //EmailMessage.Create('Freight Wings', SmtpSetup."User ID", ReportParameters.ToEmail, 'Customer Statement', '', TRUE); 
        //Naveen B2BUPG
        EmailMessage.AppendtoBody(lTxtBody1);
        EmailMessage.AppendtoBody('<br>');
        lTxtMergeBody := lTxtBody2 + ' ' + FORMAT(ReportParameters."Statement Period End Date") + '.';
        EmailMessage.AppendtoBody(lTxtMergeBody);
        EmailMessage.AppendtoBody('<br><br>');
        EmailMessage.AppendtoBody(lTxtBody3);
        EmailMessage.AppendtoBody('<br><br>');
        EmailMessage.AppendtoBody(lTxtBody4);
        EmailMessage.AppendtoBody('<br>');
        EmailMessage.AppendtoBody(lTxtBody5);
        EmailMessage.AddAttachment(ClientTempPath, 'Customer Statement.pdf', '');
        Email.Send(EmailMessage);
        MESSAGE('Customer Statement successfully send');

        // Use the REPORT.EXECUTE function to preview the report

        //REPORT.EXECUTE(206,XmlParameters);

        // Use the REPORT.Print function to print the report

        //REPORT.PRINT(206,XmlParameters);
    end;

    var
        ReportParameters: Record "Report Request Parameters";
        XmlParameters: Text;
        OStream: OutStream;
        IStream: InStream;
        CurrentUser: Code[100];
        Content: File;
        TempFileName: Text;
        ClientTempPath: Text;
        //SMTP: Codeunit 400;
        //SmtpSetup: Record "SMTP Mail Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        lTxtBody1: Label 'Dear All,';
        lTxtBody2: Label 'Please find attached Statement of account as at';
        lTxtBody3: Label 'In case of any query noted, please report them to invoice.query@freightwings.co.ke for necessary response';
        lTxtBody4: Label 'Best Regards,';
        lTxtBody5: Label 'FWL Accounts';
        lTxtMergeBody: Text;
        TempBlob: Codeunit "Temp Blob";
        ReportID: Integer;
        Body: Text;
}

