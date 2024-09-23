table 50057 "Booking Sheet Notify Party"
{

    fields
    {
        field(1; "Booking Sheet No."; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Booking Sheet No.";
        }
        field(2; "Airline Code"; Code[10])
        {
            TableRelation = Airline;
        }
        field(3; "Notify-Party No."; Code[20])
        {
            TableRelation = "Shipper Notify Party"."Notify-Party No." WHERE (Shipper Code=FIELD(Shipper Code));

            trigger OnValidate()
            begin
                ShipperNotifyParty.RESET;
                ShipperNotifyParty.SETRANGE(ShipperNotifyParty."Shipper Code","Shipper Code");
                ShipperNotifyParty.SETRANGE(ShipperNotifyParty."Notify-Party No.","Notify-Party No.");
                IF ShipperNotifyParty.FINDFIRST THEN BEGIN
                  "Notify-Party Name":=ShipperNotifyParty."Notify-Party Name";
                END;
            end;
        }
        field(4;"Notify-Party Name";Text[50])
        {
        }
        field(5;"Item No.";Code[20])
        {
            TableRelation = "Shipper Item"."Item No.";
        }
        field(7;"Shipper Code";Code[20])
        {
            TableRelation = Customer;
        }
        field(8;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight No.";
        }
        field(9;"Source Code";Code[20])
        {
        }
        field(10;"Source Type";Option)
        {
            OptionMembers = " ",Shipper,Consignee,Operations;
        }
        field(11;"Line No";Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(12;"Source Airport";Code[50])
        {
        }
        field(13;"Destination Airport";Code[50])
        {
        }
        field(14;FAM;Code[50])
        {
        }
    }

    keys
    {
        key(Key1;"Booking Sheet No.","Airline Code","Flight Code","Shipper Code","Item No.","Notify-Party No.","Line No","Source Airport","Destination Airport",FAM)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ShipperNotifyParty: Record "50067";
        Text001: Label 'Do you want to notify: %1';

    [Scope('Internal')]
    procedure EmailRecords(ShowRequestForm: Boolean;var BookingSheetNotifyParty: Record "50057")
    begin
        SendRecords(ShowRequestForm,TRUE,BookingSheetNotifyParty);
    end;

    local procedure SendRecords(ShowRequestForm: Boolean;SendAsEmail: Boolean;var BookingSheetNotifyParty: Record "50057")
    var
        ReportSelections: Record "77";
        BookingSheetHeader: Record "50053";
        BookingSheetULDAllocation: Record "50055";
    begin
        /*WITH BookingSheetNotifyParty DO BEGIN
          COPY(Rec);
          ReportSelections.SETRANGE(Usage,ReportSelections.Usage::"Booking Sheet");
          ReportSelections.SETFILTER("Report ID",'<>0');
          ReportSelections.FIND('-');
          REPEAT
           IF NOT CONFIRM(Text001,FALSE,"Notify-Party Name") THEN
             EXIT;
            IF NOT SendAsEmail THEN BEGIN
              REPORT.RUNMODAL(ReportSelections."Report ID",ShowRequestForm,FALSE,BookingSheetNotifyParty)
            END ELSE  BEGIN
            REPEAT
              SendReport(ReportSelections."Report ID",BookingSheetNotifyParty);
            UNTIL BookingSheetNotifyParty.NEXT=0;
            END;
          UNTIL ReportSelections.NEXT = 0;
        END;*/
        
        IF BookingSheetNotifyParty."Source Type"<>BookingSheetNotifyParty."Source Type"::Operations THEN BEGIN
          ReportSelections.SETRANGE(Usage,ReportSelections.Usage::"Booking Sheet");
          ReportSelections.SETFILTER("Report ID",'<>0');
          ReportSelections.FIND('-');
          REPEAT
           IF NOT SendAsEmail THEN BEGIN
             REPORT.RUNMODAL(ReportSelections."Report ID",ShowRequestForm,FALSE,BookingSheetNotifyParty)
           END ELSE  BEGIN
             SendReport(ReportSelections."Report ID",BookingSheetNotifyParty);
           END;
          UNTIL ReportSelections.NEXT = 0;
         END ELSE BEGIN
          BookingSheetNotifyParty.RESET;
          BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Booking Sheet No.","Booking Sheet No.");
          IF BookingSheetNotifyParty.FINDSET THEN BEGIN
            ReportSelections.SETRANGE(Usage,ReportSelections.Usage::"Booking Sheet ULD Allocation");
            ReportSelections.SETFILTER("Report ID",'<>0');
            ReportSelections.FIND('-');
            REPEAT
             BookingSheetULDAllocation.RESET;
             BookingSheetULDAllocation.SETRANGE(BookingSheetULDAllocation."Booking Sheet No.",BookingSheetNotifyParty."Booking Sheet No.");
             IF BookingSheetULDAllocation.FIND('+') THEN BEGIN
                //IF NOT SendAsEmail THEN BEGIN
                  REPORT.RUNMODAL(ReportSelections."Report ID",ShowRequestForm,FALSE,BookingSheetULDAllocation)
               // END ELSE  BEGIN
                 // SendReport(ReportSelections."Report ID",BookingSheetNotifyParty);
               // END;
              END;
            UNTIL ReportSelections.NEXT = 0;
          END;
         END;

    end;

    local procedure SendReport(ReportId: Integer;var BookingSheetNotifyParty: Record "50057")
    var
        DocumentMailing: Codeunit "50013";
        FileManagement: Codeunit "419";
        ServerAttachmentFilePath: Text[250];
    begin
        ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'),1,250);
        REPORT.SAVEASPDF(ReportId,ServerAttachmentFilePath,BookingSheetNotifyParty);
        COMMIT;
        DocumentMailing.EmailFileFromBookingSheetNotifyParty(BookingSheetNotifyParty,ServerAttachmentFilePath);
    end;
}

