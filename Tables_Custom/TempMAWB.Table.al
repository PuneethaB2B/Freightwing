table 50002 "Temp MAWB"
{

    fields
    {
        field(1; MAW; Code[50])
        {
        }
        field(2; Airline; Code[50])
        {
            TableRelation = Airline.Code;
        }
        field(3; Occurence; Integer)
        {
        }
        field(4; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(5; "Recorded in"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; MAW, LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

