codeunit 50007 "Export.-Get BS HAWB Item"
{
    TableNo = "HAWB Line";

    trigger OnRun()
    begin
        HAWBHeader.GET(Rec."HAWB No.");

        BookingSheetHAWBAllocation.SETRANGE("HAWB No.", HAWBHeader."No.");
        BookingSheetHAWBAllocation.SETRANGE("HAWB Prepared", FALSE);
        GetHAWBItemLines.SETTABLEVIEW(BookingSheetHAWBAllocation);
        GetHAWBItemLines.LOOKUPMODE := TRUE;
        GetHAWBItemLines.SetHAWBHeader(HAWBHeader);
        GetHAWBItemLines.RUNMODAL;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        HAWBHeader: Record "HAWB Header";
        HAWBLine: Record "HAWB Line";
        BookingSheetHeader: Record "Booking Sheet Header";
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        GetHAWBItemLines: Page "Get HAWB Item Lines";


    procedure CreateHAWBLines(var BookingSheetHAWBAllocation2: Record "Booking Sheet HAWB Allocation")
    var
        TransferLine: Boolean;
    begin
        IF BookingSheetHAWBAllocation2.FIND('-') THEN BEGIN
            HAWBLine.LOCKTABLE;
            HAWBLine.SETRANGE("HAWB No.", HAWBHeader."No.");
            HAWBLine."HAWB No." := HAWBHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    BookingSheetHAWBAllocation := BookingSheetHAWBAllocation2;
                    BookingSheetHAWBAllocation.InsertHAWBFromBookingSheetHAWBItem(HAWBLine);
                END;
            UNTIL BookingSheetHAWBAllocation2.NEXT = 0;
        END;
    end;


    procedure SetHAWBHeader(var HAWBHeader2: Record "HAWB Header")
    begin
        HAWBHeader.GET(HAWBHeader2."No.");
    end;
}

