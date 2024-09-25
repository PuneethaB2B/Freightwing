table 50019 Airport
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Country Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(4; Location; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Country Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

