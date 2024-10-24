page 50070 "Get Distribution Lines"
{
    Editable = false;
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
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    HideValue = "Item No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Description; Rec.Description)
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Distribution Date"; Rec."Distribution Date")
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
        //OrderBookingHeader: Record "Business Relation";  
        OrderBookingHeader: Record "Booking Sheet Header";
        TempDailyWeightDistByItem: Record "Dl. Weight Dist. By Item" temporary;
        GetOrderBookings: Codeunit "Export.-Get Distribution";

        "Item No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        DailyWeightDistByItem: Record "Dl. Weight Dist. By Item";
    begin
        TempDailyWeightDistByItem.RESET;
        TempDailyWeightDistByItem.COPYFILTERS(Rec);
        TempDailyWeightDistByItem.SETRANGE("Daily No.", Rec."Daily No.");
        IF NOT TempDailyWeightDistByItem.FINDFIRST THEN BEGIN
            DailyWeightDistByItem.COPYFILTERS(Rec);
            DailyWeightDistByItem.SETRANGE("Daily No.", Rec."Daily No.");
            // SalesInvLine.SETFILTER(Quantity,'<>0');
            // PurchInvLine.SETFILTER("Qty. Rcd. Not Invoiced",'<>0');
            IF DailyWeightDistByItem.FINDFIRST THEN BEGIN
                TempDailyWeightDistByItem := DailyWeightDistByItem;
                TempDailyWeightDistByItem.INSERT;
            END;
        END;
        //IF "Line No." = TempDailyWeightDistByItem."Line No." THEN
        // EXIT(TRUE);
    end;

    local procedure ItemNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Item No.HideValue" := TRUE;
    end;


    procedure SetOrderBookingHeader(var OrderBookingHeader2: Record "Booking Sheet Header")
    begin
        OrderBookingHeader.GET(OrderBookingHeader2."No.");
        //ReceiptHeader.TESTFIELD("Document Type",ReceiptHeader."Document Type"::"Receipt Voucher");
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
        GetOrderBookings.SetOrderBookingHeader(OrderBookingHeader);
        GetOrderBookings.CreateOrderBookingLines(Rec);
    end;
}

