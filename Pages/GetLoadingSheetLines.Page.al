page 50092 "Get Loading Sheet Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = 50061;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field("FWL Docket No."; Rec."FWL Docket No.")
                {
                }
                field("FWL Docket Weight"; Rec."FWL Docket Weight")
                {
                }
                field("FWL Gross Weight"; Rec."FWL Gross Weight")
                {
                }
                field("Airline Docket Weight"; Rec."Airline Docket Weight")
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
        //"Item No.HideValue" := FALSE;
        //ItemNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        GatePassHeader: Record 50068;
        TempLoadingSheetLine: Record 50061 temporary;
        GetLoadingSheets: Codeunit 50005;

        "Item No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        LoadingSheetLine: Record 50061;
    begin
        TempLoadingSheetLine.RESET;
        TempLoadingSheetLine.COPYFILTERS(Rec);
        TempLoadingSheetLine.SETRANGE("Loading Sheet No.", Rec."Loading Sheet No.");
        IF NOT TempLoadingSheetLine.FINDFIRST THEN BEGIN
            LoadingSheetLine.COPYFILTERS(Rec);
            LoadingSheetLine.SETRANGE("Loading Sheet No.", Rec."Loading Sheet No.");
            IF LoadingSheetLine.FINDFIRST THEN BEGIN
                TempLoadingSheetLine := LoadingSheetLine;
                TempLoadingSheetLine.INSERT;
            END;
        END;
        IF Rec."Item No." = TempLoadingSheetLine."Item No." THEN
            EXIT(TRUE);
    end;

    local procedure ItemNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Item No.HideValue" := TRUE;
    end;


    procedure SetGatePassHeader(var GatePassHeader2: Record 50068)
    begin
        GatePassHeader.GET(GatePassHeader2."No.");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        GetLoadingSheets.SetGatePassHeader(GatePassHeader);
        GetLoadingSheets.CreateGatePassLines(Rec);
    end;
}

