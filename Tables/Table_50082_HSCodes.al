table 50082 "HS Codes"
{
    DrillDownPageID = "HS Codes";
    LookupPageID = "HS Codes";

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

