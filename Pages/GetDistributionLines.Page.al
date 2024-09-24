page 50070 "Get Distribution Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = Table50043;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    HideValue = "Item No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Description; Description)
                {
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Distribution Date"; "Distribution Date")
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
        OrderBookingHeader: Record "50053";
        TempDailyWeightDistByItem: Record "50043" temporary;
        GetOrderBookings: Codeunit "50004";
        [InDataSet]
        "Item No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        DailyWeightDistByItem: Record "50043";
    begin
        TempDailyWeightDistByItem.RESET;
        TempDailyWeightDistByItem.COPYFILTERS(Rec);
        TempDailyWeightDistByItem.SETRANGE("Daily No.", "Daily No.");
        IF NOT TempDailyWeightDistByItem.FINDFIRST THEN BEGIN
            DailyWeightDistByItem.COPYFILTERS(Rec);
            DailyWeightDistByItem.SETRANGE("Daily No.", "Daily No.");
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


    procedure SetOrderBookingHeader(var OrderBookingHeader2: Record "50053")
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
