table 50035 "Weight Agreement By Day"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "Weight Agreement Destination"."Airline Code";
        }
        field(2; "Source Code"; Code[20])
        {
            TableRelation = "Weight Agreement Destination"."Source Code";
        }
        field(3; "Destination Code"; Code[20])
        {
            TableRelation = "Weight Agreement Destination"."Destination Code";
        }
        field(4; "Day of Week"; Option)
        {
            Editable = false;
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;

            trigger OnValidate()
            begin
                IF "Day of Week" = 1 THEN
                    "Day of Week" := DayofWeek::Monday
                ELSE
                    IF "Day of Week" = 2 THEN
                        "Day of Week" := DayofWeek::Tuesday
                    ELSE
                        IF "Day of Week" = 3 THEN
                            "Day of Week" := DayofWeek::Wednesday
                        ELSE
                            IF "Day of Week" = 4 THEN
                                "Day of Week" := DayofWeek::Thursday
                            ELSE
                                IF "Day of Week" = 5 THEN
                                    "Day of Week" := DayofWeek::Friday
                                ELSE
                                    IF "Day of Week" = 6 THEN
                                        "Day of Week" := DayofWeek::Saturday
                                    ELSE
                                        IF "Day of Week" = 7 THEN
                                            "Day of Week" := DayofWeek::Sunday;
            end;
        }
        field(5; "Gross Weight"; Decimal)
        {
            CalcFormula = Sum("Weight Agreement By Item"."Min. Chargeable Weight" WHERE(Airline Code=FIELD(Airline Code),
                                                                                         Source Code=FIELD(Source Code),
                                                                                         Destination Code=FIELD(Destination Code),
                                                                                         Day of Week=FIELD(Day of Week),
                                                                                         Destination Airport=FIELD(Destination Airport),
                                                                                         Source Airport=FIELD(Source Airport)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Destination Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));
        }
        field(7;"Source Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Source Code));
        }
    }

    keys
    {
        key(Key1;"Airline Code","Source Code","Destination Code","Day of Week","Source Airport","Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        WeightAgreementByItem.RESET;
        WeightAgreementByItem.SETRANGE("Airline Code","Airline Code");
        WeightAgreementByItem.SETRANGE("Source Code","Source Code");
        WeightAgreementByItem.SETRANGE("Destination Code","Destination Code");
        WeightAgreementByItem.SETRANGE("Day of Week","Day of Week");
        IF WeightAgreementByItem.FINDFIRST THEN
          ERROR(Text001,"Day of Week");
    end;

    var
        Text001: Label 'You cannot delete %1 because there is at least one item entries associated with it.';
        WeightAgreementByItem: Record "50036";
        DayofWeek: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
}

