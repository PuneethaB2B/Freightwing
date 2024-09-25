table 50037 "HAWB Receipt"
{

    fields
    {
        field(1; "HAWB No."; Code[20])
        {
        }
        field(2; "Receipt Date"; Date)
        {
        }
        field(3; Assigned; Boolean)
        {
        }
        field(4; Prepared; Boolean)
        {
        }
        field(5; "Prefix Code"; Code[10])
        {
        }
        field(6; "Start No."; Code[10])
        {
        }
        field(7; "End No."; Code[10])
        {
        }
        field(8; "Bill No."; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "HAWB No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

