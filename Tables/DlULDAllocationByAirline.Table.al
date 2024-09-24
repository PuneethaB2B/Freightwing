table 50044 "Dl. ULD Allocation By Airline"
{

    fields
    {
        field(1; "Daily No."; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Airline"."Daily No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Airline"."Airline Code";
        }
        field(3; "ULD Type"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; Remarks; Text[30])
        {
        }
        field(6; Flight; Code[10])
        {
            TableRelation = Flight."Flight No." WHERE ("Airline Code"=FIELD("Airline Code"));
        }
        field(7;"Destination Airport";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Daily No.","Airline Code","ULD Type",Flight,"Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

