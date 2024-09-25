table 50055 "Booking Sheet ULD Allocation"
{

    fields
    {
        field(1; "Booking Sheet No."; Code[20])
        {
            TableRelation = "Booking Sheet Line"."Booking Sheet No.";
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
        field(10; "MAVB No."; Code[50])
        {
            TableRelation = "Booking Sheet HAWB Allocation"."MAWB No." WHERE ("Booking Sheet No."=FIELD("Booking Sheet No."),
                                                                              "Airline Code"=FIELD("Airline Code"),
                                                                              "Shipper Code"=FIELD("Shipper Code"));
        }
        field(11;"Source Airport";Code[50])
        {
        }
        field(12;"Destination Airport";Code[50])
        {
        }
        field(13;Consignee;Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Booking Sheet No.","Airline Code","Flight Code","Shipper Code","Item No.","ULD Type Code","Destination Airport","Source Airport","MAVB No.",Consignee)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

