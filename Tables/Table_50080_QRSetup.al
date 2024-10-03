table 50080 "QR Setup."
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Credit Note Url"; Text[150])
        {
            ExtendedDatatype = URL;
        }
        field(3; "Invoice Url"; Text[150])
        {
            ExtendedDatatype = URL;
        }
        field(4; "QR Location"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

