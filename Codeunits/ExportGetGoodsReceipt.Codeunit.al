codeunit 50009 "Export.-Get Goods Receipt"
{
    TableNo = 50061;

    trigger OnRun()
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", "Loading Sheet No.");
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
        GoodReceiptHeader: Record "50052";
        GoodReceiptLine: Record "50051";
        LoadingSheetHeader: Record "50060";
        LoadingSheetLine: Record "50061";
        GetGoodReceiptLines: Page "50084";

    [Scope('Internal')]
    procedure CreateLoadingSheetLines(var GoodReceiptLine2: Record "50051")
    var
        TransferLine: Boolean;
    begin
        WITH GoodReceiptLine2 DO BEGIN
            IF FIND('-') THEN BEGIN
                LoadingSheetLine.LOCKTABLE;
                LoadingSheetLine.SETRANGE("Loading Sheet No.", LoadingSheetHeader."No.");
                LoadingSheetLine."Loading Sheet No." := LoadingSheetHeader."No.";
                REPEAT
                    TransferLine := TRUE;
                    IF TransferLine THEN BEGIN
                        GoodReceiptLine := GoodReceiptLine2;
                        GoodReceiptLine.InsertLoadingSheetFromGoodReceiptLine(LoadingSheetLine);
                    END;
                UNTIL NEXT = 0;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure SetLoadingSheetHeader(var LoadingSheetHeader2: Record "50060")
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", LoadingSheetHeader2."No.");
        IF LoadingSheetHeader.FINDFIRST THEN BEGIN END;
        ;
    end;
}

