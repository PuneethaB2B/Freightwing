page 50057 "Dl. Weight Dist.Cust. Per Item"
{
    Caption = 'Daily Weight Distribution By Customer Per Item';
    PageType = List;
    SourceTable = Table50043;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    HideValue = "Customer No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field("Gross Weight"; "Gross Weight")
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
        "Customer No.HideValue" := FALSE;
        CustNoOnFormat;
    end;

    var
        TempDailyWeightDistByItem: Record "50043";
        [InDataSet]
        "Customer No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        DailyWeightDistByItem: Record "50043";
    begin
        TempDailyWeightDistByItem.RESET;
        TempDailyWeightDistByItem.COPYFILTERS(Rec);
        TempDailyWeightDistByItem.SETRANGE("Daily No.", "Daily No.");
        TempDailyWeightDistByItem.SETRANGE("Customer No.", "Customer No.");
        IF NOT TempDailyWeightDistByItem.FINDFIRST THEN BEGIN
            DailyWeightDistByItem.COPYFILTERS(Rec);
            DailyWeightDistByItem.SETRANGE("Daily No.", "Daily No.");
            DailyWeightDistByItem.SETRANGE("Customer No.", "Customer No.");
            IF DailyWeightDistByItem.FINDFIRST THEN BEGIN
                TempDailyWeightDistByItem := DailyWeightDistByItem;
                TempDailyWeightDistByItem.INSERT;
            END;
        END;
        IF "Item No." = TempDailyWeightDistByItem."Item No." THEN
            EXIT(TRUE);
    end;

    local procedure CustNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Customer No.HideValue" := TRUE;
    end;
}

