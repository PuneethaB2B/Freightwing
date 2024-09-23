table 50072 "MAWB Invoice Notify Party"
{

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            TableRelation = "Sales Header".No.;
        }
        field(3; "Notify-Party No."; Code[20])
        {
        }
        field(4; "Notify-Party Name"; Text[50])
        {
        }
        field(9; "Source Code"; Code[20])
        {
        }
        field(10; "Source Type"; Option)
        {
            OptionMembers = " ",Shipper,Consignee;
        }
        field(11; "MAWB No."; Code[20])
        {
        }
        field(12; "HAWB No."; Code[20])
        {
        }
        field(13; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Invoice No.", "Notify-Party No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'Do you want to notify: %1';

    [Scope('Internal')]
    procedure EmailRecords(ShowRequestForm: Boolean)
    begin
        SendRecords(ShowRequestForm, TRUE);
    end;

    local procedure SendRecords(ShowRequestForm: Boolean; SendAsEmail: Boolean)
    var
        ReportSelections: Record "77";
        MAWBInvoiceNotifyParty: Record "50072";
        BookingSheetHeader: Record "50053";
    begin
        MAWBInvoiceNotifyParty.COPY(Rec);
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"MAWB Invoice");
        ReportSelections.SETFILTER("Report ID", '<>0');
        ReportSelections.FIND('-');
        REPEAT
            IF NOT CONFIRM(Text001, FALSE, MAWBInvoiceNotifyParty."Notify-Party Name") THEN
                EXIT;
            IF NOT SendAsEmail THEN BEGIN
                REPORT.RUNMODAL(ReportSelections."Report ID", ShowRequestForm, FALSE, MAWBInvoiceNotifyParty)
            END ELSE BEGIN
                REPEAT
                    SendReport(ReportSelections."Report ID", MAWBInvoiceNotifyParty);
                UNTIL MAWBInvoiceNotifyParty.NEXT = 0;
            END;
        UNTIL ReportSelections.NEXT = 0;
    end;

    local procedure SendReport(ReportId: Integer; var MAWBInvoiceNotifyParty: Record "50072")
    var
        DocumentMailing: Codeunit "50013";
        FileManagement: Codeunit "419";
        ServerAttachmentFilePath: Text[250];
    begin
        ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
        REPORT.SAVEASPDF(ReportId, ServerAttachmentFilePath, MAWBInvoiceNotifyParty);
        COMMIT;
        DocumentMailing.EmailFileFromMAWBInvoiceNotifyParty(MAWBInvoiceNotifyParty, ServerAttachmentFilePath);
    end;
}

