table 50005 "MAWB Base Charge"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "Freight Charge";

            trigger OnValidate()
            begin
                FreightCharge.GET(Code);
                Description := FreightCharge.Description;
                "G/L Account" := FreightCharge."G/L Account";
            end;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Amount; Decimal)
        {
        }
        field(4; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account".No.;
        }
        field(5;"Airline Code";Code[20])
        {
            TableRelation = Airline.Code;
        }
        field(6;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
    }

    keys
    {
        key(Key1;"Code","Airline Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        FreightCharge: Record "50018";
}

