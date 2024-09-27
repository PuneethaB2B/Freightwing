report 50046 "Exports Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ExportsSummary.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {
            RequestFilterFields = "Airline Code", "Assigned Date";
            column(City; ComapanyInfo.City)
            {
            }
            column(PostalCode; ComapanyInfo."Post Code")
            {
            }
            column(Logo; ComapanyInfo.Picture)
            {
            }
            column(Address; ComapanyInfo.Address)
            {
            }
            column(Curr; Setup."Invoicing Currency Code")
            {
            }
            column(ShippedCost; Fcost)
            {
            }
            column(ShippedWEight; FWeight)
            {
            }
            column(ShippedItem; ItemDesc)
            {
            }
            column(AirlineCode_MAWBReceipt; "MAWB Receipt"."Airline Code")
            {
            }
            column(MAWBNo_MAWBReceipt; "MAWB Receipt"."MAWB No.")
            {
            }
            column(ReceiptDate_MAWBReceipt; "MAWB Receipt"."Receipt Date")
            {
            }
            column(MAWBFees_MAWBReceipt; "MAWB Receipt"."MAWB Fees")
            {
            }
            column(Assigned_MAWBReceipt; "MAWB Receipt".Assigned)
            {
            }
            column(FreightChargeCode_MAWBReceipt; "MAWB Receipt"."Freight Charge Code")
            {
            }
            column(Prepared_MAWBReceipt; "MAWB Receipt".Prepared)
            {
            }
            column(PrefixCode_MAWBReceipt; "MAWB Receipt"."Prefix Code")
            {
            }
            column(BillNo_MAWBReceipt; "MAWB Receipt"."Bill No.")
            {
            }
            column(StartNo_MAWBReceipt; "MAWB Receipt"."Start No.")
            {
            }
            column(EndNo_MAWBReceipt; "MAWB Receipt"."End No.")
            {
            }
            column(KAAFees_MAWBReceipt; "MAWB Receipt"."KAA Fees")
            {
            }
            column(Invoiced_MAWBReceipt; "MAWB Receipt".Invoiced)
            {
            }
            column(AssignedDate_MAWBReceipt; "MAWB Receipt"."Assigned Date")
            {
            }
            column(InviocedDate_MAWBReceipt; "MAWB Receipt"."Invioced Date")
            {
            }
            column(PreparedDate_MAWBReceipt; "MAWB Receipt"."Prepared Date")
            {
            }
            column(AirlineName; Airline.Name)
            {
            }
            column(PurchFreight; PFreight)
            {
            }
            column(Detailed; Detailed)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ComapanyInfo.CALCFIELDS(Picture);
                FWeight := 0;
                FWeight := GetWeight("MAWB Receipt"."MAWB No.");
                Fcost := 0;
                Fcost := GetCharge("MAWB Receipt"."MAWB No.");
                ItemDesc := '';
                ItemDesc := GetItem("MAWB Receipt"."MAWB No.");
                Airline.GET("MAWB Receipt"."Airline Code");
                PFreight := 0;
                PFreight := GetPurchFreight("MAWB Receipt"."MAWB No.");
            end;

            trigger OnPreDataItem()
            begin
                ComapanyInfo.GET();
                Setup.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("MAWB View Options")
                {
                    field("Include Detailed MAWB Breakdown"; Detailed)
                    {
                        ApplicationArea = All;
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
        ComapanyInfo: Record "79";
        Setup: Record "50010";
        Fcost: Decimal;
        FWeight: Decimal;
        ItemDesc: Text[250];
        Airline: Record "50021";
        ok: Boolean;
        PFreight: Decimal;
        Detailed: Boolean;

    local procedure GetItem(mawb: Code[50]) Descrip: Text[250]
    var
        Item: Record "27";
        BookingSheetMAWBAllocation: Record "50070";
        lRecMAWBHr: Record "50077";
    begin
        Descrip := '';
        /*BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No",mawb);
        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
          IF Item.GET(BookingSheetMAWBAllocation."Item No") THEN
            Descrip:=Item.Description
        END;*/// Commented due to client doesn't want to pick it from bookingsheet instead he want to pick from archives
        lRecMAWBHr.RESET;
        lRecMAWBHr.SETRANGE("No.", mawb);
        IF lRecMAWBHr.FINDFIRST THEN
            Descrip := lRecMAWBHr."Item Description";
        EXIT(Descrip);

    end;

    local procedure GetCharge(mawb1: Code[50]) FreightCost: Decimal
    var
        MAWBInvoiceCharge: Record "50073";
        SalesInvoiceHeader: Record "112";
        SalesInvoiceLine: Record "113";
    begin
        FreightCost := 0;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Freight Charge Code", '=%1|%2', '14', '82');
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.", mawb1);
        IF SalesInvoiceLine.FINDSET THEN BEGIN
            REPEAT
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", SalesInvoiceLine."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
                        FreightCost += (SalesInvoiceLine."Line Amount" / SalesInvoiceHeader."Currency Factor")
                    ELSE
                        FreightCost += SalesInvoiceLine."Line Amount";
                END;
            UNTIL SalesInvoiceLine.NEXT = 0;
        END;

        EXIT(FreightCost);
    end;

    local procedure GetWeight(mawb2: Code[50]) WeightShipped: Decimal
    var
        MAWBInvoiceCharge2: Record "50073";
        lRecMAWBHr: Record "50077";
    begin
        /*WeightShipped:=0;
        MAWBInvoiceCharge2.RESET;
        MAWBInvoiceCharge2.SETFILTER(MAWBInvoiceCharge2."Chargeable Weight",'<>%1',0);
        MAWBInvoiceCharge2.SETRANGE(MAWBInvoiceCharge2."MAWB No.",mawb2);
        IF MAWBInvoiceCharge2.FINDFIRST THEN
        WeightShipped:=MAWBInvoiceCharge2."Chargeable Weight";*/ // Commented for future usage if Client changes requirement in Future
        //Client wants chargeable weight from Archive MAWB details.
        //Start
        WeightShipped := 0;
        lRecMAWBHr.RESET;
        lRecMAWBHr.SETRANGE("No.", mawb2);
        IF lRecMAWBHr.FINDFIRST THEN
            WeightShipped := lRecMAWBHr."Total Weight";
        // End



        EXIT(WeightShipped);

    end;

    local procedure GetPurchFreight(MAWBNo: Code[30]) PurchFreight: Decimal
    var
        PurchInvLine: Record "123";
        PurchInvHeader: Record "122";
    begin
        PurchInvLine.RESET;
        PurchInvLine.SETFILTER(PurchInvLine."Charge Code", '=%1|%2', '14', '82');
        PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.", MAWBNo);
        IF PurchInvLine.FINDFIRST THEN BEGIN
            REPEAT
                ok := PurchInvHeader.GET(PurchInvLine."Document No.");
                IF PurchInvHeader."Currency Factor" <> 0 THEN
                    PurchFreight += (PurchInvLine."Amount Including VAT" / PurchInvHeader."Currency Factor")
                ELSE
                    PurchFreight += PurchInvLine."Amount Including VAT";
            UNTIL PurchInvLine.NEXT = 0;
        END;
        EXIT(PurchFreight);
    end;
}

