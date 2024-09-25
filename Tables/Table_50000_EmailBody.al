table 50000 "Email Body"
{

    fields
    {
        field(1; "No."; Code[250])
        {
        }
        field(2; "From Address"; Text[250])
        {
        }
        field(3; "To Address"; Text[250])
        {
        }
        field(4; "CC Email"; Text[250])
        {
        }
        field(5; Subject; Text[250])
        {
        }
        field(6; Body; Text[250])
        {
        }
        field(7; "Attachment Path"; Text[250])
        {
        }
        field(8; "Attachment Name"; Text[250])
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

