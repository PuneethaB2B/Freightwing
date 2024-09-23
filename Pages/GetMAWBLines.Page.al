page 50121 "Get MAWB Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = Table50076;

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
                field(Description; Description)
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Rate/Charge"; "Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Flight Date"; "Flight Date")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
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
        SalesHeader: Record "36";
        TempMAWBLine: Record "50076" temporary;
        ExportGetMAWBAllocation: Codeunit "50008";
        [InDataSet]
        "MAWB No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        MAWBLine: Record "50076";
    begin
        TempMAWBLine.RESET;
        TempMAWBLine.COPYFILTERS(Rec);
        TempMAWBLine.SETRANGE("MAWB No.", "MAWB No.");
        IF NOT TempMAWBLine.FINDFIRST THEN BEGIN
            MAWBLine.COPYFILTERS(Rec);
            MAWBLine.SETRANGE("MAWB No.", "MAWB No.");
            IF MAWBLine.FINDFIRST THEN BEGIN
                TempMAWBLine := MAWBLine;
                TempMAWBLine.INSERT;
            END;
        END;
        IF "HAWB No." = TempMAWBLine."HAWB No." THEN
            EXIT(TRUE);
    end;

    local procedure MAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "MAWB No.HideValue" := TRUE;
    end;

    [Scope('Internal')]
    procedure SetSalesHeader(var SalesHeader2: Record "36")
    begin
        SalesHeader.GET(SalesHeader2."Document Type", SalesHeader2."No.");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        ExportGetMAWBAllocation.SetSalesHeader(SalesHeader);
        ExportGetMAWBAllocation.CreateSalesInvoiceLines(Rec);
    end;
}

