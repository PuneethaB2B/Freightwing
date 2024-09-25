table 50079 "Booking Sheet Opr Report Temp"
{

    fields
    {
        field(1; SNo; Integer)
        {
        }
        field(2; "Booking Date"; Date)
        {
        }
        field(3; "Mawb No"; Code[50])
        {
        }
        field(4; "Shipper Code"; Code[30])
        {
        }
        field(5; "HAWB No"; Code[50])
        {
        }
        field(6; "Booked Weight"; Decimal)
        {
        }
        field(7; "Flight No"; Code[30])
        {
        }
        field(8; "Destination Airport"; Code[30])
        {
        }
        field(9; "Departure Time"; Time)
        {
        }
        field(10; "Cut off Time"; Time)
        {
        }
        field(11; "ULD Allocation"; Code[30])
        {
        }
        field(12; "Consignee Code"; Code[30])
        {
        }
        field(13; "Type of Delivery"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; SNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

