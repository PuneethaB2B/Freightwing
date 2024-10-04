codeunit 50004 "Export.-Get Distribution"
{
    TableNo = "Booking Sheet Line";

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
        OrderBookingHeader: Record "Booking Sheet Header";
        OrderBookingLine: Record "Booking Sheet Line";
        DailyWeightDistHeader: Record "Dl. Weight Dist. Header";
        DailyWeightDistByItem: Record "Dl. Weight Dist. By Item";
        GetOrderBooking: Page "Get Distribution Lines";
        DailyWeightDistByAirline: Record "Dl. Weight Dist. By Airline";
        DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer";


    procedure CreateOrderBookingLines(var DailyWeightDistByItem2: Record "Dl. Weight Dist. By Item")
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


    procedure SetOrderBookingHeader(var OrderBookingHeader2: Record "Booking Sheet Header")
    begin
        OrderBookingHeader.GET(OrderBookingHeader2."No.");
    end;
}

