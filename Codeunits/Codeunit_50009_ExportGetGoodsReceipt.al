codeunit 50009 "Export.-Get Goods Receipt"
{
    TableNo = "Loading Sheet Line";

    trigger OnRun()
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", Rec."Loading Sheet No.");
        IF LoadingSheetHeader.FINDFIRST THEN BEGIN
            GoodReceiptLine.SETRANGE(GoodReceiptLine."Shipper Code", LoadingSheetHeader."Shipper Code");
            GoodReceiptLine.SETRANGE(GoodReceiptLine."MAWB No.", LoadingSheetHeader."MAWB No.");
            GoodReceiptLine.SETFILTER(GoodReceiptLine.Status, '%1|%2', GoodReceiptLine.Status::Received, GoodReceiptLine.Status::"Shipped Part");
            GoodReceiptLine.SETFILTER("Loading Sheet No.", '%1', '');
            GetGoodReceiptLines.SETTABLEVIEW(GoodReceiptLine);
            GetGoodReceiptLines.LOOKUPMODE := TRUE;
            GetGoodReceiptLines.SetLoadingSheetHeader(LoadingSheetHeader);
            GetGoodReceiptLines.RUNMODAL;
        END;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        GoodReceiptHeader: Record "Good Receipt Header";
        GoodReceiptLine: Record "Good Receipt Line";
        LoadingSheetHeader: Record "Loading Sheet Header";
        LoadingSheetLine: Record "Loading Sheet Line";
        GetGoodReceiptLines: Page "Get Goods Receipt Lines";


    procedure CreateLoadingSheetLines(var GoodReceiptLine2: Record "Good Receipt Line")
    var
        TransferLine: Boolean;
    begin
        IF GoodReceiptLine2.FIND('-') THEN BEGIN
            LoadingSheetLine.LOCKTABLE;
            LoadingSheetLine.SETRANGE("Loading Sheet No.", LoadingSheetHeader."No.");
            LoadingSheetLine."Loading Sheet No." := LoadingSheetHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    GoodReceiptLine := GoodReceiptLine2;
                    GoodReceiptLine.InsertLoadingSheetFromGoodReceiptLine(LoadingSheetLine);
                END;
            UNTIL GoodReceiptLine2.NEXT = 0;
        END;
    end;


    procedure SetLoadingSheetHeader(var LoadingSheetHeader2: Record "Loading Sheet Header")
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", LoadingSheetHeader2."No.");
        IF LoadingSheetHeader.FINDFIRST THEN BEGIN END;
        ;
    end;
}

