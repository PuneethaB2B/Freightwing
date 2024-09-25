table 50078 "Wk. Customer Req. By Day Line"
{

    fields
    {
        field(1; "Weekly No."; Code[20])
        {
            TableRelation = "Wk. Customer Wgt. Req. Line"."Weekly No.";
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = "Wk. Customer Wgt. Req. Line"."Customer No.";
        }
        field(3; "Planned Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                //WeekDay := DATE2DMY(Day,1);
                Description := FORMAT("Planned Date", 0, '<Weekday Text>');
            end;
        }
        field(4; Description; Text[50])
        {
            Editable = false;
        }
        field(5; "Line Weight"; Decimal)
        {
            Editable = true;
        }
        field(7; "Destination Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Weekly No.", "Customer No.", "Planned Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        WeeklyCustWeightReqLine: Record 50048;
        WeeklyCustWeightReqHeader: Record 50047;
        Text001: Label 'The %1 is not within the weekly schedule dates';
}

