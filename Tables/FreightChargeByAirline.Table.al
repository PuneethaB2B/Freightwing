table 50025 "Freight Charge By Airline"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                Airline.RESET;
                Airline.SETRANGE(Airline.Code, "Airline Code");
                IF Airline.FINDFIRST THEN BEGIN
                    "Airline Name" := Airline.Name;
                END;
            end;
        }
        field(2; "Effective Start Date"; Date)
        {
        }
        field(3; "Effective End Date"; Date)
        {
        }
        field(4; "Airline Name"; Text[30])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Effective Start Date", "Effective End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        FreightChargeByFlight.RESET;
        FreightChargeByFlight.SETRANGE("Airline Code", "Airline Code");
        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Effective Start Date", "Effective Start Date");
        IF FreightChargeByFlight.FINDFIRST THEN
            ERROR(Text001, "Airline Code");
    end;

    var
        Airline: Record "50021";
        FreightChargeByFlight: Record "50026";
        Text001: Label 'You cannot delete Airline %1 because there is at least one flight associated with it.';
}

