codeunit 50004 "Export.-Get Distribution"
{
    TableNo = 50054;

    trigger OnRun()
    begin
        OrderBookingHeader.GET(Rec."Booking Sheet No.");

        DailyWeightDistByItem.SETRANGE("Customer No.", OrderBookingHeader."Shipper Code");
        DailyWeightDistByItem.SETRANGE("Distribution Date", OrderBookingHeader."Booking Date");
        DailyWeightDistByItem.SETFILTER("Booking Sheet No.", '%1', '');
        GetOrderBooking.SETTABLEVIEW(DailyWeightDistByItem);
        GetOrderBooking.LOOKUPMODE := TRUE;
        GetOrderBooking.SetOrderBookingHeader(OrderBookingHeader);
        GetOrderBooking.RUNMODAL;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        OrderBookingHeader: Record "50053";
        OrderBookingLine: Record "50054";
        DailyWeightDistHeader: Record "50040";
        DailyWeightDistByItem: Record "50043";
        GetOrderBooking: Page "50070";
        DailyWeightDistByAirline: Record "50041";
        DailyWeightDistByCustomer: Record "50042";


    procedure CreateOrderBookingLines(var DailyWeightDistByItem2: Record "50043")
    var
        TransferLine: Boolean;
    begin

        IF DailyWeightDistByItem2.FIND('-') THEN BEGIN
            OrderBookingLine.LOCKTABLE;
            OrderBookingLine.SETRANGE("Booking Sheet No.", OrderBookingHeader."No.");
            OrderBookingLine."Booking Sheet No." := OrderBookingHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    DailyWeightDistByItem := DailyWeightDistByItem2;
                    DailyWeightDistByItem.InsertOrderBookingLineFromDailyWeightDistByItem(OrderBookingLine);
                END;
            UNTIL DailyWeightDistByItem2.NEXT = 0;
        END;
    end;


    procedure SetOrderBookingHeader(var OrderBookingHeader2: Record "50053")
    begin
        OrderBookingHeader.GET(OrderBookingHeader2."No.");
    end;
}

