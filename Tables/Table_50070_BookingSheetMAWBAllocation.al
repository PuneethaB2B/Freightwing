table 50070 "Booking Sheet MAWB Allocation"
{

    fields
    {
        field(1; "Booking Sheet No"; Code[50])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Item No"; Code[50])
        {
            TableRelation = Item."No.";
        }
        field(4; "MAWB No"; Code[50])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE("Airline Code" = FIELD("Airline Code"),
                                                             Prepared = FILTER(false));
        }
        field(5; "Weight Allocated"; Decimal)
        {
            CalcFormula = Sum("Booking Sheet HAWB Allocation"."Gross Weight" WHERE("Booking Sheet No." = FIELD("Booking Sheet No"),
                                                                                    "Airline Code" = FIELD("Airline Code"),
                                                                                    "MAWB No." = FIELD("MAWB No"),
                                                                                    "Shipper Code" = FIELD("Shipper Code"),
                                                                                    "Source Airport" = FIELD("Source Airport"),
                                                                                    "Destination Airport" = FIELD("Destination Airport")));
            FieldClass = FlowField;
        }
        field(6; "Flight No"; Code[50])
        {
            TableRelation = Flight."Flight No.";
        }
        field(7; "Airline Code"; Code[50])
        {
            TableRelation = Airline.Code;
        }
        field(8; "Source Airport"; Code[50])
        {
        }
        field(9; "Destination Airport"; Code[50])
        {
        }
        field(10; "Consignee Code"; Code[10])
        {
            TableRelation = Table50091.Field2 WHERE(Field1 = FIELD("Shipper Code"));

            trigger OnValidate()
            begin
                Consignee.GET("Consignee Code");
                "Consignee Name" := Consignee.Name;
            end;
        }
        field(11; "Consignee Name"; Text[50])
        {
            Editable = false;
        }
        field(12; "Shipper Code"; Code[50])
        {
        }
        field(13; BSA; Boolean)
        {
        }
        field(14; Houses; Boolean)
        {
        }
        field(15; Invoiced; Boolean)
        {
        }
        field(16; Comment; Text[250])
        {
        }
        field(17; "MAWB Received"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Booking Sheet No", "Line No.", "Item No", "MAWB No", "Airline Code", "Flight No", "Source Airport", "Destination Airport", "Shipper Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        BookingSheetHAWBAllocation.RESET;
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Booking Sheet No.", "Booking Sheet No");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Airline Code", "Airline Code");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Flight Code", "Flight No");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Shipper Code", "Shipper Code");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Item No.", "Item No");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Consignee Code", "Consignee Code");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Source Airport", "Source Airport");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."Destination Airport", "Destination Airport");
        BookingSheetHAWBAllocation.SETRANGE(BookingSheetHAWBAllocation."MAWB No.", "MAWB No");
        IF BookingSheetHAWBAllocation.FINDFIRST THEN
            BookingSheetHAWBAllocation.DELETEALL;
    end;

    var
        BookingSheetLine: Record "Booking Sheet Line";
        BkSheetMAWB: Record "Booking Sheet MAWB Allocation";
        TotalWeightLine: Decimal;
        TotalAllocatedWEight: Decimal;
        Flights: Record Flight;
        Consignee: Record Consignee;
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
}

