table 50048 "Wk. Customer Wgt. Req. Line"
{

    fields
    {
        field(1; "Weekly No."; Code[20])
        {
            TableRelation = "Wk. Customer Wgt. Req. Header"."No.";
        }
        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer."No." WHERE("Customer Type" = FILTER(Group | "Third Party"));

            trigger OnValidate()
            begin

                Cust.GET("Customer No.");
                "Customer Name" := Cust.Name;

                WeeklyCustWeighttReqHeader.GET("Weekly No.");
                WeeklyCustWeighttReqHeader.TESTFIELD("Destination Code");
                "Destination Code" := WeeklyCustWeighttReqHeader."Destination Code";
                WeeklyCustWeighttReqHeader.TESTFIELD(Description);


                //====POLULATE DAYS AUTOMATICALLY=====
                NextDate := CALCDATE('-1D', WeeklyCustWeighttReqHeader."Start Date");
            end;
        }
        field(3; "Customer Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Line Weight"; Decimal)
        {
            CalcFormula = Sum("Wk. Customer Req. By Day Line"."Line Weight" WHERE("Weekly No." = FIELD("Weekly No."),
                                                                                   "Customer No." = FIELD("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Customer Type"; Option)
        {
            Editable = false;
            OptionMembers = " ","Third Party",Group;
        }
        field(7; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Weekly No.", "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        WeeklyCustWeighttReqHeader: Record "Wk. Customer Wgt. Req. Header";
        DayName: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        NextDate: Date;
        Cust: Record Customer;
        Text001: Label 'You cannot delete Customer No. %1 because it has entries associated with it';
}

