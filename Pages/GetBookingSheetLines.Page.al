page 50133 "Get Booking Sheet Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = 50054;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Booking Sheet No."; Rec."Booking Sheet No.")
                {
                    HideValue = "BookingSheetNo.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
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
                field("Booking Date"; Rec."Booking Date")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Clearing Agent Code"; Rec."Clearing Agent Code")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Cut-off Time"; Rec."Cut-off Time")
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
        "BookingSheetNo.HideValue" := FALSE;
        BookingSheetNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        GoodReceiptHeader: Record 50052;
        TempBookingSheetLine: Record 50054 temporary;
        GetBookingSheets: Codeunit 50010;
        "BookingSheetNo.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        BookingSheetLine: Record 50054;
    begin
        TempBookingSheetLine.RESET;
        TempBookingSheetLine.COPYFILTERS(Rec);
        TempBookingSheetLine.SETRANGE("Booking Sheet No.", Rec."Booking Sheet No.");
        IF NOT TempBookingSheetLine.FINDFIRST THEN BEGIN
            BookingSheetLine.COPYFILTERS(Rec);
            BookingSheetLine.SETRANGE("Booking Sheet No.", Rec."Booking Sheet No.");

            IF BookingSheetLine.FINDFIRST THEN BEGIN
                TempBookingSheetLine := BookingSheetLine;
                TempBookingSheetLine.INSERT;
            END;
        END;
        IF Rec."Line No." = TempBookingSheetLine."Line No." THEN
            EXIT(TRUE);
    end;

    local procedure BookingSheetNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "BookingSheetNo.HideValue" := TRUE;
    end;


    procedure SetGoodReceiptHeader(var GoodReceiptHeader2: Record 50052)
    begin
        GoodReceiptHeader.GET(GoodReceiptHeader2."No.");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        GetBookingSheets.SetGoodsReceiptHeader(GoodReceiptHeader);
        GetBookingSheets.CreateGoodsReceiptLines(Rec);
    end;
}

