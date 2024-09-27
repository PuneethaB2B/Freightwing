report 50074 "Airlines Comodity Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AirlinesComodityReport.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000079; Table50039)
        {
            DataItemTableView = WHERE(Assigned Date=FILTER(<>''));
            RequestFilterFields = "Airline Code","Assigned Date";
            column(Filters;Filters)
            {
            }
            column(LoadingDate;"MAWB Receipt"."Assigned Date")
            {
            }
            column(AirlineCode_MAWBReceipt;"MAWB Receipt"."Airline Code")
            {
            }
            column(Logo;CompanyInfo.Picture)
            {
            }
            column(MAWBNo_MAWBReceipt;"MAWB Receipt"."MAWB No.")
            {
            }
            column(ReceiptDate_MAWBReceipt;"MAWB Receipt"."Receipt Date")
            {
            }
            column(MAWBFees_MAWBReceipt;"MAWB Receipt"."MAWB Fees")
            {
            }
            column(Assigned_MAWBReceipt;"MAWB Receipt".Assigned)
            {
            }
            column(FreightChargeCode_MAWBReceipt;"MAWB Receipt"."Freight Charge Code")
            {
            }
            column(Prepared_MAWBReceipt;"MAWB Receipt".Prepared)
            {
            }
            column(PrefixCode_MAWBReceipt;"MAWB Receipt"."Prefix Code")
            {
            }
            column(BillNo_MAWBReceipt;"MAWB Receipt"."Bill No.")
            {
            }
            column(StartNo_MAWBReceipt;"MAWB Receipt"."Start No.")
            {
            }
            column(EndNo_MAWBReceipt;"MAWB Receipt"."End No.")
            {
            }
            column(KAAFees_MAWBReceipt;"MAWB Receipt"."KAA Fees")
            {
            }
            column(Invoiced_MAWBReceipt;"MAWB Receipt".Invoiced)
            {
            }
            column(AssignedDate_MAWBReceipt;"MAWB Receipt"."Assigned Date")
            {
            }
            column(InviocedDate_MAWBReceipt;"MAWB Receipt"."Invioced Date")
            {
            }
            column(PreparedDate_MAWBReceipt;"MAWB Receipt"."Prepared Date")
            {
            }
            column(TotalSales;TotalSales)
            {
            }
            column(TotalPurchase;TotalPurchase)
            {
            }
            column(TotalWeight;TotalWeight)
            {
            }
            column(ItemName;Item.Description)
            {
            }
            column(AirlineName;Airline.Name)
            {
            }
            column(Detailed;Detailed)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalSales:=0;
                TotalPurchase:=0;
                TotalWeight:=0;
                Airline.GET("MAWB Receipt"."Airline Code");
                IF GetItem("MAWB Receipt"."MAWB No.")<>'' THEN
                  Item.GET(GetItem("MAWB Receipt"."MAWB No."));

                TotalSales:=GetSales("MAWB Receipt"."MAWB No.");
                TotalWeight:=GetWeight("MAWB Receipt"."MAWB No.");
                TotalPurchase:=GetPurchase("MAWB Receipt"."MAWB No.");
            end;

            trigger OnPreDataItem()
            begin
                Filters:="MAWB Receipt".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Visibility)
                {
                    field("Include Detailed Drill Down";Detailed)
                    {
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Airline: Record "50021";
        CompanyInfo: Record "79";
        Item: Record "27";
        Filters: Text[250];
        Detailed: Boolean;
        TotalPurchase: Decimal;
        TotalSales: Decimal;
        TotalWeight: Decimal;

    local procedure GetItem(MAWB2: Code[50]) ItemCode: Code[50]
    var
        BookingSheetMAWBAllocation: Record "50070";
    begin
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No",MAWB2);
        IF BookingSheetMAWBAllocation.FINDFIRST THEN
          EXIT(BookingSheetMAWBAllocation."Item No");
    end;

    local procedure GetSales(mawb: Code[20]) SalesCost: Decimal
    var
        SalesInvoiceLine: Record "113";
        SalesInvoiceHeader: Record "112";
    begin
        SalesCost:=0;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.",mawb);
        IF SalesInvoiceLine.FINDSET THEN BEGIN
           REPEAT
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
              SalesCost+=(SalesInvoiceLine."Amount Including VAT"/SalesInvoiceHeader."Currency Factor")
            ELSE
              SalesCost+=SalesInvoiceLine."Amount Including VAT";
          UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        EXIT(SalesCost);
    end;

    local procedure GetPurchase(MAWB1: Code[50]) PurchaseAmount: Decimal
    var
        PurchInvLine: Record "123";
        PurchInvHeader: Record "122";
    begin
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.",MAWB1);
        IF PurchInvLine.FINDSET THEN BEGIN
          PurchInvHeader.GET(PurchInvLine."Document No.");
          REPEAT
            IF PurchInvHeader."Currency Factor"<> 0 THEN
                PurchaseAmount+=PurchInvLine.Amount/PurchInvHeader."Currency Factor"
              ELSE
               PurchaseAmount+=PurchInvLine.Amount;
          UNTIL PurchInvLine.NEXT = 0;
        END;
        EXIT(PurchaseAmount);
    end;

    local procedure GetWeight(MAWB3: Code[50]) ShippedWeight: Decimal
    var
        LoadingSheetLine: Record "50061";
        MAWBInvoiceCharge: Record "50073";
        SalesInvoiceLine: Record "113";
    begin
        MAWBInvoiceCharge.RESET;
        MAWBInvoiceCharge.SETFILTER(MAWBInvoiceCharge."Chargeable Weight",'<>%1',0);
        MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.",MAWB3);
        IF MAWBInvoiceCharge.FINDFIRST THEN BEGIN
          ShippedWeight:=MAWBInvoiceCharge."Chargeable Weight";
        END;
        EXIT(ShippedWeight);
    end;
}

