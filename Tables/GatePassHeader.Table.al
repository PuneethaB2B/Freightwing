table 50068 "Gate Pass Header"
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
        field(2; "Gate-Pass Date"; Date)
        {
            Editable = false;
        }
        field(3; "MAWB No."; Code[20])
        {

            trigger OnValidate()
            begin
                LoadingSheetLine.RESET;
                LoadingSheetLine.SETRANGE(LoadingSheetLine."MAWB No.", "MAWB No.");
                IF LoadingSheetLine.FINDSET THEN BEGIN
                    LoadingSheetHeader.GET(LoadingSheetLine."Loading Sheet No.");
                    Airlines.GET(LoadingSheetHeader."Airline Code");
                    "Airline Code" := LoadingSheetLine."Airline Code";
                    "Flight Code" := LoadingSheetLine."Flight Code";
                    "Loading Sheet No." := LoadingSheetLine."Loading Sheet No.";
                    "Loading Sheet Date" := LoadingSheetHeader."Loading Date";
                    "Shipper Code" := LoadingSheetHeader."Shipper Code";
                    "Shipper Name" := LoadingSheetHeader."Shipper Name";
                    Shade := Airlines.Shade;
                    "Prepared Date" := TODAY;
                    REPEAT
                        MAWB.RESET;
                        MAWB.SETRANGE(MAWB."No.", LoadingSheetLine."MAWB No.");
                        IF MAWB.FINDFIRST THEN BEGIN
                            HAWBLine.RESET;
                            HAWBLine.SETRANGE(HAWBLine."MAWB No.", MAWB."No.");
                            IF HAWBLine.FINDSET THEN BEGIN
                                REPEAT
                                    GatePassLine.RESET;
                                    GatePassLine.INIT;
                                    GatePassLine."Gate-Pass No." := "No.";
                                    GatePassLine."Line No." := GatePassLine."Line No." + 1000;
                                    GatePassLine."Item No." := HAWBLine."Item No.";
                                    GatePassLine."Unit of Measure Code" := 'KG';
                                    GatePassLine.Quantity := HAWBLine.Quantity;
                                    GatePassLine."Vehicle No." := "Vehicle No.";
                                    GatePassLine."Driver Name" := "Driver Name";
                                    GatePassLine."Escort Vehicle No." := "Escort Vehicle No.";
                                    GatePassLine."Supervisor Name" := "Supervisor Name";
                                    GatePassLine.Description := HAWBLine.Description;
                                    GatePassLine.Type := HAWBLine.Type;
                                    GatePassLine."Location Code" := LoadingSheetLine."Location Code";
                                    GatePassLine."MAWB No." := HAWBLine."MAWB No.";
                                    GatePassLine."Airline Code" := HAWBLine."Airline Code";
                                    GatePassLine."Flight Code" := HAWBLine."Flight Code";
                                    GatePassLine."Shipper Code" := HAWBLine."Shipper Code";
                                    GatePassLine."Loading Sheet No." := LoadingSheetLine."Loading Sheet No.";
                                    GatePassLine."HAWB No" := HAWBLine."HAWB No.";
                                    HAWBHeader.GET(HAWBLine."HAWB No.");
                                    GatePassLine.INSERT;
                                UNTIL HAWBLine.NEXT = 0;
                            END;
                        END;
                    UNTIL LoadingSheetLine.NEXT = 0;
                END;
            end;
        }
        field(4; "Airline Code"; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Airlines.RESET;
                Airlines.GET("Airline Code");
                Shade := Airlines.Shade;
            end;
        }
        field(5; "Flight Code"; Code[20])
        {
            Editable = false;
        }
        field(6; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Header"."No.";

            trigger OnValidate()
            begin
                LoadingSheetHeader.GET("Loading Sheet No.");
                "Vehicle No." := LoadingSheetHeader."Vehicle No.";
                "Loading Sheet Date" := LoadingSheetHeader."Loading Date";
            end;
        }
        field(7; "Loading Sheet Date"; Date)
        {
            Editable = false;
        }
        field(8; "Shipper Code"; Code[20])
        {
            Editable = false;
        }
        field(9; "Consignee Code"; Code[20])
        {
            Editable = false;
        }
        field(10; "Prepared By"; Code[50])
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[20])
        {
        }
        field(12; "Shipper Name"; Text[50])
        {
            Editable = false;
        }
        field(13; "Consignee Name"; Text[50])
        {
            Editable = false;
        }
        field(14; "Vehicle No."; Code[20])
        {
        }
        field(15; "Driver Name"; Text[50])
        {
        }
        field(16; "Escort Vehicle No."; Code[20])
        {
        }
        field(17; "Supervisor Name"; Text[50])
        {
        }
        field(18; "Actual Departure Time"; Time)
        {
        }
        field(19; Shade; Text[50])
        {
        }
        field(20; "Created Time"; Time)
        {
            Editable = false;
        }
        field(21; Status; Option)
        {
            OptionCaption = 'New,Released';
            OptionMembers = New,Released;
        }
        field(22; "Released By"; Code[50])
        {
        }
        field(23; "Prepared Date"; Date)
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

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Gate Pass Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Prepared By" := USERID;
        "Prepared Date" := TODAY;
        "Created Time" := TIME;
    end;

    var
        ImportExportSetup: Record 50010;
        NoSeriesMgt: Codeunit 396;
        LoadingSheetHeader: Record 50060;
        Shipper: Record 18;
        Consignee: Record 50015;
        GatePassHeader: Record 50068;
        BookingSheetLine: Record 50054;
        GatePassLine: Record 50069;
        BookingSheetLine2: Record 50054;
        NextLineNo: Decimal;
        HAWBConsignee: Text[255];
        LoadingSheetLine: Record 50061;
        LoadingSheetNos: Text[255];
        BookingSheetHAWBAllocation: Record 50056;
        LoadingSheetULDAllocation: Record 50063;
        ULDNos: Text[255];
        Airlines: Record 50021;
        MAWB: Record 50077;
        HAWBLine: Record 50074;
        HAWBHeader: Record 50075;


    procedure AssistEdit(OldGatePassHeader: Record 50068): Boolean
    begin
        WITH GatePassHeader DO BEGIN
          GatePassHeader := Rec;
          ImportExportSetup.GET;
          ImportExportSetup.TESTFIELD("Gate Pass Nos.");
          IF NoSeriesMgt.SelectSeries(ImportExportSetup."Gate Pass Nos.",OldGatePassHeader."No. Series","No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Gate Pass Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec :=GatePassHeader;
            EXIT(TRUE);
          END;
        END;
    end;
}

