codeunit 50007 "Export.-Get BS HAWB Item"
{
    TableNo = 50074;

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
        HAWBHeader: Record "50075";
        HAWBLine: Record "50074";
        BookingSheetHeader: Record "50053";
        BookingSheetHAWBAllocation: Record "50056";
        GetHAWBItemLines: Page "50109";


    procedure CreateHAWBLines(var BookingSheetHAWBAllocation2: Record "50056")
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


    procedure SetHAWBHeader(var HAWBHeader2: Record "50075")
    begin
        HAWBHeader.GET(HAWBHeader2."No.");
    end;
}

