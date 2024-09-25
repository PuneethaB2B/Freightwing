table 50010 "Import/Export Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(2; "Consignee Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Notify Party Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(4; "Daily Analysis Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(5; "Weekly Analysis Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(6; "Booking Sheet Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(7; "Item Journal Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE ("Journal Template Name"=FIELD("Item Journal Template"));
        }
        field(8; "Item Journal Template"; Code[10])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(9; "Loading Sheet Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(10; "Gate Pass Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(12; "Weight Rounding Precision"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Weight Rounding Precision';
            InitValue = 1;
        }
        field(13; "Weight Rounding Type"; Option)
        {
            Caption = 'Weight Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(14; "Sales Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name"=FIELD("Sales Journal Template"));
        }
        field(15; "Sales Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(16; "Good Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(17; "Pre Alert Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(18; "Default Vendor Code"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                Vend.GET("Default Vendor Code");
                "Default Vendor Name" := Vend.Name;
            end;
        }
        field(19; "Default Vendor Name"; Text[50])
        {
        }
        field(20; "Invoicing Currency Code"; Code[10])
        {
            Caption = 'LCY Code';
            TableRelation = Currency.Code;
        }
        field(21; "Source Airport"; Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(22; "Agent's IATA Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(23; "Carrier Agent Code"; Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(24; "Group Purchase A/C Code"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(25; "Third Party Purchase A/C Code"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(26; "Division Factor"; Decimal)
        {
        }
        field(27; "Offload Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(28; "ETR PIN."; Code[100])
        {
        }
        field(29; "IATA Purchase Acc.Group"; Code[40])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(30; "IATA Purchase Acc.TP"; Code[40])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(31; "Default IATA Vendor"; Code[40])
        {
            TableRelation = Vendor."No.";
        }
        field(32; "KRA Pin"; Code[50])
        {
        }
        field(33; "CutOff Time"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record 23;
}

