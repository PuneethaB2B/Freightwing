table 50052 "Good Receipt Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No. Series" THEN
                    "No." := '';
            end;
        }
        field(2; "Receipt Date"; Date)
        {
        }
        field(3; "Shipper Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Shipper.GET("Shipper Code");
                "Shipper Name" := Shipper.Name;
                Description := Text005 + ' ' + "Shipper Code";
            end;
        }
        field(4; "Shipper Name"; Text[50])
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
            //                                                   "C&F Agent" = FIELD("Receipt Date"),
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
            CalcFormula = Sum("Good Receipt Line"."Booked Weight" WHERE("Good Receipt No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Actual Weight"; Decimal)
        {
            CalcFormula = Sum("Good Receipt Line"."Actual Weight" WHERE("Good Receipt No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Prepared By"; Code[50])
        {
        }
        field(21; "No. Series"; Code[20])
        {
        }
        field(22; "Weight Difference"; Decimal)
        {
            CalcFormula = Sum("Good Receipt Line"."Weight Difference" WHERE("Good Receipt No." = FIELD("No.")));
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
        field(27; "Booking Sheet No."; Code[20])
        {
            TableRelation = "Booking Sheet Header" WHERE("Shipper Code" = FIELD("Shipper Code"));
        }
        field(28; "Vehicle No."; Code[100])
        {
        }
        field(29; "Driver Name"; Text[250])
        {
        }
        field(30; "Escort Vehicle No."; Code[20])
        {
        }
        field(31; "Offloading Start Time"; Time)
        {
        }
        field(32; "Offloading End Time"; Time)
        {
        }
        field(33; "Vehicle Arrival Time"; Time)
        {
        }
        field(34; "Seal No."; Code[20])
        {
        }
        field(35; "Screener Name"; Text[30])
        {
        }
        field(36; "Commodity Origin"; Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(37; "Offloading Place"; Option)
        {
            OptionMembers = " ","FWL Warehouse","Vegpro Warehouse";
        }
        field(38; "External Doc No."; Code[50])
        {
            Caption = 'Acceptance Checklist Serial No.';
        }
        field(39; Status; Option)
        {
            OptionCaption = 'Open,Submitted,Received,Loaded';
            OptionMembers = Open,Submitted,Received,Loaded;
        }
        field(40; "Posted By"; Code[50])
        {
        }
        field(41; "Delivery No."; Code[50])
        {
        }
        field(42; "Delivery Date"; Date)
        {
        }
        field(43; Loaded; Boolean)
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
        GoodReceiptLine.RESET;
        GoodReceiptLine.SETRANGE(GoodReceiptLine."Good Receipt No.", "No.");
        IF GoodReceiptLine.FIND('-') THEN
            ERROR('The Goods Receipt has Associated Lines. Please Delete Them First');
    end;

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Good Receipt Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Prepared By" := USERID;
        "Receipt Date" := TODAY;
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
        Text001: Label 'Goods Receipt %1 does not have any lines';
        Text002: Label 'Receive';
        PostingOption: Integer;
        Text003: Label 'Good Receipt %1 have not yet been received';
        ItemLedgerEntry: Record "Item Ledger Entry";
        Shipper: Record Customer;
        Text004: Label 'You cannot delete Goods Receipt %1 because it has entries associated with it';
        Text005: Label 'Good Receipt for';
        GoodReceiptLine: Record "Good Receipt Line";
        GoodReceiptHeader: Record "Good Receipt Header";
        NextLineNo: Decimal;
        BookingSheet: Record "Booking Sheet Header";


    procedure GoodReceiptLinesExist(): Boolean
    begin
        GoodReceiptLine.RESET;
        GoodReceiptLine.SETRANGE("Good Receipt No.", "No.");
        EXIT(GoodReceiptLine.FINDFIRST);
    end;


    procedure PostGoodReceipt()
    begin

        TESTFIELD("Receipt Date");
        TESTFIELD(Description);

        //................CHECK IF ORDER BOOKING HAVE ANY LINES........................
        PostingOption := DIALOG.STRMENU(Text002);
        IF NOT GoodReceiptLinesExist THEN
            ERROR(Text001, "No.");

        //...........CHECK IF QUANTITY IS ZERO......................
        GoodReceiptLine.RESET;
        GoodReceiptLine.SETRANGE(GoodReceiptLine."Good Receipt No.", "No.");
        IF GoodReceiptLine.FIND('-') THEN BEGIN
            GoodReceiptLine.TESTFIELD("Unit of Measure Code");
            GoodReceiptLine.TESTFIELD("Location Code");
            // GoodReceiptLine.TESTFIELD("Division/Farm Code");
            GoodReceiptLine.TESTFIELD(Quantity);
            GoodReceiptLine.TESTFIELD("Actual Weight");
            // GoodReceiptLine.TESTFIELD("MAWB No.");
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
            GoodReceiptLine.SETRANGE("Good Receipt No.", "No.");
            IF GoodReceiptLine.FIND('-') THEN BEGIN
                REPEAT
                    ItemJnline."Journal Template Name" := ImportExportSetup."Item Journal Template";
                    ItemJnline."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                    ItemJnline."Line No." := ItemJnline."Line No." + 1000;
                    ItemJnline."Entry Type" := ItemJnline."Entry Type"::"Positive Adjmt.";
                    ItemJnline."Source Code" := 'ITEMJNL';
                    ItemJnline."Document No." := GoodReceiptLine."Good Receipt No.";
                    ItemJnline."Item No." := GoodReceiptLine."Item No.";
                    ItemJnline.VALIDATE("Item No.");
                    ItemJnline."Posting Date" := "Receipt Date";
                    ItemJnline.Description := GoodReceiptLine.Description;
                    ItemJnline."Unit of Measure Code" := GoodReceiptLine."Unit of Measure Code";
                    ItemJnline.Quantity := GoodReceiptLine.Quantity;
                    ItemJnline.VALIDATE(Quantity);
                    ItemJnline."Shipper Code" := "Shipper Code";
                    ItemJnline.Weight := GoodReceiptLine."Actual Weight";
                    ItemJnline."Location Code" := GoodReceiptLine."Location Code";
                    ItemJnline.INSERT;
                    GoodReceiptLine.Status := GoodReceiptLine.Status::Received;
                    GoodReceiptLine.MODIFY;
                UNTIL GoodReceiptLine.NEXT = 0;
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
        END;
        "Posted By" := USERID;
        Status := Status::Received;
        MODIFY;
    end;


    procedure AssistEdit(OldGoodReceiptHeader: Record "Good Receipt Header"): Boolean
    begin
        GoodReceiptHeader := Rec;
        ImportExportSetup.GET;
        ImportExportSetup.TESTFIELD("Good Receipt Nos.");
        IF NoSeriesMgt.SelectSeries(ImportExportSetup."Good Receipt Nos.", OldGoodReceiptHeader."No. Series", GoodReceiptHeader."No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Good Receipt Nos.");
            NoSeriesMgt.SetSeries(GoodReceiptHeader."No.");
            Rec := GoodReceiptHeader;
            EXIT(TRUE);
        END;
    end;


    procedure CloseBookingSheet(BookingSheetNo: Code[50])
    var
        BSHeader: Record "Booking Sheet Header";
        BSLine: Record "Booking Sheet Line";
    begin
        IF BSHeader.GET(BookingSheetNo) THEN BEGIN
            BSLine.RESET;
            BSLine.SETRANGE(BSLine."Booking Sheet No.", BSHeader."No.");
            BSLine.SETRANGE(BSLine."Good Receipt No.", '');
            IF BSLine.FINDFIRST THEN BEGIN
                //MESSAGE('Booking Sheet Still Open. Not All Booked Lines were Received');
            END ELSE BEGIN
                BSHeader.Status := BSHeader.Status::Received;
                BSHeader.MODIFY;
            END;
        END;
    end;


    procedure PostGoodReceiptReversal()
    begin

        TESTFIELD("Receipt Date");
        TESTFIELD(Description);

        //................CHECK IF ORDER BOOKING HAVE ANY LINES........................
        PostingOption := DIALOG.STRMENU(Text002);
        IF NOT GoodReceiptLinesExist THEN
            ERROR(Text001, "No.");

        //...........CHECK IF QUANTITY IS ZERO......................
        GoodReceiptLine.RESET;
        GoodReceiptLine.SETRANGE(GoodReceiptLine."Good Receipt No.", "No.");
        IF GoodReceiptLine.FIND('-') THEN BEGIN
            GoodReceiptLine.TESTFIELD("Unit of Measure Code");
            GoodReceiptLine.TESTFIELD("Location Code");
            // GoodReceiptLine.TESTFIELD("Division/Farm Code");
            GoodReceiptLine.TESTFIELD(Quantity);
            GoodReceiptLine.TESTFIELD("Actual Weight");
            // GoodReceiptLine.TESTFIELD("MAWB No.");
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
            GoodReceiptLine.SETRANGE("Good Receipt No.", "No.");
            IF GoodReceiptLine.FIND('-') THEN BEGIN
                REPEAT
                    ItemJnline."Journal Template Name" := ImportExportSetup."Item Journal Template";
                    ItemJnline."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                    ItemJnline."Line No." := ItemJnline."Line No." + 1000;
                    ItemJnline."Entry Type" := ItemJnline."Entry Type"::"Negative Adjmt.";
                    ItemJnline."Source Code" := 'ITEMJNL';
                    ItemJnline."Document No." := GoodReceiptLine."Good Receipt No.";
                    ItemJnline."Item No." := GoodReceiptLine."Item No.";
                    ItemJnline.VALIDATE("Item No.");
                    ItemJnline."Posting Date" := "Receipt Date";
                    ItemJnline.Description := 'Reversal - ' + GoodReceiptLine.Description;
                    ItemJnline."Unit of Measure Code" := GoodReceiptLine."Unit of Measure Code";
                    ItemJnline.Quantity := GoodReceiptLine.Quantity;
                    ItemJnline.VALIDATE(Quantity);
                    ItemJnline."Shipper Code" := "Shipper Code";
                    ItemJnline.Weight := GoodReceiptLine."Actual Weight";
                    ItemJnline."Location Code" := GoodReceiptLine."Location Code";
                    ItemJnline.INSERT;
                    GoodReceiptLine."Loading Sheet No." := '';
                    GoodReceiptLine.Status := GoodReceiptLine.Status::Received;
                    GoodReceiptLine.MODIFY;
                UNTIL GoodReceiptLine.NEXT = 0;
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
        END;
        "Posted By" := USERID;
        Status := Status::Open;
        MODIFY;
    end;
}

