table 50056 "Booking Sheet HAWB Allocation"
{

    fields
    {
        field(1; "Booking Sheet No."; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Booking Sheet No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Airline Code";
        }
        field(3; "Consignee Code"; Code[20])
        {
            TableRelation = "Shipper Consignee"."Consignee No." WHERE("Shipper Code" = FIELD("Shipper Code"));

            trigger OnValidate()
            begin
                Consignee.GET("Consignee Code");
                "Consignee Name" := Consignee.Name;

                BookingSheetLine.RESET;
                BookingSheetLine.SETRANGE("Booking Sheet No.", "Booking Sheet No.");
                BookingSheetLine.SETRANGE("Airline Code", "Airline Code");
                BookingSheetLine.SETRANGE("Item No.", "Item No.");
                IF BookingSheetLine.FINDFIRST THEN BEGIN
                    "MAWB No." := BookingSheetLine."MAWB No.";
                    "Shipper Code" := BookingSheetLine."Shipper Code";
                END;

                //===INSERT IF NO NOTIFY PARTY IS FOUND ELSE RENAME (YOU CANNOT USE MODIFY BECAUSE THE THE MODIFIED FIELDS FORMS PART OF PK)=========
                BookingSheetNotifyParty.RESET;
                BookingSheetNotifyParty.SETRANGE("Booking Sheet No.", "Booking Sheet No.");
                BookingSheetNotifyParty.SETRANGE("Airline Code", "Airline Code");
                BookingSheetNotifyParty.SETRANGE("Flight Code", "Flight Code");
                BookingSheetNotifyParty.SETRANGE("Shipper Code", "Shipper Code");
                BookingSheetNotifyParty.SETRANGE("Item No.", "Item No.");
                BookingSheetNotifyParty.SETRANGE("Source Type", BookingSheetNotifyParty."Source Type"::Consignee);
                BookingSheetNotifyParty.SETRANGE("Source Code", xRec."Consignee Code");
                IF NOT BookingSheetNotifyParty.FINDFIRST THEN BEGIN
                    BookingSheetNotifyParty."Booking Sheet No." := "Booking Sheet No.";
                    BookingSheetNotifyParty."Airline Code" := "Airline Code";
                    BookingSheetNotifyParty."Flight Code" := "Flight Code";
                    BookingSheetNotifyParty."Shipper Code" := "Shipper Code";
                    BookingSheetNotifyParty."Item No." := "Item No."; //Booking Sheet No.,Airline Code,Flight Code,Shipper Code,Item No.,Notify-Party No.

                    NotifyParty.RESET;
                    NotifyParty.SETRANGE(Type, NotifyParty.Type::Consignee);
                    NotifyParty.SETRANGE("Type Code", "Consignee Code");
                    IF NotifyParty.FINDFIRST THEN BEGIN
                        BookingSheetNotifyParty."Notify-Party No." := NotifyParty."No.";
                        BookingSheetNotifyParty."Notify-Party Name" := NotifyParty.Name;
                        BookingSheetNotifyParty."Source Type" := NotifyParty.Type::Consignee;
                        BookingSheetNotifyParty."Source Code" := NotifyParty."Type Code";
                    END;
                    BookingSheetNotifyParty.INSERT;
                END ELSE BEGIN
                    NotifyParty.RESET;
                    NotifyParty.SETRANGE(Type, NotifyParty.Type::Consignee);
                    NotifyParty.SETRANGE("Type Code", "Consignee Code");
                    IF NotifyParty.FINDFIRST THEN BEGIN
                        BookingSheetNotifyParty."Notify-Party Name" := NotifyParty.Name; //Booking Sheet No.,Airline Code,Flight Code,Shipper Code,Item No.,Notify-Party No.
                        BookingSheetNotifyParty.RENAME("Booking Sheet No.", "Airline Code", "Flight Code", "Shipper Code", "Item No.", NotifyParty."No.");
                    END;

                END;
            end;
        }
        field(4; "HAWB No."; Code[20])
        {
            TableRelation = "HAWB Receipt"."HAWB No." WHERE(Assigned = FILTER(false));

            trigger OnValidate()
            begin
                IF HAWBReceipt.GET("HAWB No.") THEN BEGIN
                    IF HAWBReceipt.Assigned = TRUE THEN
                        ERROR(Text002, "HAWB No.")
                    ELSE
                        HAWBReceipt.Assigned := TRUE;
                    HAWBReceipt.MODIFY;
                END;
            end;
        }
        field(5; "Item No."; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Item No.";
        }
        field(6; "Consignee Name"; Text[50])
        {
            Editable = false;
        }
        field(8; "MAWB No."; Code[20])
        {
        }
        field(10; "Shipper Code"; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Shipper Code";
        }
        field(12; "HAWB Prepared"; Boolean)
        {
        }
        field(13; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No.";
        }
        field(14; "Gross Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(15; "Chargeable Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(16; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(17; "Source Airport"; Code[50])
        {
        }
        field(18; "Destination Airport"; Code[50])
        {
        }
        field(19; Invoiced; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Booking Sheet No.", "Airline Code", "Flight Code", "Shipper Code", "Item No.", "Consignee Code", "Source Airport", "Destination Airport", "MAWB No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Consignee: Record 50015;
        BookingSheetLine: Record 50054;
        Text001: Label '%1 is not within the Airline Charges Effective Date';
        HAWBReceipt: Record 50037;
        Text002: Label 'House Airway Bill No. %1 is already assigned';
        BookingSheetNotifyParty: Record 50057;
        NotifyParty: Record 50017;
        NotifyPartyNo: Code[10];
        NotifyPartyName: Text;


    procedure InsertHAWBFromBookingSheetHAWBItem(var HAWBLine: Record 50074)
    var
        HAWBHeader: Record 50075;
        HAWBAllocationHeader: Record 50075;
        HAWBAllocationLine: Record 50074;
        TempHAWBLine: Record 50074;
        TransferOldExtLines: Codeunit 379;
        ItemTrackingMgt: Codeunit 6500;
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        BookingSheetLine: Record 50054;
    begin
        SETRANGE("Booking Sheet No.", "Booking Sheet No.");
        SETRANGE("Airline Code", "Airline Code");
        SETRANGE("MAWB No.", "MAWB No.");
        SETRANGE("HAWB No.", "HAWB No.");
        SETRANGE("Item No.", "Item No.");
        TempHAWBLine := HAWBLine;
        IF HAWBLine.FIND('+') THEN
            NextLineNo := HAWBLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;
        REPEAT
            HAWBAllocationLine.INIT;
            HAWBAllocationLine."HAWB No." := HAWBAllocationLine."HAWB No.";
            HAWBAllocationLine."Line No." := HAWBAllocationLine."Line No.";
            HAWBLine := HAWBAllocationLine;
            HAWBLine."HAWB No." := TempHAWBLine."HAWB No.";
            HAWBLine."Line No." := NextLineNo;
            HAWBLine.Type := HAWBLine.Type::Item;
            HAWBLine."Item No." := "Item No.";
            HAWBLine."MAWB No." := "MAWB No.";
            HAWBLine."HAWB No." := "HAWB No.";
            HAWBLine."Airline Code" := "Airline Code";
            HAWBLine."Consignee Code" := "Consignee Code";

            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", "Booking Sheet No.");
            BookingSheetLine.SETRANGE(BookingSheetLine."Shipper Code", "Shipper Code");
            BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code", "Airline Code");
            BookingSheetLine.SETRANGE(BookingSheetLine."Item No.", "Item No.");
            IF BookingSheetLine.FINDFIRST THEN BEGIN
                HAWBLine."Division/Farm Code" := BookingSheetLine."Division/Farm Code";
                HAWBLine.Description := BookingSheetLine.Description;
                HAWBLine."Unit of Measure Code" := BookingSheetLine."Unit of Measure Code";
                HAWBLine."Flight Code" := BookingSheetLine."Flight Code";
                HAWBLine."Destination Code" := BookingSheetLine."Destination Code";
                HAWBLine."Flight Date" := BookingSheetLine."Booking Date";
                HAWBLine."Shipper Code" := BookingSheetLine."Shipper Code";
                HAWBLine."Actual Weight" := BookingSheetLine."Actual Weight";
            END;


            "HAWB Prepared" := TRUE;
            MODIFY;

            HAWBLine.INSERT;
            NextLineNo := NextLineNo + 10000;
        UNTIL (NEXT = 0);
    end;
}

