table 50082 "HS Codes"
{
    DrillDownPageID = 50163;
    LookupPageID = 50163;

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[100])
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

