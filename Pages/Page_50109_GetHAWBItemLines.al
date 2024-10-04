page 50109 "Get HAWB Item Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = "Booking Sheet HAWB Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; Rec."HAWB No.")
                {
                    HideValue = "HAWB No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
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
        "HAWB No.HideValue" := FALSE;
        HAWBNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        HAWBHeader: Record "HAWB Header";
        TempBSHAWBAllocationLine: Record "Booking Sheet HAWB Allocation" temporary;
        ExportGetHAWBItem: Codeunit "Export.-Get BS HAWB Item";

        "HAWB No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
    begin
        TempBSHAWBAllocationLine.RESET;
        TempBSHAWBAllocationLine.COPYFILTERS(Rec);
        TempBSHAWBAllocationLine.SETRANGE("MAWB No.", Rec."MAWB No.");
        IF NOT TempBSHAWBAllocationLine.FINDFIRST THEN BEGIN
            BookingSheetHAWBAllocation.COPYFILTERS(Rec);
            BookingSheetHAWBAllocation.SETRANGE("MAWB No.", Rec."MAWB No.");
            IF BookingSheetHAWBAllocation.FINDFIRST THEN BEGIN
                TempBSHAWBAllocationLine := BookingSheetHAWBAllocation;
                TempBSHAWBAllocationLine.INSERT;
            END;
        END;
        IF Rec."HAWB No." = TempBSHAWBAllocationLine."HAWB No." THEN
            EXIT(TRUE);
    end;

    local procedure HAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "HAWB No.HideValue" := TRUE;
    end;


    procedure SetHAWBHeader(var HAWBHeader2: Record "HAWB Header")
    begin
        HAWBHeader.GET(HAWBHeader2."No.");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        ExportGetHAWBItem.SetHAWBHeader(HAWBHeader);
        ExportGetHAWBItem.CreateHAWBLines(Rec);
    end;
}

