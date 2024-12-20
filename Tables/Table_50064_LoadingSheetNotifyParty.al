table 50064 "Loading Sheet Notify Party"
{

    fields
    {
        field(1; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Line"."Loading Sheet No.";
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
        field(11; "Line No"; Integer)
        {
        }
        field(12; "Source Airport"; Code[50])
        {
            Editable = false;
        }
        field(13; "Destination Airport"; Code[50])
        {
            Editable = false;
        }
        field(14; FAM; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Loading Sheet No.", "Airline Code", "Flight Code", "Shipper Code", "Item No.", "Notify-Party No.", "Line No", FAM)
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
        BookingSheetNotifyParty: Record "Booking Sheet Notify Party";
        BookingSheetHeader: Record "Booking Sheet Header";
    begin
        BookingSheetNotifyParty.COPY(Rec);
        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Booking Sheet");
        ReportSelections.SETFILTER("Report ID", '<>0');
        ReportSelections.FIND('-');
        REPEAT
            IF NOT CONFIRM(Text001, FALSE, BookingSheetNotifyParty."Notify-Party Name") THEN
                EXIT;
            IF NOT SendAsEmail THEN BEGIN
                REPORT.RUNMODAL(ReportSelections."Report ID", ShowRequestForm, FALSE, BookingSheetNotifyParty)
            END ELSE BEGIN
                REPEAT
                    SendReport(ReportSelections."Report ID", BookingSheetNotifyParty);
                UNTIL BookingSheetNotifyParty.NEXT = 0;
            END;
        UNTIL ReportSelections.NEXT = 0;
    end;

    local procedure SendReport(ReportId: Integer; var BookingSheetNotifyParty: Record "Booking Sheet Notify Party")
    var
        DocumentMailing: Codeunit "Export Document-Mailing";
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text[250];
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        RecordRef: RecordRef;
        FileName: Text[250];
    begin
        FileName := 'BookingSheetReport_' + FORMAT(TODAY, 0, '<Year4><Month,2><Day,2>') + '.pdf';
        TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
        RecordRef.GetTable(BookingSheetNotifyParty);
        REPORT.SaveAs(ReportId, '', REPORTFORMAT::Pdf, OutStream, RecordRef);
        TempBlob.CreateInStream(InStream);
        COMMIT;
        DocumentMailing.EmailFileFromBookingSheetNotifyParty(BookingSheetNotifyParty, FileName)

        // ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'), 1, 250);
        // REPORT.SAVEASPDF(ReportId, ServerAttachmentFilePath, BookingSheetNotifyParty);
        // COMMIT;
        // DocumentMailing.EmailFileFromBookingSheetNotifyParty(BookingSheetNotifyParty, ServerAttachmentFilePath); // B2BUPG handled above using streams
    end;
}

