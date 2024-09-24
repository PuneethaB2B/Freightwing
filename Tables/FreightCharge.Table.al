table 50018 "Freight Charge"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
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
        field(6; "Margin %"; Decimal)
        {
        }
        field(7; "Payment Mode"; Option)
        {
            OptionMembers = " ",PP,CC;
        }
        field(8; "Flat Rate"; Decimal)
        {
        }
        field(9; "Customer Type"; Option)
        {
            OptionMembers = ,Group,"Third Party",Both;
        }
        field(10; "Freight Cost"; Boolean)
        {
        }
        field(12; "Purchase A/C Code"; Code[10])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(13; "Handling Charge"; Boolean)
        {
        }
        field(14; "Margin Applicable"; Boolean)
        {
        }
        field(15; "Delivery Type"; Code[20])
        {
            TableRelation = "Delivery Type";
        }
        field(16; "Split On"; Option)
        {
            OptionCaption = 'HAWB''s,Weights';
            OptionMembers = "HAWB's",Weights;
        }
        field(17; "Export Mandatory"; Boolean)
        {
        }
        field(18; Group; Boolean)
        {
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
}

