table 50062 "Dump Cust Ent"
{

    fields
    {
        field(1; "AWB Date"; Date)
        {
        }
        field(2; "MAWB No."; Code[50])
        {
        }
        field(3; "Custom Ent"; Code[10])
        {
        }
        field(4; "No."; Integer)
        {
        }
        field(5; reconciled; Boolean)
        {
        }
        field(6; Located; Boolean)
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
}

