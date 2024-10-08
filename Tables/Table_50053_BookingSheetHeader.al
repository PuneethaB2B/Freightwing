table 50053 "Booking Sheet Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No. Series" THEN BEGIN
                    "No." := '';
                END;
            end;
        }
        field(2; "Booking Date"; Date)
        {

            trigger OnValidate()
            begin
                "Booking Day" := FORMAT("Booking Date", 0, '<Weekday Text>');
            end;
        }
        field(3; "Shipper Code"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Shipper.GET("Shipper Code");
                "Shipper Name" := Shipper.Name;
                Description := Text005 + ' ' + "Shipper Code";
            end;
        }
        field(4; "Shipper Name"; Text[30])
        {
            Editable = false;
        }
        field(5; "Consignee Code"; Code[20])
        {
            TableRelation = Consignee."No.";
        }
        field(6; "Clearing Agent Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(7; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;
        }
        field(8; "Flight Code"; Code[20])
        {
            // TableRelation = "Pre Alert Line"."HAWB No" WHERE("Pre Alert No" = FIELD("Airline Code"),
            //                                                   "C&F Agent" = FIELD("Booking Date"),
            //                                                   "Consignee Code" = FIELD("Destination Code"));  //B2BUPG
        }
        field(9; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE("Airline Code" = FIELD("Airline Code"));

            trigger OnValidate()
            begin
                MAWBReceipt.RESET;
                MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "MAWB No.");
                IF MAWBReceipt.FINDFIRST THEN
                    "MAWB Date" := MAWBReceipt."Receipt Date";
            end;
        }
        field(10; "Shipper Address"; Text[30])
        {
            CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Shipper Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; Description; Text[30])
        {
        }
        field(12; "Port of Loading"; Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(13; "Cut-off Time"; Time)
        {
            Editable = false;
        }
        field(14; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(15; "Port of Discharge"; Code[20])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Destination Code"));
        }
        field(16; "Place of Delivery"; Text[30])
        {
        }
        field(17; "Via Route/Transist"; Code[20])
        {
            TableRelation = "Via Destination"."Via Destination Code" WHERE("Airline Code" = FIELD("Airline Code"),
                                                                            "Flight Code" = FIELD("Via Route/Transist"),
                                                                           "FS Destination Code" = FIELD("Destination Code"));
        }
        field(18; "Booked Weight"; Decimal)
        {
            CalcFormula = Sum("Booking Sheet Line"."Booked Weight" WHERE("Booking Sheet No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Actual Weight"; Decimal)
        {
            CalcFormula = Sum("Booking Sheet Line"."Actual Weight" WHERE("Booking Sheet No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Prepared By"; Code[50])
        {
            Editable = false;
        }
        field(21; "No. Series"; Code[20])
        {
        }
        field(22; "Weight Difference"; Decimal)
        {
            CalcFormula = Sum("Booking Sheet Line"."Weight Difference" WHERE("Booking Sheet No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "MAWB Date"; Date)
        {
            Editable = false;
        }
        field(24; Received; Boolean)
        {
        }
        field(25; Invoiced; Boolean)
        {
        }
        field(26; "Type of Delivery"; Code[20])
        {
            TableRelation = "Delivery Type";
        }
        field(27; "Booking Day"; Text[30])
        {
        }
        field(28; Comments; Text[250])
        {
        }
        field(29; Status; Option)
        {
            OptionCaption = 'Open,Received,Submitted';
            OptionMembers = Open,Received,Submitted;
        }
        field(30; "Submitted on"; Date)
        {
        }
        field(31; "Submitted at"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        BookingSheetLine.RESET;
        BookingSheetLine.SETRANGE("Booking Sheet No.", "No.");
        IF BookingSheetLine.FINDFIRST THEN
            BookingSheetLine.DELETEALL;
    end;

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Booking Sheet Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Prepared By" := USERID;
        "Booking Date" := TODAY;
        VALIDATE("Booking Date");
    end;

    var
        ImportExportSetup: Record "Import/Export Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DailyWeightDistByItem: Record "Dl. Weight Dist. By Item";
        DailyWeightDistHeader: Record "Dl. Weight Dist. Header";
        BookingSheetLine: Record "Booking Sheet Line";
        DailyWeightDistByAirline: Record "Dl. Weight Dist. By Airline";
        MAWBReceipt: Record "MAWB Receipt";
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        ItemJnline: Record "Item Journal Line";
        Text001: Label 'Booking Sheet %1 does not have any lines';
        Text002: Label 'Receive';
        PostingOption: Integer;
        Text003: Label 'Booking Sheet %1 have not yet been received';
        ItemLedgerEntry: Record "Item Ledger Entry";
        Shipper: Record Customer;
        Text004: Label 'You cannot delete Booking Sheet %1 because it has entries associated with it';
        Text005: Label 'Booking Sheet for';
        BookingSheetHeader: Record "Booking Sheet Header";


    procedure BookingSheetLinesExist(): Boolean
    begin
        BookingSheetLine.RESET;
        BookingSheetLine.SETRANGE("Booking Sheet No.", "No.");
        EXIT(BookingSheetLine.FINDFIRST);
    end;


    procedure PostBookingSheet()
    begin
        TESTFIELD("Booking Date");
        TESTFIELD("Shipper Code");
        //TESTFIELD("Consignee Code");
        //TESTFIELD("Clearing Agent Code");
        //TESTFIELD("Airline Code");
        //TESTFIELD("Flight Code");
        //TESTFIELD("MAWB No.");
        //TESTFIELD("Destination Code");
        TESTFIELD(Description);

        //................CHECK IF ORDER BOOKING HAVE ANY LINES........................
        PostingOption := DIALOG.STRMENU(Text002);
        IF NOT BookingSheetLinesExist THEN
            ERROR(Text001, "No.");

        //...........CHECK IF QUANTITY IS ZERO......................
        BookingSheetLine.RESET;
        BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", "No.");
        IF BookingSheetLine.FIND('-') THEN BEGIN
            BookingSheetLine.TESTFIELD("Unit of Measure Code");
            BookingSheetLine.TESTFIELD("Location Code");
            BookingSheetLine.TESTFIELD("Division/Farm Code");
            BookingSheetLine.TESTFIELD(Quantity);
            BookingSheetLine.TESTFIELD("Actual Weight");
            BookingSheetLine.TESTFIELD("MAWB No.");
        END;
        IF PostingOption = 1 THEN BEGIN
            //....... DELETE ANY LINE ITEM THAT MAY BE PRESENT
            ImportExportSetup.GET();
            JournalTemplate := ImportExportSetup."Item Journal Template";
            JournalBatch := ImportExportSetup."Item Journal Batch";

            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            ItemJnline.DELETEALL;

            //..INSERT ITEM TRANSACTION.................................................
            BookingSheetLine.SETRANGE("Booking Sheet No.", "No.");
            IF BookingSheetLine.FIND('-') THEN BEGIN
                REPEAT
                    ItemJnline."Journal Template Name" := ImportExportSetup."Item Journal Template";
                    ItemJnline."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                    ItemJnline."Line No." := ItemJnline."Line No." + 1000;
                    ItemJnline."Entry Type" := ItemJnline."Entry Type"::"Positive Adjmt.";
                    ItemJnline."Source Code" := 'ITEMJNL';
                    ItemJnline."Document No." := BookingSheetLine."Booking Sheet No.";
                    ItemJnline."Item No." := BookingSheetLine."Item No.";
                    ItemJnline.VALIDATE("Item No.");
                    ItemJnline."Posting Date" := "Booking Date";
                    ItemJnline.Description := BookingSheetLine.Description;
                    ItemJnline."Unit of Measure Code" := BookingSheetLine."Unit of Measure Code";
                    ItemJnline.Quantity := BookingSheetLine.Quantity;
                    ItemJnline.VALIDATE(Quantity);
                    ItemJnline.VALIDATE("Unit Amount");
                    ItemJnline.INSERT;
                UNTIL BookingSheetLine.NEXT = 0;
            END;
            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            IF ItemJnline.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnline);

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", "No.");
                IF ItemLedgerEntry.FINDFIRST THEN
                    Received := TRUE;
            END;
        END
    end;


    procedure AssistEdit(OldBookingSheetHeader: Record "Booking Sheet Header"): Boolean
    begin
        BookingSheetHeader := Rec;
        ImportExportSetup.GET;
        ImportExportSetup.TESTFIELD("Booking Sheet Nos.");
        IF NoSeriesMgt.SelectSeries(ImportExportSetup."Booking Sheet Nos.", OldBookingSheetHeader."No. Series", BookingSheetHeader."No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Booking Sheet Nos.");
            NoSeriesMgt.SetSeries(BookingSheetHeader."No.");
            Rec := BookingSheetHeader;
            EXIT(TRUE);
        END;
    end;
}

