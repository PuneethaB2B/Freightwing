table 50049 "Good Receipt Notify Party"
{

    fields
    {
        field(1; "Good Receipt No."; Code[20])
        {
            //TableRelation = 50096.Field1;
        }
        field(2; "Airline Code"; Code[10])
        {
            TableRelation = Airline;
        }
        field(3; "Notify-Party No."; Code[20])
        {
            TableRelation = "Shipper Notify Party"."Notify-Party No." WHERE("Shipper Code" = FIELD("Shipper Code"));
        }
        field(4; "Notify-Party Name"; Text[50])
        {
        }
        field(5; "Item No."; Code[20])
        {
            TableRelation = "Shipper Item"."Item No.";
        }
        field(7; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(8; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No.";
        }
        field(9; "Source Code"; Code[20])
        {
        }
        field(10; "Source Type"; Option)
        {
            OptionMembers = " ",Shipper,Consignee;
        }
        field(11; "Line No."; Integer)
        {
        }
        field(12; "Source Airport"; Code[10])
        {
            Editable = false;
        }
        field(13; "Destination Airport"; Code[10])
        {
            Editable = false;
        }
        field(14; FAM; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Good Receipt No.", "Airline Code", "Flight Code", "Shipper Code", "Item No.", "Notify-Party No.", "Line No.", FAM)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ShipperNotifyParty: Record "Shipper Notify Party";
        Text001: Label 'Do you want to notify: %1';


    procedure EmailRecords(ShowRequestForm: Boolean)
    begin
        SendRecords(ShowRequestForm, TRUE);
    end;

    local procedure SendRecords(ShowRequestForm: Boolean; SendAsEmail: Boolean)
    var
        ReportSelections: Record "Report Selections";
        GoodReceiptNotifyParty: Record "Good Receipt Notify Party";
        BookingSheetHeader: Record "Booking Sheet Header";
    begin
        GoodReceiptNotifyParty.COPY(Rec);
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Goods Receipt Note");
        ReportSelections.SETFILTER("Report ID", '<>0');
        ReportSelections.FIND('-');
        REPEAT
            IF NOT CONFIRM(Text001, FALSE, GoodReceiptNotifyParty."Notify-Party Name") THEN
                EXIT;
            IF NOT SendAsEmail THEN BEGIN
                REPORT.RUNMODAL(ReportSelections."Report ID", ShowRequestForm, FALSE, GoodReceiptNotifyParty)
            END ELSE BEGIN
                REPEAT
                    SendReport(ReportSelections."Report ID", GoodReceiptNotifyParty);
                UNTIL GoodReceiptNotifyParty.NEXT = 0;
            END;
        UNTIL ReportSelections.NEXT = 0;
    end;

    local procedure SendReport(ReportId: Integer; var GoodReceiptNotifyParty: Record "Good Receipt Notify Party")
    var
        DocumentMailing: Codeunit "Export Document-Mailing";
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text[250];
        RecordRef: RecordRef;
        AttachmentOutStream: OutStream;
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttcahmentInstream: InStream;
        FileName: Text[250];
    begin
        FileName := 'GoodReceiptReport_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + '.pdf';
        AttachmentTempBlob.CreateOutStream(AttachmentOutStream, TextEncoding::UTF8);
        RecordRef.GetTable(GoodReceiptNotifyParty);
        REPORT.SaveAs(ReportId, '', ReportFormat::Pdf, AttachmentOutStream, RecordRef);
        AttachmentTempBlob.CreateInStream(AttcahmentInstream);
        COMMIT;
        DocumentMailing.EmailFileFromGoodReceiptNotifyParty(GoodReceiptNotifyParty, ServerAttachmentFilePath);


        // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
        // REPORT.SAVEASPDF(ReportId, ServerAttachmentFilePath, GoodReceiptNotifyParty);
        // COMMIT;
        // DocumentMailing.EmailFileFromGoodReceiptNotifyParty(GoodReceiptNotifyParty, ServerAttachmentFilePath); // B2BUPG handled above using streams
    end;
}

