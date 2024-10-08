codeunit 50030 "Custom Mail"
{

    trigger OnRun()
    begin
    end;

    var
        //SMTPCU: Codeunit 400;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        From: Text[50];
        To_: Text[50];
        MessageBody: Text[250];
        Subject: Text[250];
        ReportBookingSheetAllocation: Report "Booking Sheet Pre Alert";
        ClientTempPath: Text;
        gCduFileMgmt: Codeunit "File Management";
        gRecCustomer: Record Customer;
        gRecConsignee: Record Consignee;
        Error001: Label 'There is no email for Shipper %1';

    local procedure SendWithAttachment()
    begin
    end;

    local procedure SendWithoutAttachment()
    begin
        EmailMessage.Create(To_, Subject, MessageBody, TRUE);
        Email.Send(EmailMessage);
    end;


    procedure SendBookingSheetPreAlert("BSNo.": Code[50]) Mailed: Boolean
    var
        Header: Label 'Dear %1';
        Body: Label 'Please Note we have %1 %2 planned on %3 // %4. Please Find attached Flight Details. <br> All Export Documents i.e MAWB//Packing List//Commercial Invoice//Phyto Sanitary Certificate etc will be scanned prior to flight Depature';
        BookingSheetLine: Record "Booking Sheet Line";
        BookingSheetHeader: Record "Booking Sheet Header";
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        Window: Dialog;
        MailingConfiguration: Record "Mailing Configuration";
        BookingSheetHAWBAllocation1: Record "Booking Sheet HAWB Allocation";
        UserSetup: Record "User Setup";
        Subject: Text[250];
        Body1: Text[250];
        FlightNo: Code[50];
        FlightDate: Date;
        Route: Code[100];
        ConName: Text[250];

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttchmentOutStream: OutStream;
        AttcahmentInstream: InStream;
        BookingSheetPreAlert: Report "Booking Sheet Pre Alert";
        RecordrefVar: RecordRef;
        ToRecipient: Text;
    begin
        IF BookingSheetHeader.GET("BSNo.") THEN BEGIN
            Window.OPEN('Mailing To #1#####\Adding Emails #2#####');
            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", "BSNo.");
            IF BookingSheetLine.FINDSET THEN BEGIN
                REPEAT
                    BookingSheetMAWBAllocation.RESET;
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Booking Sheet No", BookingSheetLine."Booking Sheet No.");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Line No.", BookingSheetLine."Line No.");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Item No", BookingSheetLine."Item No.");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Airline Code", BookingSheetLine."Airline Code");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Flight No", BookingSheetLine."Flight Code");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Source Airport", BookingSheetLine."Source Airport");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Destination Airport", BookingSheetLine."Destination Airport");
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code", BookingSheetLine."Shipper Code");
                    IF BookingSheetMAWBAllocation.FINDSET THEN BEGIN
                        REPEAT
                            BookingSheetHAWBAllocation.RESET;
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Booking Sheet No.", BookingSheetMAWBAllocation."Booking Sheet No");
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Airline Code", BookingSheetMAWBAllocation."Airline Code");
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."MAWB No.", BookingSheetMAWBAllocation."MAWB No");
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Source Airport", BookingSheetMAWBAllocation."Source Airport");
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Destination Airport", BookingSheetMAWBAllocation."Destination Airport");
                            BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Shipper Code", BookingSheetMAWBAllocation."Shipper Code");
                            IF BookingSheetHAWBAllocation.FINDSET THEN BEGIN
                                REPEAT
                                    BookingSheetHAWBAllocation1.RESET;
                                    BookingSheetHAWBAllocation1.COPYFILTERS(BookingSheetHAWBAllocation);
                                    BookingSheetHAWBAllocation1.SETRANGE(BookingSheetHAWBAllocation1."Consignee Code", BookingSheetHAWBAllocation."Consignee Code");
                                    IF BookingSheetHAWBAllocation1.FINDFIRST THEN BEGIN
                                        //REPORT.RUN(50060,FALSE,FALSE,BookingSheetHAWBAllocation1);\
                                        //ClientTempPath := TEMPORARYPATH+'\Report.PDF';
                                        //ClientTempPath := gCduFileMgmt.ClientTempFileName('.PDF');
                                        //REPORT.SAVEASPDF(50060, ClientTempPath, BookingSheetHAWBAllocation1);
                                        SLEEP(5000);
                                        FlightNo := BookingSheetMAWBAllocation."Flight No";
                                        Route := BookingSheetMAWBAllocation."Source Airport" + '-' + BookingSheetMAWBAllocation."Destination Airport";
                                        FlightDate := BookingSheetHeader."Booking Date";
                                        ConName := BookingSheetHAWBAllocation1."Consignee Name";
                                        Subject := ConName + ' SHIPMENT PRE-ADVISE NOTIFICATION - ' + FlightNo + '//' + FORMAT(FlightDate) + ' ' + Route;
                                        Body1 := 'Dear ' + ConName + '. <BR>Please note we have ' + ConName + ' ' + BookingSheetLine.Description + ''' Planned on ' + FlightNo + '//' + FORMAT(FlightDate) + ' ' + Route;
                                        //UserSetup.GET(USERID);
                                        //SMTPCU.CreateMessage('Customer Service',UserSetup."E-Mail",UserSetup."E-Mail",Subject,Body1,TRUE);
                                        //SMTPCU.CreateMessage('Customer Service', 'bthota@technobraingroup.com', 'bthota@technobraingroup.com', Subject, Body1, TRUE);
                                        //SMTPCU.AddAttachment('C:\Temp NAV Reports\Report.pdf','Pre Alert.PDF');
                                        // SMTPCU.AddAttachment(ClientTempPath, 'Pre Alert.PDF');
                                        ToRecipient := 'bthota@technobraingroup.com';
                                        EmailMessage.Create(ToRecipient, Subject, Body1, true);
                                        EmailMessage.AppendToBody('<BR><BR>');
                                        EmailMessage.AppendToBody(body);
                                        AttachmentTempBlob.CreateOutStream(AttchmentOutStream, TextEncoding::UTF8);
                                        RecordrefVar.GetTable(BookingSheetHAWBAllocation1);
                                        BookingSheetPreAlert.SaveAs('', ReportFormat::Pdf, AttchmentOutStream, RecordrefVar);
                                        AttachmentTempBlob.CreateInStream(AttcahmentInstream);
                                        MailingConfiguration.RESET;
                                        //              MailingConfiguration.SETRANGE(MailingConfiguration.Type,MailingConfiguration.Type::Consignee);
                                        MailingConfiguration.SETFILTER(MailingConfiguration."No.", '=%1|%2', BookingSheetHAWBAllocation1."Consignee Code", BookingSheetHAWBAllocation."Shipper Code");
                                        MailingConfiguration.SETRANGE(MailingConfiguration."Exclude From Pre Alert", FALSE);
                                        IF MailingConfiguration.FINDSET THEN BEGIN
                                            REPEAT
                                                Window.UPDATE(1, BookingSheetHAWBAllocation."Consignee Name");
                                                Window.UPDATE(2, MailingConfiguration.Email);
                                                IF ToRecipient <> '' THEN
                                                    ToRecipient := ToRecipient + ';'; // Append semicolon to separate multiple recipients.

                                                ToRecipient := ToRecipient + MailingConfiguration.Email; // Add the email to the recipients list.
                                                SLEEP(1000);
                                            UNTIL MailingConfiguration.NEXT = 0;
                                        END;//MailingConfiguration
                                        Email.Send(EmailMessage);
                                        Mailed := TRUE;
                                    END;//BookingSheetHAWBAllocation1
                                UNTIL BookingSheetHAWBAllocation.NEXT = 0;
                            END;
                        UNTIL BookingSheetMAWBAllocation.NEXT = 0;
                    END;//BookingSheetMAWBAllocation
                UNTIL BookingSheetLine.NEXT = 0;
            END;//BookingSheetLine.
        END;
        EXIT(Mailed);
    end;

    local procedure SendBookingSheetPostAlert()
    begin
    end;


    procedure SendInvoice(InvoiceNo: Code[50]; BillTo: Code[50]) Mailed: Boolean
    var
        MailingConfiguration: Record "Mailing Configuration";
        Window: Dialog;
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesHeader1: Record "Sales Header";
        Subject: Text[100];
        Body: Text[250];
        UserSetup: Record "User Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
    begin
        IF SalesHeader.GET(SalesHeader."Document Type"::Invoice, InvoiceNo) THEN BEGIN
            Customer.GET(SalesHeader."Bill-to Customer No.");
            Body := 'Dear ' + Customer.Name + '<BR> Please Find Attached the Sales Invoice';
            SalesHeader1.RESET;
            SalesHeader1.SETRANGE(SalesHeader1."Document Type", SalesHeader1."Document Type"::Invoice);
            SalesHeader1.SETRANGE(SalesHeader1."No.", SalesHeader."No.");
            IF SalesHeader1.FINDFIRST THEN BEGIN
                REPORT.RUN(Report::"MAWB Invoice TP", FALSE, FALSE, SalesHeader1);

            END;//Customer Type
            SLEEP(2000);
            UserSetup.GET(USERID);
            EmailMessage.Create(UserSetup."E-Mail", UserSetup."E-Mail", 'Invoice', Body);
            EmailMessage.AddAttachment('C:\Temp NAV Reports\Report.pdf', 'Sales Invoice.PDF');
            MailingConfiguration.RESET;
            MailingConfiguration.SETRANGE(MailingConfiguration."No.", BillTo);
            MailingConfiguration.SETRANGE(MailingConfiguration."Exclude From Invoice", FALSE);
            IF MailingConfiguration.FINDSET THEN BEGIN
                Window.OPEN('Mailing To #1#### \ Adding Recepients #2#####');
                REPEAT
                    Window.UPDATE(1, MailingConfiguration.Name);
                    Window.UPDATE(2, MailingConfiguration.Email);
                    SMTPCU.AddRecipients(MailingConfiguration.Email);
                    SLEEP(1000);
                UNTIL MailingConfiguration.NEXT = 0;
                Email.Send(EmailMessage);
                Mailed := TRUE;
            END;//MailingConfiguration
        END;//SalesHeader
        EXIT(Mailed);
    end;


    procedure SendBookingSheetPreAlert2("BSNo.": Code[50]) Mailed: Boolean
    var
        Header: Label 'Dear %1';
        Body: Label 'Please Note we have %1 %2 planned on %3 // %4. Please Find attached Flight Details. <br> All Export Documents i.e MAWB//Packing List//Commercial Invoice//Phyto Sanitary Certificate etc will be scanned prior to flight Depature';
        lRecBookingSheetLine: Record "Booking Sheet Line";
        lRecBookingSheetHeader: Record "Booking Sheet Header";
        lRecBookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        lRecBookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        lDlgWindow: Dialog;
        lRecUserSetup: Record "User Setup";
        lTxtEmailSubject: Text;
        lTxtEmailBody: Text;
        TxtBody1: Label 'Dear %1,';
        lTxtAppendBody1: Text;
        lTxtAppendBody2: Text;
        lTxtAppendBody3: Text;
        lRecBookingSheetHAWBAllocConsignee: Record "Booking Sheet HAWB Allocation";
        // lRecSMTPSetup: Record "SMTP Mail Setup";
        EmailMessage: Codeunit "Email Message";
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttchmentOutStream: OutStream;
        AttcahmentInstream: InStream;
        BookingSheetPreAlert: Report "Booking Sheet Pre Alert";
        RecordrefVar: RecordRef;
        email: Codeunit Email;
    begin
        IF lRecBookingSheetHeader.GET("BSNo.") THEN BEGIN
            lDlgWindow.OPEN('Sending Pre Alerts....');
            lRecBookingSheetLine.RESET;
            lRecBookingSheetLine.SETRANGE(lRecBookingSheetLine."Booking Sheet No.", "BSNo.");
            IF lRecBookingSheetLine.FINDSET THEN
                REPEAT
                    IF (lRecBookingSheetLine."Send Email" = TRUE) AND (lRecBookingSheetLine."Email Sent" = FALSE) THEN BEGIN
                        lRecBookingSheetMAWBAllocation.RESET;
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Booking Sheet No", lRecBookingSheetLine."Booking Sheet No.");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Line No.", lRecBookingSheetLine."Line No.");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Item No", lRecBookingSheetLine."Item No.");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Airline Code", lRecBookingSheetLine."Airline Code");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Flight No", lRecBookingSheetLine."Flight Code");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Source Airport", lRecBookingSheetLine."Source Airport");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Destination Airport", lRecBookingSheetLine."Destination Airport");
                        lRecBookingSheetMAWBAllocation.SETRANGE(lRecBookingSheetMAWBAllocation."Shipper Code", lRecBookingSheetLine."Shipper Code");
                        IF lRecBookingSheetMAWBAllocation.FINDSET THEN
                            REPEAT
                                lRecBookingSheetHAWBAllocation.RESET;
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."Booking Sheet No.", lRecBookingSheetMAWBAllocation."Booking Sheet No");
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."Airline Code", lRecBookingSheetMAWBAllocation."Airline Code");
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."MAWB No.", lRecBookingSheetMAWBAllocation."MAWB No");
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."Source Airport", lRecBookingSheetMAWBAllocation."Source Airport");
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."Destination Airport", lRecBookingSheetMAWBAllocation."Destination Airport");
                                lRecBookingSheetHAWBAllocation.SETRANGE(lRecBookingSheetHAWBAllocation."Shipper Code", lRecBookingSheetMAWBAllocation."Shipper Code");
                                IF lRecBookingSheetHAWBAllocation.FINDSET THEN
                                    REPEAT
                                        IF lRecBookingSheetHAWBAllocation."Consignee Code" <> '' THEN BEGIN
                                            lRecBookingSheetHAWBAllocConsignee.RESET;
                                            lRecBookingSheetHAWBAllocConsignee.COPYFILTERS(lRecBookingSheetHAWBAllocation);
                                            lRecBookingSheetHAWBAllocConsignee.SETRANGE("Consignee Code", lRecBookingSheetHAWBAllocation."Consignee Code");
                                            IF lRecBookingSheetHAWBAllocConsignee.FINDFIRST THEN BEGIN
                                                //ClientTempPath := TEMPORARYPATH + '\Report.pdf';
                                                // REPORT.SAVEASPDF(50060, ClientTempPath, lRecBookingSheetHAWBAllocConsignee);

                                                AttachmentTempBlob.CreateOutStream(AttchmentOutStream, TextEncoding::UTF8);
                                                RecordrefVar.GetTable(lRecBookingSheetHAWBAllocConsignee);
                                                BookingSheetPreAlert.SaveAs('', ReportFormat::Pdf, AttchmentOutStream, RecordrefVar);
                                                AttachmentTempBlob.CreateInStream(AttcahmentInstream);
                                                //B2BUPG
                                                lTxtEmailSubject := lRecBookingSheetHAWBAllocation."Consignee Name" + ' SHIPMENT PRE-ADVISE NOTIFICATION - ' +
                                                                    lRecBookingSheetMAWBAllocation."Flight No" + '//' + FORMAT(lRecBookingSheetHeader."Booking Date") + ' ' +
                                                                    lRecBookingSheetMAWBAllocation."Source Airport" + '-' + lRecBookingSheetMAWBAllocation."Destination Airport";
                                                lRecUserSetup.GET(USERID);
                                                lRecSMTPSetup.GET;
                                                //Send to Shipper
                                                IF gRecCustomer.GET(lRecBookingSheetHAWBAllocConsignee."Shipper Code") THEN BEGIN
                                                    IF gRecCustomer."E-Mail" <> '' THEN BEGIN
                                                        EmailMessage.Create(lRecSMTPSetup."User ID", gRecCustomer."E-Mail", lTxtEmailSubject, lTxtEmailBody, TRUE);
                                                        //Appending Body to email as per shipper
                                                        lTxtAppendBody1 := 'Dear All,';
                                                        lTxtAppendBody2 := 'Please note your shipment is Planned on ' + lRecBookingSheetMAWBAllocation."Flight No" + '//' +
                                                                           FORMAT(lRecBookingSheetHeader."Booking Date") + ' ' + lRecBookingSheetMAWBAllocation."Source Airport" +
                                                                           '-' + lRecBookingSheetMAWBAllocation."Destination Airport";
                                                        EmailMessage.AppendtoBody(lTxtAppendBody1);
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody(lTxtAppendBody2);
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('Filght Details as per attached File.');
                                                        IF lRecBookingSheetLine.Comments <> '' THEN BEGIN
                                                            EmailMessage.AppendtoBody('<br>');
                                                            EmailMessage.AppendtoBody('<br>');
                                                            EmailMessage.AppendtoBody('<b>');
                                                            EmailMessage.AppendtoBody(lRecBookingSheetLine.Comments);
                                                            EmailMessage.AppendtoBody('</b>');
                                                        END;
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<b>');
                                                        EmailMessage.AppendtoBody('All Export document will be scanned prior to flight departure.');
                                                        EmailMessage.AppendtoBody('</b>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<b>');
                                                        EmailMessage.AppendtoBody('This is system generated Mail, For any queries Please report to customerservice@freightwings.co.ke');
                                                        EmailMessage.AppendtoBody('</b>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('Best Regards');
                                                        EmailMessage.AppendtoBody('<br>');
                                                        EmailMessage.AppendtoBody('FWL Customer Service');
                                                        EmailMessage.AddAttachment(ClientTempPath, 'Flight Details.pdf', '');
                                                        //Add CC's of Customer
                                                        IF gRecCustomer."Email/CC" <> '' THEN
                                                            SMTPCU.AddRecipients(gRecCustomer."Email/CC");
                                                        // Add Consignee Emails
                                                        IF gRecConsignee.GET(lRecBookingSheetHAWBAllocConsignee."Consignee Code") THEN BEGIN
                                                            IF gRecConsignee."E-Mail" <> '' THEN
                                                                SMTPCU.AddRecipients(gRecConsignee."E-Mail");
                                                            IF gRecConsignee."CC/Email" <> '' THEN
                                                                SMTPCU.AddRecipients(gRecConsignee."CC/Email");
                                                        END;
                                                        email.Send(EmailMessage);
                                                    END ELSE
                                                        ERROR(Error001, gRecCustomer.Name);
                                                END;
                                                Mailed := TRUE;
                                            END;// Check Consignee Code is Blank or not
                                        END;
                                    UNTIL lRecBookingSheetHAWBAllocation.NEXT = 0;
                            UNTIL lRecBookingSheetMAWBAllocation.NEXT = 0;
                        lRecBookingSheetLine."Email Sent" := TRUE;
                        lRecBookingSheetLine.MODIFY;
                    END;
                UNTIL lRecBookingSheetLine.NEXT = 0;
        END;
        lDlgWindow.CLOSE;
        EXIT(Mailed);
    end;
}

