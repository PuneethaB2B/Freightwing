table 50029 "Freight Item Charge Matrix"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "Freight Item Charge"."Airline Code";
        }
        field(2; "Flight Code"; Code[20])
        {
            TableRelation = "Freight Item Charge"."Flight Code";
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = "Freight Item Charge"."Item No.";
        }
        field(4; "Freight Charge Code"; Code[20])
        {
            TableRelation = "Freight Item Charge".Code;
        }
        field(5; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(6; "No. of Pallets"; Decimal)
        {
        }
        field(7; "ULD Type"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(8; "From Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                IF "From Weight" = 0 THEN
                    Difference := "To Weight" - "From Weight"
                ELSE
                    Difference := ("To Weight" - "From Weight") + 1;
            end;
        }
        field(9; "To Weight"; Decimal)
        {

            trigger OnValidate()
            begin
                /*i:=0;
                TESTFIELD("From Weight");
                //====POLULATE DAYS AUTOMATICALLY=====
                REPEAT
                  FreightChargeMatrixByDay.INIT;
                  FreightChargeMatrixByDay."Airline Code":="Airline Code";
                  FreightChargeMatrixByDay."Flight Code":="Flight Code";
                  FreightChargeMatrixByDay."Item No.":="Item No.";
                  FreightChargeMatrixByDay."Freight Charge Code":="Freight Charge Code";
                  FreightChargeMatrixByDay."From Weight":="From Weight";
                  FreightChargeMatrixByDay."To Weight":="To Weight";
                  i:=i+1;
                  FreightChargeMatrixByDay."Day of Week":=i;
                  FreightChargeMatrixByDay.VALIDATE("Day of Week");
                  FreightChargeMatrixByDay.INSERT;
                UNTIL i=7;
                   */

                IF "To Weight" < "From Weight" THEN
                    ERROR(Text000);


                IF "From Weight" = 0 THEN
                    Difference := "To Weight" - "From Weight"
                ELSE
                    Difference := ("To Weight" - "From Weight") + 1;

            end;
        }
        field(10; "Rate Amount"; Decimal)
        {
        }
        field(11; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(12; Calculation; Option)
        {
            OptionMembers = " ","Kilo Rate","Flat Rate";
        }
        field(13; Difference; Decimal)
        {
        }
        field(14; "Source airport"; Code[50])
        {
        }
        field(15; "Destination Airport"; Code[50])
        {
        }
        field(16; "Effective Start Date"; Date)
        {
        }
        field(17; "Effective End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Flight Code", "Item No.", "Freight Charge Code", "From Weight", "To Weight", "Source airport", "Destination Airport", "Effective Start Date", "Effective End Date")
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
        Text000: Label 'To Weight cannot be less than From Weight';
}

