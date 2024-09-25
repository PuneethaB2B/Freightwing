table 50043 "Dl. Weight Dist. By Item"
{

    fields
    {
        field(1; "Daily No."; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Customer"."Daily No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Customer"."Airline Code";
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Customer"."Customer No.";
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = "Shipper Item"."Item No." WHERE("Shipper Code" = FIELD("Customer No."));

            trigger OnValidate()
            begin
                DailyWeightDistByCustomer.RESET;
                DailyWeightDistByCustomer.SETRANGE("Daily No.", "Daily No.");
                DailyWeightDistByCustomer.SETRANGE("Airline Code", "Airline Code");
                DailyWeightDistByCustomer.SETRANGE("Destination Code", "Destination Code");
                DailyWeightDistByCustomer.SETRANGE("Flight Code", "Flight Code");
                DailyWeightDistByCustomer.SETRANGE("Customer No.", "Customer No.");
                IF DailyWeightDistByCustomer.FINDFIRST THEN BEGIN
                    DailyWeightDistByCustomer.TESTFIELD("Customer No.");

                    "Distribution Date" := DailyWeightDistByCustomer."Distribution Date";
                    "Day of Week" := DailyWeightDistByCustomer."Day of Week";

                END;

                Item.GET("Item No.");
                "Unit of Measure" := Item."Base Unit of Measure";
                Description := Item.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(6; "Gross Weight"; Decimal)
        {
        }
        field(7; "Distribution Date"; Date)
        {
        }
        field(8; "Booking Sheet No."; Code[20])
        {
        }
        field(9; "Unit of Measure"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(10; "Destination Code"; Code[20])
        {
            Editable = true;
            TableRelation = "Dl. Weight Dist. By Customer"."Destination Code";
        }
        field(11; "Day of Week"; Option)
        {
            Editable = true;
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
            TableRelation = "Dl. Weight Dist. By Customer"."Day of Week";
        }
        field(12; "Flight Code"; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Customer"."Flight Code";
        }
        field(13; "Destination Airport"; Code[50])
        {
            Editable = true;
        }
        field(14; "Shipped Weight"; Decimal)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Daily No.", "Airline Code", "Flight Code", "Destination Code", "Customer No.", "Item No.", "Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        OrderBookingHeader: Record 50053;
        Day: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        WeekDay: Text;
        FreightChargeByAirline: Record 50025;
        FreightChargeByFlight: Record 50026;
        FreightChargeByItem: Record 50027;
        FreightItemCharge: Record 50028;
        FreightItemChargeMatrix: Record 50029;
        Text001: Label 'The %1 is not within the Freight Charge Effective Dates';
        DailyWeightDistByAirline: Record 50041;
        DailyWeightDistByCustomer: Record 50042;
        DailyWeightDistHeader: Record 50040;
        Item: Record 27;
        DailyULDAllocationByAirline: Record 50044;
        BookingSheetULDAllocation: Record 50055;
        DayofWeek: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        BookingSheetNotifyParty: Record 50057;
        NotifyParty: Record 50017;
        NotifyPartyLineNo: Integer;
        DlWeightDistByCust: Record 50042;
        Airports: Record 50019;


    procedure InsertOrderBookingLineFromDailyWeightDistByItem(var OrderBookingLine: Record 50054)
    var
        OrderBookingHeader: Record 50053;
        OrderBookingOrderHeader: Record 50053;
        OrderBookingOrderLine: Record 50054;
        TempOrderBookingLine: Record 50054;
        PurchSetup: Record 312;
        TransferOldExtLines: Codeunit 379;
        ItemTrackingMgt: Codeunit 6500;
        NextLineNo: Integer;
        ExtTextLine: Boolean;
    begin
        SETRANGE("Customer No.", "Customer No.");
        SETRANGE("Item No.", "Item No.");
        SETRANGE("Distribution Date", OrderBookingLine."Booking Date");
        TempOrderBookingLine := OrderBookingLine;
        IF OrderBookingLine.FIND('+') THEN
            NextLineNo := OrderBookingLine."Line No." + 1000
        ELSE
            NextLineNo := 1000;
        REPEAT
            OrderBookingOrderLine.INIT;
            OrderBookingOrderLine."Line No." := OrderBookingOrderLine."Line No.";
            OrderBookingOrderLine.Description := Description;
            OrderBookingLine := OrderBookingOrderLine;
            OrderBookingLine."Line No." := NextLineNo;
            OrderBookingLine."Booking Sheet No." := TempOrderBookingLine."Booking Sheet No.";
            OrderBookingLine.Type := OrderBookingLine.Type::Item;
            OrderBookingLine."Item No." := "Item No.";
            OrderBookingLine.Description := Description;
            OrderBookingLine."Booked Weight" := "Gross Weight";
            OrderBookingLine."Unit of Measure Code" := "Unit of Measure";
            OrderBookingLine."Shipper Code" := "Customer No.";
            OrderBookingHeader.GET(TempOrderBookingLine."Booking Sheet No.");
            OrderBookingLine."Booking Date" := OrderBookingHeader."Booking Date";

            DailyWeightDistByAirline.RESET;
            DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Daily No.", "Daily No.");
            DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Airline Code", "Airline Code");
            DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Flight Code", "Flight Code");
            DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Destination Airport", "Destination Airport");
            IF DailyWeightDistByAirline.FINDFIRST THEN BEGIN
                OrderBookingLine."Destination Code" := DailyWeightDistByAirline."Destination Code";
                OrderBookingLine."Airline Code" := DailyWeightDistByAirline."Airline Code";
                OrderBookingLine."Flight Code" := DailyWeightDistByAirline."Flight Code";
                OrderBookingLine."Cut-off Time" := DailyWeightDistByAirline."Cut-off Time";
                OrderBookingLine."Destination Airport" := DailyWeightDistByAirline."Destination Airport";
                OrderBookingLine."Source Airport" := DailyWeightDistByAirline."Source Airport";
                OrderBookingLine."Source Code" := DailyWeightDistByAirline."Source Code";

                DailyULDAllocationByAirline.RESET;
                DailyULDAllocationByAirline.SETRANGE(DailyULDAllocationByAirline."Daily No.", DailyWeightDistByAirline."Daily No.");
                DailyULDAllocationByAirline.SETRANGE(DailyULDAllocationByAirline."Airline Code", DailyWeightDistByAirline."Airline Code");
                DailyULDAllocationByAirline.SETRANGE(DailyULDAllocationByAirline.Flight, DailyULDAllocationByAirline.Flight);
                IF DailyULDAllocationByAirline.FINDSET THEN BEGIN
                    REPEAT
                        BookingSheetULDAllocation."Booking Sheet No." := TempOrderBookingLine."Booking Sheet No.";
                        BookingSheetULDAllocation."Airline Code" := DailyWeightDistByAirline."Airline Code";
                        BookingSheetULDAllocation."Flight Code" := DailyULDAllocationByAirline.Flight;
                        BookingSheetULDAllocation."Shipper Code" := "Customer No.";
                        BookingSheetULDAllocation."Item No." := "Item No.";
                        BookingSheetULDAllocation."ULD Type Code" := DailyULDAllocationByAirline."ULD Type";
                        BookingSheetULDAllocation.Quantity := DailyULDAllocationByAirline.Quantity;
                        BookingSheetULDAllocation.Remarks := DailyULDAllocationByAirline.Remarks;
                        BookingSheetULDAllocation."Source Airport" := DailyWeightDistByAirline."Source Airport";
                        BookingSheetULDAllocation."Destination Airport" := DailyWeightDistByAirline."Destination Airport";
                        //OrderBookingLine."Destination Airport";
                        BookingSheetULDAllocation.INSERT;
                    UNTIL DailyULDAllocationByAirline.NEXT = 0;
                END;
            END;

            BookingSheetNotifyParty.RESET;
            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Booking Sheet No.", OrderBookingLine."Booking Sheet No.");
            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Item No.", OrderBookingLine."Item No.");
            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Shipper Code", OrderBookingLine."Shipper Code");
            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Airline Code", OrderBookingLine."Airline Code");
            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Flight Code", OrderBookingLine."Flight Code");
            IF BookingSheetNotifyParty.FIND('-') THEN BEGIN
                NotifyPartyLineNo := BookingSheetNotifyParty."Line No" + 1000;
                BookingSheetNotifyParty."Booking Sheet No." := TempOrderBookingLine."Booking Sheet No.";
                BookingSheetNotifyParty."Airline Code" := "Airline Code";
                BookingSheetNotifyParty."Flight Code" := "Flight Code";
                BookingSheetNotifyParty."Shipper Code" := "Customer No.";
                BookingSheetNotifyParty."Item No." := "Item No.";
                BookingSheetNotifyParty."Line No" := NotifyPartyLineNo;

                NotifyParty.RESET;
                NotifyParty.SETRANGE(Type, NotifyParty.Type::Shipper);
                NotifyParty.SETRANGE("Type Code", "Customer No.");
                IF NotifyParty.FINDFIRST THEN BEGIN
                    BookingSheetNotifyParty."Notify-Party No." := NotifyParty."No.";
                    BookingSheetNotifyParty."Notify-Party Name" := NotifyParty.Name;
                    BookingSheetNotifyParty."Source Type" := BookingSheetNotifyParty."Source Type"::Shipper;
                END;
                BookingSheetNotifyParty.INSERT;

                NotifyParty.RESET;
                NotifyParty.SETRANGE(NotifyParty.Type, NotifyParty.Type::Operations);
                IF NotifyParty.FINDSET THEN BEGIN
                    REPEAT
                        BookingSheetNotifyParty."Notify-Party No." := NotifyParty."No.";
                        BookingSheetNotifyParty."Notify-Party Name" := NotifyParty.Name;
                        BookingSheetNotifyParty."Source Type" := BookingSheetNotifyParty."Source Type"::Operations;
                        BookingSheetNotifyParty.INSERT;

                    UNTIL NotifyParty.NEXT = 0;
                END;
            END;
            "Booking Sheet No." := TempOrderBookingLine."Booking Sheet No.";
            MODIFY;

            OrderBookingLine.INSERT;
            NextLineNo := NextLineNo + 10000;

        UNTIL (NEXT = 0);
    end;
}

