table 50033 "Weight Agreement By Airline"
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

                Description := Text002 + ' ' + "Airline Code";
            end;
        }
        field(2; "Airline Name"; Text[30])
        {
            Editable = false;
        }
        field(3; "Total Capacity"; Decimal)
        {
            CalcFormula = Sum("Weight Agreement By Item"."Min. Chargeable Weight" WHERE("Airline Code" = FIELD("Airline Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; Description; Text[30])
        {
        }
        field(5; From; Date)
        {
        }
        field(6; "To"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Airline Code", From, "To")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        WeightAgreementDestination.RESET;
        WeightAgreementDestination.SETRANGE("Airline Code", "Airline Code");
        IF WeightAgreementDestination.FINDFIRST THEN
            ERROR(Text001, "Airline Code");
    end;

    var
        Airline: Record Airline;
        WeightAgreementDestination: Record "Weight Agreement Destination";
        Text001: Label 'You cannot delete Airline %1 because there is at least one entries associated with it.';
        Text002: Label 'Weight Agreement for';
}

