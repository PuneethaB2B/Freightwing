table 50030 "Pre Alert Header"
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
        field(2; "Manifest No"; Code[20])
        {

            trigger OnValidate()
            begin
                "Menifest Date" := TODAY;
            end;
        }
        field(3; "MAWB No"; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE(Assigned = FILTER(false));
        }
        field(4; "Delivery Agent"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(5; "Flight No"; Code[20])
        {
            TableRelation = Flight."Flight No.";

            trigger OnValidate()
            begin
                Flights.RESET;
                Flights.SETRANGE(Flights."Flight No.", "Flight No");
                IF Flights.FINDFIRST THEN BEGIN
                    "Port of Origin" := Flights."Source Airport";
                    "Port of Discharge" := Flights."Destination Airport";
                    "Country of Origin" := Flights."Source Code";
                    "Country of Discharge" := Flights."Destination Code";
                    "Scheduled Time" := Flights."Departure Time";
                    "Pre-Alert Date" := TODAY;

                END;
            end;
        }
        field(6; "Port of Origin"; Code[20])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Country of Origin"));
        }
        field(7; "Port of Discharge"; Code[20])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Country of Discharge"));
        }
        field(8; VIA; Code[10])
        {
            TableRelation = Airport.Code;
        }
        field(9; "Country of Origin"; Text[30])
        {
            TableRelation = "Country/Region".Code;
        }
        field(10; "Country of Discharge"; Text[30])
        {
            TableRelation = "Country/Region".Code;
        }
        field(12; "Scheduled Date"; Date)
        {
        }
        field(13; "Scheduled Time"; Time)
        {
        }
        field(14; "Pre-Alert Date"; Date)
        {
        }
        field(15; "Menifest Date"; Date)
        {
        }
        field(16; "MAWB Date"; Date)
        {
        }
        field(17; "Mode of Payment"; Code[50])
        {
            TableRelation = "Payment Method".Code;
        }
        field(18; "IDF No"; Code[10])
        {
        }
        field(19; "Prepared By"; Code[30])
        {
            Editable = false;
        }
        field(20; "No. Series"; Code[20])
        {
        }
        field(21; "Flight Code"; Code[10])
        {
            TableRelation = Flight."Flight Code";
        }
        field(22; "Cargo Receipt No"; Code[10])
        {
        }
        field(23; "CIF Value"; Decimal)
        {
        }
        field(24; "Actual Arrival Date"; Date)
        {
        }
        field(25; "Actual Arrival Time"; Time)
        {
        }
        field(26; Status; Option)
        {
            OptionMembers = ,"Pre-Alert","Airport Receipt","FWL Receipt",Delivered;
        }
        field(27; "Item No."; Code[20])
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
        field(28; Weight; Decimal)
        {
            Caption = 'Booked Weight';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(29; Quantity; Decimal)
        {
        }
        field(30; Invoiced; Boolean)
        {
        }
        field(31; Updates; Option)
        {
            OptionMembers = ,Active,Archived;
        }
        field(32; Currency; Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(33; "Arrival Date FWL"; Date)
        {
        }
        field(34; "Arrival Time FWL"; Time)
        {
        }
        field(35; "Delivery Date"; Date)
        {
        }
        field(36; "Delivery Time"; Time)
        {
        }
        field(37; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(38; "Created On"; Date)
        {
            Editable = false;
        }
        field(39; "Last Updated By"; Code[50])
        {
            Editable = false;
        }
        field(40; "Last Updated On"; Date)
        {
            Editable = false;
        }
        field(41; "Last Updated At"; Time)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "MAWB No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "MAWB No", "No.", "Flight No", "Country of Origin", "Country of Discharge")
        {
        }
    }

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Pre Alert Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        "Prepared By" := USERID;
        Status := Status::"Pre-Alert";
        Invoiced := FALSE;
        Updates := Updates::Active;
        "Last Updated At" := TIME;
        "Last Updated On" := TODAY;
        "Last Updated By" := USERID;
        "Created On" := TODAY;
        "Created By" := USERID;
    end;

    trigger OnModify()
    begin
        "Last Updated At" := TIME;
        "Last Updated On" := TODAY;
        "Last Updated By" := USERID;
    end;

    var
        ImportExportSetup: Record "Import/Export Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Flights: Record Flight;
}

