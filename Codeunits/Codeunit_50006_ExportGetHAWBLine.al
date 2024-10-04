codeunit 50006 "Export.-Get HAWB Line"
{
    TableNo = "MAWB Line";

    trigger OnRun()
    begin
        MAWBHeader.GET(Rec."MAWB No.");

        HAWBLine.SETRANGE("MAWB No.", MAWBHeader."No.");
        HAWBLine.SETRANGE("MAWB Prepared", FALSE);
        GetHAWBAllocationLines.SETTABLEVIEW(HAWBLine);
        GetHAWBAllocationLines.LOOKUPMODE := TRUE;
        GetHAWBAllocationLines.SetMAWBHeader(MAWBHeader);
        GetHAWBAllocationLines.RUNMODAL;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        MAWBHeader: Record "MAWB Header 2";
        MAWBLine: Record "MAWB Line";
        BookingSheetHeader: Record "Booking Sheet Header";
        HAWBLine: Record "HAWB Line";
        GetHAWBAllocationLines: Page "Get HAWB Lines";


    procedure CreateMAWBLines(var HAWBLine2: Record "HAWB Line")
    var
        TransferLine: Boolean;
    begin
        IF HAWBLine2.FIND('-') THEN BEGIN
            MAWBLine.LOCKTABLE;
            MAWBLine.SETRANGE("MAWB No.", MAWBHeader."No.");
            MAWBLine."MAWB No." := MAWBHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    HAWBLine := HAWBLine2;
                    HAWBLine.InsertMAWBFromHAWBLine(MAWBLine);

                END;
            UNTIL HAWBLine2.NEXT = 0;
        END;
    end;


    procedure SetMAWBHeader(var MAWBHeader2: Record "MAWB Header 2")
    begin
        MAWBHeader.GET(MAWBHeader2."No.");
    end;
}

