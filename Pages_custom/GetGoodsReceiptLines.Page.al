page 50084 "Get Goods Receipt Lines"
{
    PageType = List;
    SourceTable = Table50051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Good Receipt No."; "Good Receipt No.")
                {
                    HideValue = "GoodReceiptNo.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Booked Weight"; "Booked Weight")
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Weight Difference"; "Weight Difference")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "GoodReceiptNo.HideValue" := FALSE;
        GoodReceiptNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        LoadingSheetHeader: Record "50060";
        TempGoodReceiptLine: Record "50051" temporary;
        ExportGetGoodsReceipt: Codeunit "50009";
        [InDataSet]
        "GoodReceiptNo.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        GoodReceiptLine: Record "50051";
    begin
        TempGoodReceiptLine.RESET;
        TempGoodReceiptLine.COPYFILTERS(Rec);
        TempGoodReceiptLine.SETRANGE("Good Receipt No.", "Good Receipt No.");
        IF NOT TempGoodReceiptLine.FINDFIRST THEN BEGIN
            GoodReceiptLine.COPYFILTERS(Rec);
            GoodReceiptLine.SETRANGE("Good Receipt No.", "Good Receipt No.");
            IF GoodReceiptLine.FINDFIRST THEN BEGIN
                TempGoodReceiptLine := GoodReceiptLine;
                TempGoodReceiptLine.INSERT;
            END;
        END;
        IF "Line No." = TempGoodReceiptLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure GoodReceiptNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "GoodReceiptNo.HideValue" := TRUE;
    end;

    [Scope('Internal')]
    procedure SetLoadingSheetHeader(var LoadingSheetHeader2: Record "50060")
    begin
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", LoadingSheetHeader2."No.");
        IF LoadingSheetHeader.FINDFIRST THEN BEGIN END;
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        ExportGetGoodsReceipt.SetLoadingSheetHeader(LoadingSheetHeader);
        ExportGetGoodsReceipt.CreateLoadingSheetLines(Rec);
    end;
}

