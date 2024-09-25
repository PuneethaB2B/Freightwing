table 50081 "Data Exch. Field."
{

    fields
    {
        field(1; "Data Exch. No."; Integer)
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Column No."; Integer)
        {
        }
        field(4; Value; Text[250])
        {
        }
        field(5; "Node ID"; Text[250])
        {
        }
        field(6; "Data Exch. Line Def Code"; Code[20])
        {
        }
        field(7; "Parent Node ID"; Text[250])
        {
        }
        field(8; "Data Exch. Def Code"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Data Exch. No.", "Line No.", "Column No.", "Node ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

