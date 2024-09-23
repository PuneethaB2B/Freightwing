table 50001 "Report Request Parameters"
{

    fields
    {
        field(1; ReportID; Integer)
        {
        }
        field(2; UserID; Code[100])
        {
        }
        field(3; Parameters; BLOB)
        {
        }
        field(4; ToEmail; Text[250])
        {
        }
        field(5; "Statement Period Start Date"; Date)
        {
        }
        field(6; "Statement Period End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; ReportID, UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

