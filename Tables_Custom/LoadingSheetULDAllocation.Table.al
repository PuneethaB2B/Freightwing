table 50063 "Loading Sheet ULD Allocation"
{

    fields
    {
        field(1; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Line"."Loading Sheet No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Airline Code";
        }
        field(3; "ULD Type Code"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; "Item No."; Code[10])
        {
            TableRelation = "Loading Sheet Line"."Item No.";
        }
        field(6; "ULD No."; Code[100])
        {
        }
        field(7; Remarks; Text[30])
        {
        }
        field(8; "Line No"; Integer)
        {
        }
        field(9; "FWL Docket Weight"; Decimal)
        {
        }
        field(10; "MWAB No."; Code[50])
        {
            TableRelation = "Loading Sheet Line"."MAWB No.";
        }
        field(11; "FWL Docket No."; Code[50])
        {
        }
        field(12; FAM; Code[50])
        {
        }
        field(13; "No. Of Boxes"; Decimal)
        {
        }
        field(14; Released; Boolean)
        {
        }
        field(15; "Airline Docket Weight"; Decimal)
        {
        }
        field(16; Dimension; Decimal)
        {
        }
        field(17; Consignee; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Loading Sheet No.", "Airline Code", "Item No.", "ULD Type Code", "ULD No.", "Line No", "MWAB No.", FAM, Consignee)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Quantity := 1;
    end;
}

