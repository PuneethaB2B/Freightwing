codeunit 50008 "Export.-Get MAWB Line"
{
    TableNo = "Sales Line";

    trigger OnRun()
    begin
        SalesHeader.GET(Rec."Document Type", Rec."Document No.");
        MAWBLine.SETRANGE("MAWB No.", SalesHeader."MAWB No.");
        MAWBLine.SETRANGE("Shipper Code", SalesHeader."Sell-to Customer No.");
        MAWBLine.SETFILTER("Invoice No.", '%1', '');
        GetSplitMAWBLines.SETTABLEVIEW(MAWBLine);
        GetSplitMAWBLines.LOOKUPMODE := TRUE;
        GetSplitMAWBLines.SetSalesHeader(SalesHeader);
        GetSplitMAWBLines.RUNMODAL;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        BookingSheetHeader: Record "Booking Sheet Header";
        MAWBLine: Record "MAWB Line";
        GetSplitMAWBLines: Page "Get MAWB Lines";


    procedure CreateSalesInvoiceLines(var MAWBLine2: Record "MAWB Line")
    var
        TransferLine: Boolean;
    begin
        IF MAWBLine2.FIND('-') THEN BEGIN
            SalesLine.LOCKTABLE;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Document Type" := SalesHeader."Document Type";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    MAWBLine := MAWBLine2;
                    MAWBLine.InsertSalesInvoiceFromMAWBLine(SalesLine);
                END;
            UNTIL MAWBLine2.NEXT = 0;
        END;
    end;


    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
    begin
        SalesHeader.GET(SalesHeader2."Document Type", SalesHeader2."No.");
    end;
}

