page 50121 "Get MAWB Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = "MAWB Line";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("MAWB No."; Rec."MAWB No.")
                {
                    HideValue = "MAWB No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("HAWB No."; Rec."HAWB No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Rate/Charge"; Rec."Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Flight Date"; Rec."Flight Date")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
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
        "MAWB No.HideValue" := FALSE;
        MAWBNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        SalesHeader: Record "Sales Header";
        TempMAWBLine: Record "MAWB Line" temporary;
        ExportGetMAWBAllocation: Codeunit "Export.-Get MAWB Line";

        "MAWB No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        MAWBLine: Record "MAWB Line";
    begin
        TempMAWBLine.RESET;
        TempMAWBLine.COPYFILTERS(Rec);
        TempMAWBLine.SETRANGE("MAWB No.", Rec."MAWB No.");
        IF NOT TempMAWBLine.FINDFIRST THEN BEGIN
            MAWBLine.COPYFILTERS(Rec);
            MAWBLine.SETRANGE("MAWB No.", Rec."MAWB No.");
            IF MAWBLine.FINDFIRST THEN BEGIN
                TempMAWBLine := MAWBLine;
                TempMAWBLine.INSERT;
            END;
        END;
        IF Rec."HAWB No." = TempMAWBLine."HAWB No." THEN
            EXIT(TRUE);
    end;

    local procedure MAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "MAWB No.HideValue" := TRUE;
    end;


    procedure SetSalesHeader(var SalesHeader2: Record "Sales Header")
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

