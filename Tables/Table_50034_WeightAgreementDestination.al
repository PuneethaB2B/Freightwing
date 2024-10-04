table 50034 "Weight Agreement Destination"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                CalcDestinationWeight;
            end;
        }
        field(2; "Source Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(3; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(4; "Gross Weight"; Decimal)
        {
            CalcFormula = Sum("Weight Agreement By Item"."Min. Chargeable Weight" WHERE("Airline Code" = FIELD("Airline Code"),
                                                                                         "Source Code" = FIELD("Source Code"),
                                                                                         "Destination Code" = FIELD("Destination Code"),
                                                                                         "Source Airport" = FIELD("Source Airport"),
                                                                                         "Destination Airport" = FIELD("Destination Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Destination Airport"; Code[50])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Destination Code"));

            trigger OnValidate()
            begin
                i := 0;
                TESTFIELD("Source Code");
                //====POLULATE DAYS AUTOMATICALLY=====
                REPEAT
                    WeightAgreementByDay.INIT;
                    WeightAgreementByDay."Airline Code" := "Airline Code";
                    WeightAgreementByDay."Source Code" := "Source Code";
                    WeightAgreementByDay."Destination Code" := "Destination Code";
                    WeightAgreementByDay."Source Airport" := "Source Airport";
                    WeightAgreementByDay."Destination Airport" := "Destination Airport";
                    i := i + 1;
                    WeightAgreementByDay."Day of Week" := i;
                    WeightAgreementByDay.VALIDATE("Day of Week");
                    WeightAgreementByDay.INSERT;
                UNTIL i = 7;
            end;
        }
        field(6; "Source Airport"; Code[50])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Source Code"));
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Source Code", "Source Airport", "Destination Code", "Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        WeightAgreementByDay.RESET;
        WeightAgreementByDay.SETRANGE("Airline Code", "Airline Code");
        WeightAgreementByDay.SETRANGE(WeightAgreementByDay."Source Code", "Source Code");
        WeightAgreementByDay.SETRANGE(WeightAgreementByDay."Destination Code", "Destination Code");
        IF WeightAgreementByDay.FINDFIRST THEN
            ERROR(Text001, FIELDCAPTION("Destination Code"), WeightAgreementByDay."Destination Code");
    end;

    var
        WeightAgreementByDay: Record "Weight Agreement By Day";
        Text001: Label 'You cannot delete this line because there is at least one entries associated with it.';
        i: Integer;


    procedure CalcDestinationWeight()
    begin
        //"Destination Weight":=0;

        WeightAgreementByDay.RESET;
        WeightAgreementByDay.SETRANGE(WeightAgreementByDay."Airline Code", "Airline Code");
        WeightAgreementByDay.SETRANGE(WeightAgreementByDay."Source Code", "Source Code");
        WeightAgreementByDay.SETRANGE(WeightAgreementByDay."Destination Code", "Destination Code");
        IF WeightAgreementByDay.FINDSET THEN BEGIN
            REPEAT
                WeightAgreementByDay.CALCFIELDS("Gross Weight");
                "Gross Weight" := "Gross Weight" + WeightAgreementByDay."Gross Weight";
            UNTIL WeightAgreementByDay.NEXT = 0;
        END;
    end;
}

