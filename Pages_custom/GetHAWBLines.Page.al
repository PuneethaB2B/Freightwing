page 50117 "Get HAWB Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = Table50074;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; "MAWB No.")
                {
                    HideValue = "MAWB No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("HAWB No."; "HAWB No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Consignee Code"; "Consignee Code")
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
        "MAWB No.HideValue" := FALSE;
        MAWBNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        MAWBHeader: Record "50077";
        TempHAWBLine: Record "50074" temporary;
        ExportGetHAWBAllocation: Codeunit "50006";
        [InDataSet]
        "MAWB No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        HAWBLine: Record "50074";
    begin
        TempHAWBLine.RESET;
        TempHAWBLine.COPYFILTERS(Rec);
        TempHAWBLine.SETRANGE("MAWB No.", "MAWB No.");
        IF NOT TempHAWBLine.FINDFIRST THEN BEGIN
            HAWBLine.COPYFILTERS(Rec);
            HAWBLine.SETRANGE("MAWB No.", "MAWB No.");
            IF HAWBLine.FINDFIRST THEN BEGIN
                TempHAWBLine := HAWBLine;
                TempHAWBLine.INSERT;
            END;
        END;
        IF "HAWB No." = TempHAWBLine."HAWB No." THEN
            EXIT(TRUE);
    end;

    local procedure MAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "MAWB No.HideValue" := TRUE;
    end;

    [Scope('Internal')]
    procedure SetMAWBHeader(var MAWBHeader2: Record "50077")
    begin
        MAWBHeader.GET(MAWBHeader2."No.");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        ExportGetHAWBAllocation.SetMAWBHeader(MAWBHeader);
        ExportGetHAWBAllocation.CreateMAWBLines(Rec);
    end;
}

