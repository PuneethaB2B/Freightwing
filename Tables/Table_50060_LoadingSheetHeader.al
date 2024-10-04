table 50060 "Loading Sheet Header"
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
        field(2; "Loading Date"; Date)
        {
        }
        field(3; "Shipper Code"; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Shipper.GET("Shipper Code");
                "Shipper Name" := Shipper.Name;
                Description := Text004 + "Shipper Name";
            end;
        }
        field(4; "Shipper Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "MAWB No."; Code[20])
        {
            TableRelation = "Good Receipt Line"."MAWB No." WHERE("Shipper Code" = FIELD("Shipper Code"),
                                                                  Status = FILTER("Shipped Part" | Received),
                                                                  "Loading Sheet No." = FILTER(''));

            trigger OnValidate()
            begin
                GRNLine.RESET;
                GRNLine.SETRANGE(GRNLine."MAWB No.", "MAWB No.");
                IF GRNLine.FINDFIRST THEN BEGIN
                    //"Booking Sheet No.":=GRNLine."Booking Sheet No.";
                    //"Booking Sheet Date":=BookingSheetLine."Booking Date";
                    "Airline Code" := GRNLine."Airline Code";
                    "Flight Code" := GRNLine."Flight Code";
                    "Destination Code" := GRNLine."Destination Code";
                    //"Consignee Code":=GRNLine."Consignee Code";
                END;
                "Loading Sheet MAWB No" := "MAWB No.";
            end;
        }
        field(6; "Booking Sheet No."; Code[20])
        {
            Editable = false;
            TableRelation = "Booking Sheet Header"."No.";
        }
        field(7; "Booking Sheet Date"; Date)
        {
            Editable = false;
        }
        field(8; "Flight Code"; Code[20])
        {
            Editable = false;
            TableRelation = Flight."Flight Code" WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(9; "Destination Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(10; "Offloading Start Time"; Time)
        {
        }
        field(11; "Offloading End Time"; Time)
        {
        }
        field(12; "Vehicle No."; Code[20])
        {
        }
        field(13; "Vehicle Arrival Time"; Time)
        {
        }
        field(14; "Seal No."; Code[20])
        {
        }
        field(15; "Screener Name"; Text[30])
        {
        }
        field(16; "Commodity Origin"; Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(17; "Consignee Code"; Code[10])
        {
            Editable = false;
            TableRelation = Consignee."No.";
        }
        field(18; "Offloading Place"; Option)
        {
            OptionCaption = ',FWL,Vegpro,Signon,TFF';
            OptionMembers = ,FWL,Vegpro,Signon,TFF;
        }
        field(19; "Airline Code"; Code[20])
        {
            Editable = false;
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                IF "Airline Code" <> xRec."Airline Code" THEN BEGIN
                    "Flight Code" := '';
                    "Destination Code" := '';
                END;
            end;
        }
        field(20; "Prepared By"; Code[50])
        {
            Editable = false;
        }
        field(21; "No. Series"; Code[20])
        {
        }
        field(22; Description; Text[50])
        {
        }
        field(23; Shipped; Boolean)
        {
        }
        field(24; Status; Option)
        {
            OptionCaption = 'Open,Submitted,Closed';
            OptionMembers = Open,Submitted,Closed;
        }
        field(25; "Loading Sheet MAWB No"; Code[50])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE(Assigned = FILTER(true),
                                                             "Airline Code" = FIELD("Airline Code"),
                                                             Prepared = FILTER(false));

            trigger OnValidate()
            begin
                IF "Loading Sheet MAWB No" <> xRec."Loading Sheet MAWB No" THEN BEGIN
                    IF CONFIRM('Do you want to update the MAWB Numbers') THEN BEGIN
                        LoadingSheetLines.RESET;
                        LoadingSheetLines.SETRANGE(LoadingSheetLines."Shipper Code", "Shipper Code");
                        LoadingSheetLines.SETRANGE(LoadingSheetLines."MAWB No.", "MAWB No.");
                        IF LoadingSheetLines.FIND('-') THEN BEGIN
                            MESSAGE('Found');
                            LoadingSheetLines."MAWB No." := "Loading Sheet MAWB No";
                            LoadingSheetLines.MODIFY();
                        END;
                    END
                    ELSE BEGIN
                        "Loading Sheet MAWB No" := "MAWB No.";
                        MODIFY;
                    END;
                END;
            end;
        }
        field(26; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(27; "Posted Time"; Time)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Shipper Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Shipper Code", "Shipper Name")
        {
        }
    }

    trigger OnDelete()
    begin
        LoadingSheetLines.RESET;
        LoadingSheetLines.SETRANGE(LoadingSheetLines."Loading Sheet No.", "No.");
        IF LoadingSheetLines.FINDSET THEN
            LoadingSheetLines.DELETEALL();
    end;

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Loading Sheet Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Prepared By" := USERID;
        "Loading Date" := TODAY;
        Status := Status::Open;
    end;

    var
        Shipper: Record Customer;
        BookingSheetHeader: Record "Booking Sheet Header";
        ImportExportSetup: Record "Import/Export Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoadingSheetLine: Record "Loading Sheet Line";
        BookingSheetLine: Record "Booking Sheet Line";
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        ItemJnline: Record "Item Journal Line";
        PostingOption: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        Text001: Label 'Loading Sheet %1 does not have any lines';
        Text002: Label 'Ship';
        Text003: Label 'Loading Sheet %1 have not yet been received';
        LoadingSheetHeader: Record "Loading Sheet Header";
        Text004: Label 'Loading Sheet for-';
        Text005: Label 'Are you sure that you want to post the loading sheet';
        GRNLine: Record "Good Receipt Line";
        LoadingSheetLines: Record "Loading Sheet Line";
        MAWBReceipt: Record "MAWB Receipt";
        Header: Record "Loading Sheet Header";
        TempLoadingSheetLine: Record "Loading Sheet Line";


    procedure LoadingSheetLinesExist(): Boolean
    begin
        LoadingSheetLine.RESET;
        LoadingSheetLine.SETRANGE("Loading Sheet No.", "No.");
        EXIT(LoadingSheetLine.FINDFIRST);
    end;


    procedure PostLoadingSheet()
    begin
        TESTFIELD("Loading Date");
        TESTFIELD("Shipper Code");
        TESTFIELD(Description);
        TESTFIELD(Status, Status::Submitted);
        //................CHECK IF ORDER BOOKING HAVE ANY LINES........................
        IF CONFIRM(Text005) THEN BEGIN
            IF NOT LoadingSheetLinesExist THEN
                ERROR(Text001, "No.");

            //...........CHECK IF QUANTITY IS ZERO......................
            LoadingSheetLine.RESET;
            LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", "No.");
            IF LoadingSheetLine.FIND('-') THEN BEGIN
                REPEAT
                    LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                    LoadingSheetLine.TESTFIELD("Unit of Measure Code");
                    LoadingSheetLine.TESTFIELD("Location Code");
                    LoadingSheetLine.TESTFIELD(Quantity);
                    //LoadingSheetLine.TESTFIELD("Airline Docket Weight");
                    LoadingSheetLine.TESTFIELD("MAWB No.");
                UNTIL LoadingSheetLine.NEXT = 0;
            END;
            ImportExportSetup.GET();
            JournalTemplate := ImportExportSetup."Item Journal Template";
            JournalBatch := ImportExportSetup."Item Journal Batch";
            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            ItemJnline.DELETEALL;

            LoadingSheetLine.SETRANGE("Loading Sheet No.", "No.");
            IF LoadingSheetLine.FIND('-') THEN BEGIN
                REPEAT
                    LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                    ItemJnline."Journal Template Name" := ImportExportSetup."Item Journal Template";
                    ItemJnline."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                    ItemJnline."Line No." := ItemJnline."Line No." + 1000;
                    ItemJnline."Entry Type" := ItemJnline."Entry Type"::"Negative Adjmt.";
                    ItemJnline."Source Code" := 'ITEMJNL';
                    ItemJnline."Document No." := LoadingSheetLine."Loading Sheet No.";
                    ItemJnline."Item No." := LoadingSheetLine."Item No.";
                    ItemJnline.VALIDATE("Item No.");
                    ItemJnline."Posting Date" := "Loading Date";
                    ItemJnline.Description := LoadingSheetLine.Description;
                    ItemJnline."Unit of Measure Code" := LoadingSheetLine."Unit of Measure Code";
                    ItemJnline.Quantity := LoadingSheetLine.Quantity;
                    ItemJnline.VALIDATE(Quantity);
                    ItemJnline.VALIDATE("Unit Amount");
                    ItemJnline."Shipper Code" := "Shipper Code";
                    ItemJnline.Weight := LoadingSheetLine."FWL Gross Weight";
                    ItemJnline."Location Code" := LoadingSheetLine."Location Code";
                    ItemJnline.INSERT;

                    GetGoodReceiptStatus(LoadingSheetLine."GRN No.", "MAWB No.", LoadingSheetLine."Division/Farm Code", LoadingSheetLine."Item No.");
                UNTIL LoadingSheetLine.NEXT = 0;
            END;
            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            IF ItemJnline.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnline);

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", "No.");
                IF ItemLedgerEntry.FINDFIRST THEN
                    Shipped := TRUE;
                Status := Status::Closed;
                MODIFY;
            END
        END ELSE
            EXIT;
        MAWBReceipt.RESET;
        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "Loading Sheet MAWB No");
        IF MAWBReceipt.FINDFIRST THEN BEGIN
            MAWBReceipt.Assigned := TRUE;
            MAWBReceipt."Assigned Date" := "Loading Date";
            MAWBReceipt.MODIFY;
        END;
        "Posted By" := USERID;
        MODIFY;
    end;


    procedure AssistEdit(OldLoadingSheetHeader: Record "Loading Sheet Header"): Boolean
    begin
        LoadingSheetHeader := Rec;
        ImportExportSetup.GET;
        ImportExportSetup.TESTFIELD("Loading Sheet Nos.");
        IF NoSeriesMgt.SelectSeries(ImportExportSetup."Loading Sheet Nos.", OldLoadingSheetHeader."No. Series", LoadingSheetHeader."No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Loading Sheet Nos.");
            NoSeriesMgt.SetSeries(LoadingSheetHeader."No.");
            Rec := LoadingSheetHeader;
            EXIT(TRUE);
        END;
    end;

    local procedure GetGoodReceiptStatus(GRNNo: Code[50]; GRNMawb: Code[50]; Division: Code[10]; Item: Code[50]) State: Boolean
    var
        GRNLine1: Record "Good Receipt Line";
        LoadingSheetLine1: Record "Loading Sheet Line";
        ReceivedBoxes: Decimal;
        ShippedBoxes: Decimal;
    begin
        GRNLine1.RESET;
        GRNLine1.SETRANGE(GRNLine1."Good Receipt No.", GRNNo);
        GRNLine1.SETRANGE(GRNLine1."MAWB No.", GRNMawb);
        GRNLine1.SETRANGE(GRNLine1."Division/Farm Code", Division);
        GRNLine1.SETRANGE(GRNLine1."Item No.", Item);
        IF GRNLine1.FINDFIRST THEN BEGIN
            ReceivedBoxes := GRNLine1.Quantity;
        END;

        LoadingSheetLine1.RESET;
        LoadingSheetLine1.SETRANGE(LoadingSheetLine1."GRN No.", GRNNo);
        IF LoadingSheetLine1.FINDSET THEN BEGIN
            ShippedBoxes := 0;
            REPEAT
                LoadingSheetLine1.CALCFIELDS(LoadingSheetLine1.Quantity);
                ShippedBoxes += LoadingSheetLine1.Quantity;
            UNTIL LoadingSheetLine1.NEXT = 0;
        END;

        IF ShippedBoxes = ReceivedBoxes THEN BEGIN
            State := TRUE;
            GRNLine1.Status := GRNLine1.Status::"Shipped Full";
            GRNLine1.Closed := TRUE;
            GRNLine1.MODIFY;
        END
        ELSE BEGIN
            State := FALSE;
        END;

        EXIT(State);
    end;

    local procedure UpdateLoadingSheetLines(No: Code[50]; MAWb: Code[50])
    var
        Lines: Record "Loading Sheet Line";
    begin
    end;


    procedure PostLoadingSheetReversal()
    begin
        TESTFIELD("Loading Date");
        TESTFIELD("Shipper Code");
        TESTFIELD(Description);
        //TESTFIELD(Status,Status::Submitted);
        //................CHECK IF ORDER BOOKING HAVE ANY LINES........................
        IF CONFIRM(Text005) THEN BEGIN
            IF NOT LoadingSheetLinesExist THEN
                ERROR(Text001, "No.");

            //...........CHECK IF QUANTITY IS ZERO......................
            LoadingSheetLine.RESET;
            LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", "No.");
            IF LoadingSheetLine.FIND('-') THEN BEGIN
                REPEAT
                    LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                    LoadingSheetLine.TESTFIELD("Unit of Measure Code");
                    LoadingSheetLine.TESTFIELD("Location Code");
                    LoadingSheetLine.TESTFIELD(Quantity);
                    //LoadingSheetLine.TESTFIELD("Airline Docket Weight");
                    LoadingSheetLine.TESTFIELD("MAWB No.");
                UNTIL LoadingSheetLine.NEXT = 0;
            END;
            ImportExportSetup.GET();
            JournalTemplate := ImportExportSetup."Item Journal Template";
            JournalBatch := ImportExportSetup."Item Journal Batch";
            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            ItemJnline.DELETEALL;

            LoadingSheetLine.SETRANGE("Loading Sheet No.", "No.");
            IF LoadingSheetLine.FIND('-') THEN BEGIN
                REPEAT
                    LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                    ItemJnline."Journal Template Name" := ImportExportSetup."Item Journal Template";
                    ItemJnline."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                    ItemJnline."Line No." := ItemJnline."Line No." + 1000;
                    ItemJnline."Entry Type" := ItemJnline."Entry Type"::"Positive Adjmt.";
                    ItemJnline."Source Code" := 'ITEMJNL';
                    ItemJnline."Document No." := LoadingSheetLine."Loading Sheet No.";
                    ItemJnline."Item No." := LoadingSheetLine."Item No.";
                    ItemJnline.VALIDATE("Item No.");
                    ItemJnline."Posting Date" := "Loading Date";
                    ItemJnline.Description := 'Reversal - ' + LoadingSheetLine.Description;
                    ItemJnline."Unit of Measure Code" := LoadingSheetLine."Unit of Measure Code";
                    ItemJnline.Quantity := LoadingSheetLine.Quantity;
                    ItemJnline.VALIDATE(Quantity);
                    ItemJnline.VALIDATE("Unit Amount");
                    ItemJnline."Shipper Code" := "Shipper Code";
                    ItemJnline.Weight := LoadingSheetLine."FWL Gross Weight";
                    ItemJnline."Location Code" := LoadingSheetLine."Location Code";
                    ItemJnline.INSERT;

                    GetGoodReceiptStatus(LoadingSheetLine."GRN No.", "MAWB No.", LoadingSheetLine."Division/Farm Code", LoadingSheetLine."Item No.");
                UNTIL LoadingSheetLine.NEXT = 0;
            END;
            ItemJnline.RESET;
            ItemJnline.SETRANGE(ItemJnline."Journal Template Name", JournalTemplate);
            ItemJnline.SETRANGE(ItemJnline."Journal Batch Name", JournalBatch);
            IF ItemJnline.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnline);

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", "No.");
                IF ItemLedgerEntry.FINDFIRST THEN
                    Shipped := FALSE;
                Status := Status::Open;
                MODIFY;
            END
        END ELSE
            EXIT;
        MAWBReceipt.RESET;
        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "Loading Sheet MAWB No");
        IF MAWBReceipt.FINDFIRST THEN BEGIN
            MAWBReceipt.Assigned := TRUE;
            MAWBReceipt.MODIFY;
        END;
        "Posted By" := USERID;
        MODIFY;
    end;
}

