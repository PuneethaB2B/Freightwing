table 50038 "MAWB By Airline"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                Airline.GET("Airline Code");
                "Airline Name" := Airline.Name;
            end;
        }
        field(2; "Airline Name"; Text[30])
        {
            Editable = false;
        }
        field(3; "MAWB Fees"; Decimal)
        {
        }
        field(4; "Freight Charge Code"; Code[20])
        {
            TableRelation = "Freight Charge";
        }
        field(5; "KAA Fees"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Airline Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        MAWBReceipt.RESET;
        MAWBReceipt.SETRANGE("Airline Code", "Airline Code");
        IF MAWBReceipt.FINDFIRST THEN
            ERROR(Text001, "Airline Code");
    end;

    var
        Airline: Record Airline;
        MAWBReceipt: Record "MAWB Receipt";
        Text001: Label 'You cannot delete Airline %1 because it has records associated with it';
}

