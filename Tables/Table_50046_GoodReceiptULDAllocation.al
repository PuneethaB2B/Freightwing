table 50046 "Good Receipt ULD Allocation"
{

    fields
    {
        field(1; "Good Receipt No."; Code[20])
        {
            //TableRelation = Table50096.Field1; //B2BUPG due to Table 50096 is not found in client db
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
        }
        field(7; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(8; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No.";
        }
        field(9; Remarks; Text[30])
        {
        }
        field(10; "Line No"; Integer)
        {
        }
        field(11; "FWL Docket Weight"; Decimal)
        {
        }
        field(12; "MAWB No"; Code[50])
        {
            // TableRelation = Table50096.Field27;  //B2BUPG due to Table 50096 is not found in client db
        }
    }

    keys
    {
        key(Key1; "Good Receipt No.", "Airline Code", "Flight Code", "Shipper Code", "Item No.", "ULD Type Code", "Line No")
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

