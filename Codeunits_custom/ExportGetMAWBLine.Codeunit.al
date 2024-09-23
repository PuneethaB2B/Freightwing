codeunit 50008 "Export.-Get MAWB Line"
{
    TableNo = 37;

    trigger OnRun()
    begin
        SalesHeader.GET("Document Type", "Document No.");
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
        SalesHeader: Record "36";
        SalesLine: Record "37";
        BookingSheetHeader: Record "50053";
        MAWBLine: Record "50076";
        GetSplitMAWBLines: Page "50121";

    [Scope('Internal')]
    procedure CreateSalesInvoiceLines(var MAWBLine2: Record "50076")
    var
        TransferLine: Boolean;
    begin
        WITH MAWBLine2 DO BEGIN
            IF FIND('-') THEN BEGIN
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
                UNTIL NEXT = 0;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure SetSalesHeader(var SalesHeader2: Record "36")
    begin
        SalesHeader.GET(SalesHeader2."Document Type", SalesHeader2."No.");
    end;
}

