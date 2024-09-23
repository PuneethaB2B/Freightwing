table 50009 "Import Activities"
{

    fields
    {
        field(1; "Activity Code"; Code[50])
        {
        }
        field(2; Description; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Activity Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

