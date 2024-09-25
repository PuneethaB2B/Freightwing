table 50045 "Handling Slab Matrix"
{

    fields
    {
        field(1; "Freight Charge Code"; Code[20])
        {
            TableRelation = "Freight Charge".Code;
        }
        field(2; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(3; "From Weight"; Decimal)
        {
        }
        field(4; "To Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "To Weight" < "From Weight" THEN
                    ERROR(Text000);
            end;
        }
        field(5; "Rate Amount"; Decimal)
        {
        }
        field(6; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
    }

    keys
    {
        key(Key1; "Freight Charge Code", "Unit of Measure Code", "From Weight", "To Weight")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DayName: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        NextDate: Date;
        i: Integer;
        Text000: Label 'From Weight cannot be less than To Weight';
}

