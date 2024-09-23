table 50007 "Import Charge"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
            TableRelation = "Freight Charge".Code;

            trigger OnValidate()
            begin
                FreightCharge.GET(Code);
                Description := FreightCharge.Description;
                "G/L Account" := FreightCharge."G/L Account";
                "VAT Bus. Posting Group" := FreightCharge."VAT Bus. Posting Group";
                "VAT Prod. Posting Group" := FreightCharge."VAT Prod. Posting Group";
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account".No.;
        }
        field(4; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(5; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(6; "Import Charge"; Decimal)
        {
        }
        field(7; Currency; Code[10])
        {
            TableRelation = Currency.Code;
        }
    }

    keys
    {
        key(Key1; "Code")
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

