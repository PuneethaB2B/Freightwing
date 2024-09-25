table 50032 ULD
{

    fields
    {
        field(1; "ULD Type Code"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(2; "ULD No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "ULD Type Code", "ULD No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

