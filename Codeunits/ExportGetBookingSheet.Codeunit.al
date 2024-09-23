codeunit 50010 "Export.-Get Booking Sheet"
{
    TableNo = 50051;

    trigger OnRun()
    begin
        GoodReceiptHeader.GET("Good Receipt No.");
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
        GoodReceiptHeader: Record "50052";
        GoodReceiptLine: Record "50051";
        BookingSheetHeader: Record "50053";
        BookingSheetLine: Record "50054";
        GetBookingSheetLines: Page "50133";

    [Scope('Internal')]
    procedure CreateGoodsReceiptLines(var BookingSheetLine2: Record "50054")
    var
        TransferLine: Boolean;
    begin
        WITH BookingSheetLine2 DO BEGIN
            IF FIND('-') THEN BEGIN
                GoodReceiptLine.LOCKTABLE;
                GoodReceiptLine.SETRANGE("Good Receipt No.", GoodReceiptHeader."No.");
                GoodReceiptLine."Good Receipt No." := GoodReceiptHeader."No.";
                REPEAT
                    TransferLine := TRUE;
                    IF TransferLine THEN BEGIN
                        BookingSheetLine := BookingSheetLine2;
                        BookingSheetLine.InsertGoodsReceiptFromBookingSheetLine(GoodReceiptLine);
                    END;
                UNTIL NEXT = 0;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure SetGoodsReceiptHeader(var GoodReceiptHeader2: Record "50052")
    begin
        GoodReceiptHeader.GET(GoodReceiptHeader2."No.");
    end;
}

