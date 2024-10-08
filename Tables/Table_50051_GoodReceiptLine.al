table 50051 "Good Receipt Line"
{

    fields
    {
        field(1; "Good Receipt No."; Code[20])
        {
            TableRelation = "Good Receipt Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            InitValue = Item;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            Editable = false;
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(7; "Booked Weight"; Decimal)
        {
            Caption = 'Booked Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(8; "Actual Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                "Weight Difference" := "Booked Weight" - "Actual Weight";
                "FWL Gross Weight" := "Actual Weight";
            end;
        }
        field(11; "ULD Type Code"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(12; "ULD No."; Code[20])
        {
            TableRelation = ULD."ULD No." WHERE("ULD Type Code" = FIELD("ULD Type Code"));
        }
        field(13; Quantity; Decimal)
        {
        }
        field(14; "Weight Difference"; Decimal)
        {
            Editable = false;
        }
        field(15; "Booked Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(16; "Actual Line Amount"; Decimal)
        {
            Editable = false;
        }
        field(17; "Rate Amount"; Decimal)
        {
            Editable = false;
        }
        field(18; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(19; "Product Group Code"; Code[20])
        {
            TableRelation = "Item Category".Code;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Shipped Full,Shipped Part,Received';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment","Shipped Full","Shipped Part",Received;
        }
        field(21; "Approved By"; Code[20])
        {
            Editable = false;
        }
        field(22; "Approval Date"; Date)
        {
            Editable = false;
        }
        field(23; "Consignee Code"; Code[20])
        {
            TableRelation = Consignee."No.";

            trigger OnValidate()
            begin
                Consignees.RESET;
                IF Consignees.GET("Consignee Code") THEN BEGIN
                    "Consignee Name" := Consignees.Name;
                END;
            end;
        }
        field(24; "Clearing Agent Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(25; "Airline Code"; Code[20])
        {
            Editable = false;
            TableRelation = Airline.Code;
        }
        field(26; "Flight Code"; Code[20])
        {
            Editable = false;
            // TableRelation = "Pre Alert Line"."HAWB No" WHERE("Pre Alert No" = FIELD("Airline Code"),
            //                                                   "C&F Agent" = FIELD("Booking Date")); //B2BUPG
        }
        field(27; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(28; "Port of Loading"; Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(29; "Cut-off Time"; Time)
        {
            Editable = false;
        }
        field(30; "Destination Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(31; "Port of Discharge"; Code[20])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Destination Code"));
        }
        field(32; "Place of Delivery"; Text[30])
        {
        }
        field(33; "Via Route/Transist"; Code[20])
        {
            TableRelation = "Via Destination"."Via Destination Code" WHERE("Airline Code" = FIELD("Airline Code"),
                                                                            "Flight Code" = FIELD("Via Route/Transist"),
                                                                            "FS Destination Code" = FIELD("Destination Code"));
        }
        field(34; "MAWB Date"; Date)
        {
            Editable = false;
        }
        field(35; "Type of Delivery"; Code[20])
        {
            TableRelation = "Delivery Type";
        }
        field(36; "Booking Date"; Date)
        {
        }
        field(37; "Shipper Code"; Code[20])
        {
            Editable = false;
        }
        field(38; "Division/Farm Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Shipper Farm"."Farm Code" WHERE("Shipper Code" = FIELD("Shipper Code"));
        }
        field(39; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Header";
        }
        field(40; "FWL Docket No."; Code[20])
        {
        }
        field(41; "FWL Docket Weight"; Decimal)
        {
            CalcFormula = Sum("Good Receipt ULD Allocation"."FWL Docket Weight" WHERE("Good Receipt No." = FIELD("Good Receipt No."),
                                                                                       "Airline Code" = FIELD("Airline Code"),
                                                                                       "Flight Code" = FIELD("Flight Code"),
                                                                                       "Shipper Code" = FIELD("Shipper Code"),
                                                                                       "MAWB No" = FIELD("MAWB No.")));
            FieldClass = FlowField;
        }
        field(42; "FWL Gross Weight"; Decimal)
        {
        }
        field(43; "Airline Docket Weight"; Decimal)
        {
        }
        field(44; "Skid Per"; Decimal)
        {
        }
        field(45; Position; Code[20])
        {
        }
        field(46; "Arrival Temperature"; Decimal)
        {
        }
        field(47; "Departure Temperature"; Decimal)
        {
        }
        field(48; "X-Ray"; Boolean)
        {
        }
        field(49; "Original MAWB No."; Code[50])
        {
        }
        field(50; Closed; Boolean)
        {
        }
        field(51; "Source Airport"; Code[10])
        {
        }
        field(52; "Destination Airport"; Code[10])
        {
        }
        field(53; "Source Code"; Code[50])
        {
        }
        field(54; "Consignee Name"; Text[250])
        {
        }
        field(55; Length; Decimal)
        {
        }
        field(56; Width; Decimal)
        {
        }
        field(57; Height; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Good Receipt No.", "Line No.", "MAWB No.")
        {
            Clustered = true;
        }
        key(Key2; "Shipper Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."MAWB No.", "MAWB No.");
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Shipper Code", "Shipper Code");
        IF LoadingSheetHeader.FINDFIRST THEN BEGIN
            IF LoadingSheetHeader.Shipped THEN BEGIN
                ERROR('The Goods Receipt has a MAWB %1 Which has been Shipped. Please Reset Loading Sheet %2 to Proceed', "MAWB No.", LoadingSheetHeader."No.");
            END ELSE BEGIN
                ERROR('The Goods Receipt has a MAWB %1 Which has been Loaded. Please Reset Loading Sheet %2 to Proceed', "MAWB No.", LoadingSheetHeader."No.");
            END;
        END;
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB No.");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code", "Shipper Code");
        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
            BookingSheetMAWBAllocation."MAWB Received" := FALSE;
            BookingSheetMAWBAllocation.MODIFY;
        END;
        BookingSheetLine.RESET;
        BookingSheetLine.SETRANGE(BookingSheetLine."Good Receipt No.", "Good Receipt No.");
        BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code", "Airline Code");
        BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code", "Flight Code");
        BookingSheetLine.SETRANGE(BookingSheetLine."Shipper Code", "Shipper Code");
        BookingSheetLine.SETRANGE(BookingSheetLine."Item No.", "Item No.");
        IF BookingSheetLine.FINDSET THEN BEGIN
            REPEAT
                BookingSheetLine."Good Receipt No." := '';
                BookingSheetLine.MODIFY;
            UNTIL BookingSheetLine.NEXT = 0;
            BookingSheetHeader.GET(BookingSheetLine."Booking Sheet No.");
            BookingSheetHeader.Status := BookingSheetHeader.Status::Submitted;
            BookingSheetHeader.MODIFY;
        END;

        GoodReceiptNotifyParty.RESET;
        GoodReceiptNotifyParty.SETRANGE("Good Receipt No.", "Good Receipt No.");
        GoodReceiptNotifyParty.SETRANGE("Airline Code", "Airline Code");
        GoodReceiptNotifyParty.SETRANGE("Flight Code", "Flight Code");
        GoodReceiptNotifyParty.SETRANGE("Shipper Code", "Shipper Code");
        GoodReceiptNotifyParty.SETRANGE("Item No.", "Item No.");
        IF GoodReceiptNotifyParty.FINDFIRST THEN BEGIN
            GoodReceiptNotifyParty.DELETEALL;
        END;
    end;

    trigger OnInsert()
    begin
        TESTFIELD("Arrival Temperature");
        TESTFIELD(Length);
        TESTFIELD(Width);
        TESTFIELD(Height);
    end;

    var
        HAWBReceipt: Record "HAWB Receipt";
        Item: Record Item;
        BookingSheetHeader: Record "Booking Sheet Header";
        BookingSheetLine: Record "Booking Sheet Line";
        Shipper: Record Customer;
        DailyWeightDistByAirline: Record "Dl. Weight Dist. By Airline";
        BookingSheetULDAllocation: Record "Booking Sheet ULD Allocation";
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        LoadingSheetULDAllocation: Record "Loading Sheet ULD Allocation";
        Text001: Label 'You cannot delete Item No. %1 because it has entries associated with it';
        LoadingSheetNotifyParty: Record "Loading Sheet Notify Party";
        GoodReceiptNotifyParty: Record "Good Receipt Notify Party";
        GoodReceiptULDAllocation: Record "Good Receipt ULD Allocation";
        GRHeader: Record "Good Receipt Header";
        GRNLine: Record "Good Receipt Line";
        LoadingSheetLine1: Record "Loading Sheet Line";
        ShippedQty: Decimal;
        LoadingSheetLine2: Record "Loading Sheet Line";
        Consignees: Record Consignee;
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        LoadingSheetHeader: Record "Loading Sheet Header";


    procedure InsertLoadingSheetFromGoodReceiptLine(var LoadingSheetLine: Record "Loading Sheet Line")
    var
        LoadingSheetHeader: Record "Loading Sheet Header";
        LoadingSheetGRNHeader: Record "Loading Sheet Header";
        LoadingSheetGRNLine: Record "Loading Sheet Line";
        TempLoadingSheetLine: Record "Loading Sheet Line";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        GoodReceiptLine: Record "Good Receipt Line";
    begin
        SETRANGE("Good Receipt No.", "Good Receipt No.");
        SETRANGE("Shipper Code", "Shipper Code");
        SETRANGE("MAWB No.", "MAWB No.");
        SETRANGE("MAWB No.", "MAWB No.");
        SETRANGE("Item No.", "Item No.");
        SETRANGE("Division/Farm Code", "Division/Farm Code");
        SETRANGE("Consignee Code", "Consignee Code");
        TempLoadingSheetLine := LoadingSheetLine;


        //*********INSERT ITEMS TO LOADING SHEET FROM GOODS RECEIPT NOTE(GRN)*******
        IF LoadingSheetLine.FIND('+') THEN BEGIN
            NextLineNo := LoadingSheetLine."Line No." + 10000;

        END ELSE
            NextLineNo := 1000;
        REPEAT
            LoadingSheetLine1.RESET;
            LoadingSheetLine1.SETRANGE(LoadingSheetLine1."GRN No.", "Good Receipt No.");
            LoadingSheetLine1.SETRANGE(LoadingSheetLine1."MAWB No.", "MAWB No.");
            LoadingSheetLine1.SETRANGE(LoadingSheetLine1."Division/Farm Code", "Division/Farm Code");
            IF LoadingSheetLine1.FINDSET THEN BEGIN
                ShippedQty := 0;
                REPEAT
                    LoadingSheetLine1.CALCFIELDS(LoadingSheetLine1.Quantity);
                    ShippedQty += LoadingSheetLine1.Quantity;
                UNTIL LoadingSheetLine1.NEXT = 0;
            END;
            //MESSAGE('%1',ShippedQty);
            LoadingSheetGRNLine.INIT;
            LoadingSheetGRNLine."Loading Sheet No." := LoadingSheetGRNLine."Loading Sheet No.";
            LoadingSheetGRNLine."Line No." := LoadingSheetGRNLine."Line No.";

            LoadingSheetLine := LoadingSheetGRNLine;
            LoadingSheetLine."Loading Sheet No." := TempLoadingSheetLine."Loading Sheet No.";
            LoadingSheetLine."Line No." := NextLineNo;
            LoadingSheetLine.Type := LoadingSheetLine.Type::Item;
            LoadingSheetLine."Item No." := "Item No.";
            LoadingSheetLine."In Stock" := (Quantity - ShippedQty);
            LoadingSheetLine."FWL Docket Weight" := "Actual Weight";
            LoadingSheetLine."FWL Gross Weight" := "Actual Weight";
            LoadingSheetLine."Airline Docket Weight" := "Actual Weight";
            LoadingSheetLine."FWL Docket No." := "FWL Docket No.";
            LoadingSheetLine."MAWB No." := "MAWB No.";
            LoadingSheetLine."Airline Code" := "Airline Code";
            LoadingSheetLine."Consignee Code" := "Consignee Code";
            LoadingSheetLine.Description := Description;
            LoadingSheetLine."Unit of Measure Code" := "Unit of Measure Code";
            LoadingSheetLine."Flight Code" := "Flight Code";
            LoadingSheetLine."Destination Code" := "Destination Code";
            LoadingSheetLine."Shipper Code" := "Shipper Code";
            LoadingSheetLine."Division/Farm Code" := "Division/Farm Code";
            LoadingSheetLine."Location Code" := "Location Code";
            LoadingSheetLine."X-Ray" := "X-Ray";
            LoadingSheetLine."Arrival Temperature" := "Arrival Temperature";
            LoadingSheetLine."GRN No." := "Good Receipt No.";
            LoadingSheetLine."Consignee Code" := "Consignee Code";
            LoadingSheetLine."Consignee Name" := "Consignee Name";
            LoadingSheetLine.Length := Length;
            LoadingSheetLine.Width := Width;
            LoadingSheetLine.Height := Height;
            LoadingSheetLine.INSERT;
            NextLineNo := NextLineNo + 1000;
            ///"Loading Sheet No.":=LoadingSheetLine."Loading Sheet No.";
            MODIFY;
            GoodReceiptNotifyParty.RESET;
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty."Good Receipt No.", "Good Receipt No.");
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty."Airline Code", "Airline Code");
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty."Flight Code", "Flight Code");
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty."Shipper Code", "Shipper Code");
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty."Item No.", "Item No.");
            GoodReceiptNotifyParty.SETRANGE(GoodReceiptNotifyParty.FAM, "Division/Farm Code");
            IF GoodReceiptNotifyParty.FINDSET THEN BEGIN
                REPEAT
                    LoadingSheetNotifyParty."Loading Sheet No." := TempLoadingSheetLine."Loading Sheet No.";
                    LoadingSheetNotifyParty."Shipper Code" := GoodReceiptNotifyParty."Shipper Code";
                    LoadingSheetNotifyParty."Airline Code" := GoodReceiptNotifyParty."Airline Code";
                    LoadingSheetNotifyParty."Flight Code" := GoodReceiptNotifyParty."Flight Code";
                    LoadingSheetNotifyParty."Item No." := GoodReceiptNotifyParty."Item No.";
                    LoadingSheetNotifyParty."Notify-Party No." := GoodReceiptNotifyParty."Notify-Party No.";
                    LoadingSheetNotifyParty."Notify-Party Name" := GoodReceiptNotifyParty."Notify-Party Name";
                    LoadingSheetNotifyParty."Source Type" := GoodReceiptNotifyParty."Source Type";
                    LoadingSheetNotifyParty."Source Code" := GoodReceiptNotifyParty."Source Code";
                    LoadingSheetNotifyParty."Line No" := LoadingSheetNotifyParty."Line No" + 1000;
                    LoadingSheetNotifyParty."Source Airport" := GoodReceiptNotifyParty."Source Airport";
                    LoadingSheetNotifyParty."Destination Airport" := GoodReceiptNotifyParty."Destination Airport";
                    LoadingSheetNotifyParty.FAM := GoodReceiptNotifyParty.FAM;
                    LoadingSheetNotifyParty.INSERT;
                UNTIL GoodReceiptNotifyParty.NEXT = 0;
            END;

            GoodReceiptULDAllocation.RESET;
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."Good Receipt No.", "Good Receipt No.");
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."Shipper Code", "Shipper Code");
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."Airline Code", "Airline Code");
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."Flight Code", "Flight Code");
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."Item No.", "Item No.");
            GoodReceiptULDAllocation.SETRANGE(GoodReceiptULDAllocation."MAWB No", "MAWB No.");
            IF GoodReceiptULDAllocation.FINDSET THEN BEGIN
                REPEAT
                    LoadingSheetULDAllocation."Loading Sheet No." := TempLoadingSheetLine."Loading Sheet No.";
                    LoadingSheetULDAllocation."Item No." := GoodReceiptULDAllocation."Item No.";
                    LoadingSheetULDAllocation."ULD Type Code" := GoodReceiptULDAllocation."ULD Type Code";
                    LoadingSheetULDAllocation."Airline Code" := GoodReceiptULDAllocation."Airline Code";
                    LoadingSheetULDAllocation.Quantity := GoodReceiptULDAllocation.Quantity;
                    LoadingSheetULDAllocation."FWL Docket Weight" := GoodReceiptULDAllocation."FWL Docket Weight";
                    LoadingSheetULDAllocation."Line No" := LoadingSheetULDAllocation."Line No" + 1000;
                    LoadingSheetULDAllocation."MWAB No." := GoodReceiptULDAllocation."MAWB No";
                    LoadingSheetULDAllocation.INSERT;
                UNTIL GoodReceiptULDAllocation.NEXT = 0;
            END ELSE BEGIN
                //MESSAGE('No grn ULDs');
            END;
        UNTIL (NEXT = 0);
    end;
}

