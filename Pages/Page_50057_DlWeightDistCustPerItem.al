page 50057 "Dl. Weight Dist.Cust. Per Item"
{
    Caption = 'Daily Weight Distribution By Customer Per Item';
    PageType = List;
    SourceTable = "Dl. Weight Dist. By Item";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    HideValue = "Customer No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
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
        TempDailyWeightDistByItem: Record "Dl. Weight Dist. By Item";

        "Customer No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        DailyWeightDistByItem: Record "Dl. Weight Dist. By Item";
    begin
        TempDailyWeightDistByItem.RESET;
        TempDailyWeightDistByItem.COPYFILTERS(Rec);
        TempDailyWeightDistByItem.SETRANGE("Daily No.", Rec."Daily No.");
        TempDailyWeightDistByItem.SETRANGE("Customer No.", Rec."Customer No.");
        IF NOT TempDailyWeightDistByItem.FINDFIRST THEN BEGIN
            DailyWeightDistByItem.COPYFILTERS(Rec);
            DailyWeightDistByItem.SETRANGE("Daily No.", Rec."Daily No.");
            DailyWeightDistByItem.SETRANGE("Customer No.", Rec."Customer No.");
            IF DailyWeightDistByItem.FINDFIRST THEN BEGIN
                TempDailyWeightDistByItem := DailyWeightDistByItem;
                TempDailyWeightDistByItem.INSERT;
            END;
        END;
        IF Rec."Item No." = TempDailyWeightDistByItem."Item No." THEN
            EXIT(TRUE);
    end;

    local procedure CustNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Customer No.HideValue" := TRUE;
    end;
}

