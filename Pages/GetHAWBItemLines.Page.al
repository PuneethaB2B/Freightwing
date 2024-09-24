page 50109 "Get HAWB Item Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = Table50056;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; "HAWB No.")
                {
                    HideValue = "HAWB No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Consignee Name"; "Consignee Name")
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
        "HAWB No.HideValue" := FALSE;
        HAWBNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        HAWBHeader: Record "50075";
        TempBSHAWBAllocationLine: Record "50056" temporary;
        ExportGetHAWBItem: Codeunit "50007";
        [InDataSet]
        "HAWB No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        BookingSheetHAWBAllocation: Record "50056";
    begin
        TempBSHAWBAllocationLine.RESET;
        TempBSHAWBAllocationLine.COPYFILTERS(Rec);
        TempBSHAWBAllocationLine.SETRANGE("MAWB No.", "MAWB No.");
        IF NOT TempBSHAWBAllocationLine.FINDFIRST THEN BEGIN
            BookingSheetHAWBAllocation.COPYFILTERS(Rec);
            BookingSheetHAWBAllocation.SETRANGE("MAWB No.", "MAWB No.");
            IF BookingSheetHAWBAllocation.FINDFIRST THEN BEGIN
                TempBSHAWBAllocationLine := BookingSheetHAWBAllocation;
                TempBSHAWBAllocationLine.INSERT;
            END;
        END;
        IF "HAWB No." = TempBSHAWBAllocationLine."HAWB No." THEN
            EXIT(TRUE);
    end;

    local procedure HAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "HAWB No.HideValue" := TRUE;
    end;


    procedure SetHAWBHeader(var HAWBHeader2: Record "50075")
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

