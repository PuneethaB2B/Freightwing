page 50084 "Get Goods Receipt Lines"
{
    PageType = List;
    SourceTable = "Good Receipt Line";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Good Receipt No."; Rec."Good Receipt No.")
                {
                    HideValue = "GoodReceiptNo.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Booked Weight"; Rec."Booked Weight")
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
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
        LoadingSheetHeader: Record "Loading Sheet Header";
        TempGoodReceiptLine: Record "Good Receipt Line" temporary;
        ExportGetGoodsReceipt: Codeunit "Export.-Get Goods Receipt";

        "GoodReceiptNo.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        GoodReceiptLine: Record "Good Receipt Line";
    begin
        TempGoodReceiptLine.RESET;
        TempGoodReceiptLine.COPYFILTERS(Rec);
        TempGoodReceiptLine.SETRANGE("Good Receipt No.", Rec."Good Receipt No.");
        IF NOT TempGoodReceiptLine.FINDFIRST THEN BEGIN
            GoodReceiptLine.COPYFILTERS(Rec);
            GoodReceiptLine.SETRANGE("Good Receipt No.", Rec."Good Receipt No.");
            IF GoodReceiptLine.FINDFIRST THEN BEGIN
                TempGoodReceiptLine := GoodReceiptLine;
                TempGoodReceiptLine.INSERT;
            END;
        END;
        IF Rec."Line No." = TempGoodReceiptLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure GoodReceiptNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "GoodReceiptNo.HideValue" := TRUE;
    end;


    procedure SetLoadingSheetHeader(var LoadingSheetHeader2: Record "Loading Sheet Header")
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

