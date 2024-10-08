pageextension 50011 PostedSalesCreditMemosExt extends "Posted Sales Credit Memos"
{
    layout
    {
        addafter("Posting Date")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Document Date")
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
            }
        }
        moveafter("No."; "Posting Date")
        addbefore(Control1900383207)
        {
            part(CrQRCode; "Cr. QR Code.")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        modify("Send by &Email")
        {
            ApplicationArea = all;
            trigger OnAfterAction()
            var
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
            begin
                EmailCreditMemo(SalesCrMemoHeader);
            end;
        }
        addafter("&Navigate")
        {
            action("Create Tims")
            {
                Caption = 'Create Tims';
                ApplicationArea = all;
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TIMSManager: Codeunit "TIMS Manager.";
                begin
                    TIMSManager.ProcessSalesDocument(Rec);
                end;
            }
            action("Generate JSON")
            {
                Caption = 'Generate JSON';
                ApplicationArea = all;
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TIMSManager: Codeunit "TIMS Manager.";
                begin
                    TIMSManager.GetJSONData(Rec);
                end;
            }
        }
    }

    PROCEDURE EmailCreditMemo(pRecSalesCrMemoHeader: Record "Sales Cr.Memo Header");
    VAR
        ReportSelections: Record "Report Selections";
        lRecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        DocumentMailing: Codeunit "Document-Mailing";
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text[250];
        AttachmentFileName: Text[250];
        ReportAsPdfFileNameMsg: Label '@@@="%1 = Document Type %2 = Invoice No.";ENU=Sales %1 %2.pdf';
        EmailBody: Record "Email Body";
        EmailBody2: Record "Email Body";
        SMTPSetup: Record "SMTP Mail Setup";
        Customer: Record Customer;
        EmailSubjectCapTxt: Label '@@@="%1 = Customer Name. %2 = Document Type %3 = Invoice No.";ENU=%1 - %2 %3';
        EmailBodyPage: Page "Email Body";
        SMTPMail: Codeunit 400;
        EmailMessage: Codeunit "Email Message";
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttchmentOutStream: OutStream;
        AttcahmentInstream: InStream;
        RecordrefVar: RecordRef;
        StandardSalesCreditMem: Report "Standard Sales - Credit Memo";
    BEGIN
        WITH pRecSalesCrMemoHeader DO BEGIN
            // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
            lRecSalesCrMemoHeader.RESET;
            lRecSalesCrMemoHeader.SETRANGE(lRecSalesCrMemoHeader."No.", pRecSalesCrMemoHeader."No.");
            IF lRecSalesCrMemoHeader.FINDFIRST THEN
                //REPORT.SAVEASPDF(207, ServerAttachmentFilePath, lRecSalesCrMemoHeader);  //B2BUPG

                AttachmentTempBlob.CreateOutStream(AttchmentOutStream, TextEncoding::UTF8);
            RecordrefVar.GetTable(lRecSalesCrMemoHeader);
            StandardSalesCreditMem.SaveAs('', ReportFormat::Pdf, AttchmentOutStream, RecordrefVar);
            AttachmentTempBlob.CreateInStream(AttcahmentInstream);


            COMMIT;
            AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg, 'Credit Memos', pRecSalesCrMemoHeader."No.");
            //Insert Into Email Body.
            SMTPSetup.GET;
            Customer.GET(pRecSalesCrMemoHeader."Bill-to Customer No.");
            //Delete
            EmailBody2.RESET;
            EmailBody2.DELETEALL;
            //Insert
            EmailBody2.INIT;
            EmailBody2."No." := pRecSalesCrMemoHeader."No.";
            EmailBody2."From Address" := SMTPSetup."User ID";
            EmailBody2."To Address" := Customer."E-Mail";
            EmailBody2."CC Email" := Customer."Email/CC";
            EmailBody2.Subject := COPYSTR(
                                  STRSUBSTNO(
                                  EmailSubjectCapTxt, pRecSalesCrMemoHeader."Bill-to Name", 'Credit Memos', pRecSalesCrMemoHeader."No."), 1,
                            MAXSTRLEN(EmailBody2.Subject));
            EmailBody2."Attachment Path" := ServerAttachmentFilePath;
            EmailBody2."Attachment Name" := AttachmentFileName;
            EmailBody2.INSERT;
            COMMIT;
            EmailBody.GET(pRecSalesCrMemoHeader."No.");
            IF (PAGE.RUNMODAL(PAGE::Page50237, EmailBody) = ACTION::LookupOK) THEN BEGIN
                SMTPMail.CreateMessage('Freight Wings', EmailBody."From Address", EmailBody."To Address", EmailBody.Subject, EmailBody.Body, FALSE);
                IF EmailBody."CC Email" <> '' THEN
                    SMTPMail.AddCC(EmailBody."CC Email");
                SMTPMail.AddAttachment(EmailBody."Attachment Path", EmailBody."Attachment Name");
                SMTPMail.Send;
                MESSAGE('Send');
            END ELSE
                MESSAGE('Cancelled');
        END;
    END;
}