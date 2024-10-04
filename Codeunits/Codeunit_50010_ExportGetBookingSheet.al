codeunit 50010 "Export.-Get Booking Sheet"
{
    TableNo = "Good Receipt Line";

    trigger OnRun()
    begin
        GoodReceiptHeader.GET(Rec."Good Receipt No.");
        BookingSheetHeader.RESET;
        BookingSheetHeader.SETRANGE(BookingSheetHeader."Booking Date", GoodReceiptHeader."Receipt Date");
        BookingSheetHeader.SETRANGE(BookingSheetHeader."Shipper Code", GoodReceiptHeader."Shipper Code");
        BookingSheetHeader.SETRANGE(BookingSheetHeader.Status, BookingSheetHeader.Status::Submitted);
        IF BookingSheetHeader.FINDFIRST THEN BEGIN
            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", BookingSheetHeader."No.");
            BookingSheetLine.SETRANGE(BookingSheetLine."Shipper Code", GoodReceiptHeader."Shipper Code");
            BookingSheetLine.SETFILTER("Good Receipt No.", '%1', '');

            GetBookingSheetLines.SETTABLEVIEW(BookingSheetLine);
            GetBookingSheetLines.LOOKUPMODE := TRUE;
            GetBookingSheetLines.SetGoodReceiptHeader(GoodReceiptHeader);
            GetBookingSheetLines.RUNMODAL;
        END;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        GoodReceiptHeader: Record "Good Receipt Header";
        GoodReceiptLine: Record "Good Receipt Line";
        BookingSheetHeader: Record "Booking Sheet Header";
        BookingSheetLine: Record "Booking Sheet Line";
        GetBookingSheetLines: Page "Get Booking Sheet Lines";


    procedure CreateGoodsReceiptLines(var BookingSheetLine2: Record "Booking Sheet Line")
    var
        TransferLine: Boolean;
    begin
        IF BookingSheetLine2.FIND('-') THEN BEGIN
            GoodReceiptLine.LOCKTABLE;
            GoodReceiptLine.SETRANGE("Good Receipt No.", GoodReceiptHeader."No.");
            GoodReceiptLine."Good Receipt No." := GoodReceiptHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    BookingSheetLine := BookingSheetLine2;
                    BookingSheetLine.InsertGoodsReceiptFromBookingSheetLine(GoodReceiptLine);
                END;
            UNTIL BookingSheetLine2.NEXT = 0;
        END;
    end;


    procedure SetGoodsReceiptHeader(var GoodReceiptHeader2: Record "Good Receipt Header")
    begin
        GoodReceiptHeader.GET(GoodReceiptHeader2."No.");
    end;
}

