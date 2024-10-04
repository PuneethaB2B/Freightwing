table 50061 "Loading Sheet Line"
{

    fields
    {
        field(1; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Header"."No.";
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
        field(8; "Division/Farm Code"; Code[20])
        {
            TableRelation = "Shipper Farm"."Farm Code" WHERE("Shipper Code" = FIELD("Shipper Code"));

            trigger OnValidate()
            begin
                FarmDivision.GET("Division/Farm Code");
                Description := FarmDivision.Description;
            end;
        }
        field(9; "FWL Docket No."; Code[20])
        {
        }
        field(10; "FWL Docket Weight"; Decimal)
        {
            CalcFormula = Sum("Loading Sheet ULD Allocation"."FWL Docket Weight" WHERE("Loading Sheet No." = FIELD("Loading Sheet No."),
                                                                                        "Airline Code" = FIELD("Airline Code"),
                                                                                        "Item No." = FIELD("Item No."),
                                                                                        "MWAB No." = FIELD("MAWB No."),
                                                                                        FAM = FIELD("Division/Farm Code"),
                                                                                        Consignee = FIELD("Consignee Code")));
            FieldClass = FlowField;
        }
        field(11; "FWL Gross Weight"; Decimal)
        {
        }
        field(12; "Airline Docket Weight"; Decimal)
        {
            CalcFormula = Sum("Loading Sheet ULD Allocation"."Airline Docket Weight" WHERE("Loading Sheet No." = FIELD("Loading Sheet No."),
                                                                                            "Airline Code" = FIELD("Airline Code"),
                                                                                            "Item No." = FIELD("Item No."),
                                                                                            "MWAB No." = FIELD("MAWB No."),
                                                                                            FAM = FIELD("Division/Farm Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Quantity; Decimal)
        {
            CalcFormula = Sum("Loading Sheet ULD Allocation"."No. Of Boxes" WHERE("Loading Sheet No." = FIELD("Loading Sheet No."),
                                                                                   "Airline Code" = FIELD("Airline Code"),
                                                                                  "MWAB No." = FIELD("MAWB No."),
                                                                                   FAM = FIELD("Division/Farm Code"),
                                                                                   Consignee = FIELD("Consignee Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "ULD Type Code"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(15; "Skid Per"; Decimal)
        {
        }
        field(16; "ULD No."; Code[20])
        {
            TableRelation = ULD."ULD No." WHERE("ULD Type Code" = FIELD("ULD Type Code"));
        }
        field(17; "ULD Quantity"; Decimal)
        {
        }
        field(18; Position; Code[20])
        {
        }
        field(19; "Arrival Temperature"; Decimal)
        {
        }
        field(20; "Departure Temperature"; Decimal)
        {
        }
        field(21; "X-Ray"; Boolean)
        {
        }
        field(22; "Shipper Code"; Code[20])
        {
            TableRelation = "Loading Sheet Header"."Shipper Code";
        }
        field(23; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No." WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(24; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(25; "Consignee Code"; Code[10])
        {
            TableRelation = Consignee."No.";

            trigger OnValidate()
            begin
                Consignee.GET("Consignee Code");
                "Consignee Name" := Consignee.Name;
            end;
        }
        field(26; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;
        }
        field(27; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(28; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            InitValue = Item;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(29; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Reference";
                PrepmtMgt: Codeunit "Prepayment Mgt.";
            begin
                Item.GET("Item No.");
                Description := Item.Description;
            end;
        }
        field(30; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(31; "Quantity Available"; Decimal)
        {
        }
        field(32; "Loading Quantity"; Decimal)
        {
        }
        field(33; "Shipped Quantity"; Decimal)
        {
        }
        field(34; "Balance Quantity"; Decimal)
        {
        }
        field(35; Temperature; Decimal)
        {
        }
        field(36; Return; Boolean)
        {
        }
        field(37; "Return-to Location Code"; Code[10])
        {
        }
        field(38; "Gate-Pass No."; Code[20])
        {
        }
        field(39; "Hipped Quantity"; Decimal)
        {
        }
        field(40; "GRN No."; Code[50])
        {
        }
        field(41; Dimension; Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE("Volume Metric Weight", Dimension / 6000);
            end;
        }
        field(42; "Consignee Name"; Text[250])
        {
        }
        field(43; Length; Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE(Dimension, Length * Width * Height);
            end;
        }
        field(44; Width; Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE(Dimension, Length * Width * Height);
            end;
        }
        field(45; Height; Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE(Dimension, Length * Width * Height);
            end;
        }
        field(46; "In Stock"; Decimal)
        {
        }
        field(50000; "Vaccum Temperature"; Decimal)
        {
        }
        field(50001; "Volume Metric Weight"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loading Sheet No.", "MAWB No.", "Division/Farm Code", "Destination Code", "Line No.", "Consignee Code")
        {
            Clustered = true;
        }
        key(Key2; "Consignee Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Consignee Code", "Consignee Name")
        {
        }
    }

    trigger OnDelete()
    begin
        GoodReceiptLine.RESET;
        GoodReceiptLine.SETRANGE("Shipper Code", "Shipper Code");
        GoodReceiptLine.SETRANGE("Airline Code", "Airline Code");
        GoodReceiptLine.SETRANGE("Flight Code", "Flight Code");
        GoodReceiptLine.SETRANGE("MAWB No.", "MAWB No.");
        GoodReceiptLine.SETRANGE("Item No.", "Item No.");
        IF GoodReceiptLine.FINDFIRST THEN BEGIN
            GoodReceiptLine."Loading Sheet No." := '';
            GoodReceiptLine.MODIFY;
            GRNheader.RESET;
            GRNheader.SETRANGE(GRNheader."No.", GoodReceiptLine."Good Receipt No.");
            IF GRNheader.FINDFIRST THEN BEGIN
                GRNheader.Status := GRNheader.Status::Submitted;
            END;
        END;

        LoadingSheetULDAllocation.RESET;
        LoadingSheetULDAllocation.SETRANGE("Loading Sheet No.", "Loading Sheet No.");
        LoadingSheetULDAllocation.SETRANGE("Airline Code", "Airline Code");
        LoadingSheetULDAllocation.SETRANGE("Item No.", "Item No.");
        IF LoadingSheetULDAllocation.FINDSET THEN BEGIN
            REPEAT
                LoadingSheetULDAllocation.DELETE;
            UNTIL LoadingSheetULDAllocation.NEXT = 0;
        END;
        LoadingSheetNotifyParty.RESET;
        LoadingSheetNotifyParty.SETRANGE(LoadingSheetNotifyParty."Loading Sheet No.", "Loading Sheet No.");
        IF LoadingSheetNotifyParty.FINDSET THEN
            LoadingSheetNotifyParty.DELETEALL;
    end;

    var
        FarmDivision: Record "Division/Farm";
        LoadingSheetULDAllocation: Record "Loading Sheet ULD Allocation";
        GoodReceiptLine: Record "Good Receipt Line";
        LoadingSheetHeader: Record "Loading Sheet Header";
        GatePassULDAllocation: Record "Booking Sheet MAWB Allocation";
        LoadingSheetNotifyParty: Record "Loading Sheet Notify Party";
        GRNheader: Record "Good Receipt Header";
        Consignee: Record Consignee;
        Item: Record Item;


    procedure InsertGatePassFromLoadingSheet(var GatePassLine: Record "Gate Pass Line")
    var
        BookingSheetHeader: Record "Gate Pass Header";
        GatePassLSheetHeader: Record "Gate Pass Header";
        GatePassLSheetLine: Record "Gate Pass Line";
        TempGatePassLine: Record "Gate Pass Line";
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        LoadingSheetLine: Record "Loading Sheet Line";
    begin
        SETRANGE("Loading Sheet No.", "Loading Sheet No.");
        SETRANGE("Item No.", "Item No.");
        TempGatePassLine := GatePassLine;
        IF GatePassLine.FIND('+') THEN
            NextLineNo := GatePassLine."Line No." + 10000
        ELSE
            NextLineNo := 10000;
        REPEAT
            GatePassLSheetLine.INIT;
            GatePassLSheetLine."Line No." := GatePassLSheetLine."Line No.";
            GatePassLSheetLine.Description := Description;

            GatePassLine := GatePassLSheetLine;
            GatePassLine."Line No." := NextLineNo;
            GatePassLine."Gate-Pass No." := TempGatePassLine."Gate-Pass No.";
            GatePassLine.Type := GatePassLine.Type::Item;
            GatePassLine."Item No." := "Item No.";
            GatePassLine.Description := Description;
            GatePassLine."Location Code" := "Location Code";
            GatePassLine."Unit of Measure Code" := "Unit of Measure Code";
            GatePassLine.Quantity := Quantity;
            GatePassLine."MAWB No." := "MAWB No.";
            GatePassLine."Airline Code" := "Airline Code";
            GatePassLine."Flight Code" := "Flight Code";
            GatePassLine."Consignee Code" := "Consignee Code";
            GatePassLine."Shipper Code" := "Shipper Code";

            "Gate-Pass No." := TempGatePassLine."Gate-Pass No.";
            MODIFY;

            LoadingSheetULDAllocation.RESET;
            LoadingSheetULDAllocation.SETRANGE("Loading Sheet No.", "Loading Sheet No.");
            LoadingSheetULDAllocation.SETRANGE("Item No.", "Item No.");
            IF LoadingSheetULDAllocation.FINDSET THEN BEGIN
                GatePassULDAllocation."Booking Sheet No" := TempGatePassLine."Gate-Pass No.";
                GatePassULDAllocation."Weight Allocated" := GatePassULDAllocation."Weight Allocated";
                GatePassULDAllocation."Item No" := LoadingSheetULDAllocation."ULD Type Code";
                GatePassULDAllocation."Line No." := GatePassULDAllocation."Line No.";
                GatePassULDAllocation."MAWB No" := GatePassULDAllocation."MAWB No";
                GatePassULDAllocation."Flight No" := LoadingSheetULDAllocation."ULD No.";
                GatePassULDAllocation.INSERT;
            END;

            GatePassLine.INSERT;
            NextLineNo := NextLineNo + 10000;
        UNTIL (NEXT = 0);
    end;
}

