table 50058 "Booking Sheet FAM Allocations"
{

    fields
    {
        field(1; "Booking Sheet No"; Code[50])
        {
            TableRelation = "Booking Sheet Line"."Booking Sheet No.";
        }
        field(2; "Shipper Code"; Code[50])
        {
            TableRelation = "Booking Sheet Line"."Shipper Code";
        }
        field(3; "Farm Code"; Code[50])
        {
            TableRelation = "Shipper Farm"."Farm Code" WHERE ("Shipper Code"=FIELD("Shipper Code"));

            trigger OnValidate()
            begin
                ShipperFarm.RESET;
                ShipperFarm.SETRANGE(ShipperFarm."Shipper Code", "Shipper Code");
                ShipperFarm.SETRANGE(ShipperFarm."Farm Code", "Farm Code");
                IF ShipperFarm.FINDFIRST THEN BEGIN
                    "FAM Name" := ShipperFarm.Description;

                END;
                Shipper.RESET;
                Shipper.SETRANGE(Shipper."Shipper Code", "Shipper Code");
                IF Shipper.FINDFIRST THEN
                    "Shipper Name" := Shipper."Agent Name";
            end;
        }
        field(4; "Shipper Name"; Text[50])
        {
        }
        field(5; "FAM Name"; Text[50])
        {
        }
        field(6; Weight; Decimal)
        {
        }
        field(7; "Item No"; Code[50])
        {
            TableRelation = "Booking Sheet Line"."Item No." WHERE("Booking Sheet No." = FIELD("Booking Sheet No"));
        }
        field(8; "Line No"; Integer)
        {
        }
        field(9; "Airline Code"; Code[10])
        {
        }
        field(10; "Flight Code"; Code[10])
        {
        }
        field(11; "Source Airport"; Code[10])
        {
        }
        field(12; "Destination Airport"; Code[10])
        {
        }
        field(13; "MAWB No"; Code[30])
        {
        }
        field(14; "Consignee Code"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Booking Sheet No", "Item No", "Shipper Code", "Farm Code", "Source Airport", "Destination Airport", "Flight Code", "Airline Code", "MAWB No", "Consignee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ShipperFarm: Record 50014;
        Shipper: Record 50011;
        famAlloc: Record 50058;
}

