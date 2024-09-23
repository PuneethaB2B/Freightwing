report 50085 "MAWB Detailss"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAWBDetailss.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {
            DataItemTableView = WHERE(MAWB No.=FILTER(<>''));
            RequestFilterFields = "Airline Code";
            column(AirlineCode_MAWBReceipt;"MAWB Receipt"."Airline Code")
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
            column(NoHouses;NoHouses)
            {
            }
            column(AirlineName;Airline.Name)
            {
            }
            column(ChargeableWeight;ChargeableWeight)
            {
            }
            column(FreightAmount;FreightAmount)
            {
            }
            column(Shipper;Shipper)
            {
            }
            column(BilledTo;BilledTo)
            {
            }
            column(VAT;VATAmount)
            {
            }
            column(Rate;rate)
            {
            }
            column(TotalAmount;TotalAmount)
            {
            }
            column(NonFreight;NonFreight)
            {
            }
            column(MarginAmnt;MarginAmnt)
            {
            }
            column(ItemDescription;Item.Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETCURRENTKEY(BookingSheetMAWBAllocation."MAWB No");
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No","MAWB Receipt"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN
                  ok:=Item.GET(BookingSheetMAWBAllocation."Item No");
                NoHouses:=0;
                NoHouses:=GetNumberofHouses("MAWB Receipt"."MAWB No.");
                ChargeableWeight:=0;
                ChargeableWeight:=GetChargeableWeight("MAWB Receipt"."MAWB No.");
                Shipper:='';
                Shipper:=GetShipper("MAWB Receipt"."MAWB No.");
                TotalAmount:=0;
                TotalAmount:=GetInvoiceDetails("MAWB Receipt"."MAWB No.");
                IF Airline.GET("MAWB Receipt"."Airline Code") THEN;
                FreightAmount:=0;
                FreightAmount:=GetFreightAmount("MAWB Receipt"."MAWB No.");
                MarginAmnt:=0;
                MarginAmnt:=GetMarginAmount("MAWB Receipt"."MAWB No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
           //Gaurav
    end;

    var
        NoHouses: Integer;
        Lines: Integer;
        FreightCharge: Record "50018";
        Airline: Record "50021";
        ChargeableWeight: Decimal;
        FreightAmount: Decimal;
        Shipper: Text[200];
        Customer: Record "18";
        BilledTo: Text[250];
        TotalAmount: Decimal;
        VATAmount: Decimal;
        InvoiceNo: Code[10];
        rate: Decimal;
        NonFreight: Decimal;
        MarginAmnt: Decimal;
        Item: Record "27";
        BookingSheetMAWBAllocation: Record "50070";
        ok: Boolean;
        SalesInvoiceHeader: Record "112";

    local procedure GetVendor()
    begin
    end;

    local procedure GetNumberofHouses(mawb24: Code[50]) Houses: Integer
    var
        HAWBLine: Record "50074";
    begin
        HAWBLine.RESET;
        HAWBLine.SETRANGE(HAWBLine."MAWB No.",mawb24);
        //MESSAGE(mawb24);
        IF HAWBLine.FINDSET THEN BEGIN
          REPEAT
          Houses+=1;
          //MESSAGE('%1',Houses);
          UNTIL HAWBLine.NEXT = 0;
        END;//Count Houses
        IF Houses=0 THEN
          Houses:=1;

        EXIT(Houses);
    end;

    local procedure GetChargeableWeight(MAWB3: Code[50]) Weight: Decimal
    var
        MAWBInvoiceCharge: Record "50073";
    begin
        rate:=0;
        MAWBInvoiceCharge.RESET;
        MAWBInvoiceCharge.SETFILTER(MAWBInvoiceCharge."Chargeable Weight",'<>%1',0);
        MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.",MAWB3);
        IF MAWBInvoiceCharge.FINDFIRST THEN  BEGIN
          Weight:=MAWBInvoiceCharge."Chargeable Weight";
          rate:=MAWBInvoiceCharge."Contract Rate";
        END;
        EXIT(Weight);
    end;

    local procedure GetShipper(MAWB2: Code[50]) ShipperName: Text[200]
    var
        BookingSheetMAWBAllocation: Record "50070";
        Customer: Record "18";
    begin
        BookingSheetMAWBAllocation.RESET;
        ShipperName:='';
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No",MAWB2);
        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
          IF Customer.GET(BookingSheetMAWBAllocation."Shipper Code") THEN
            ShipperName:=Customer.Name;
        END;
        EXIT(ShipperName);
    end;

    local procedure GetInvoiceDetails(mawb: Code[50]) Amnt: Decimal
    var
        SalesInvoiceHeader: Record "112";
        SalesInvoiceLine: Record "113";
        SalesInvoiceLine1: Record "113";
    begin
        BilledTo:='';
        VATAmount:=0;
        NonFreight:=0;
        Amnt:=0;
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.",mawb);
        IF SalesInvoiceLine.FIND('-') THEN BEGIN
          REPEAT
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            BilledTo:=SalesInvoiceHeader."Bill-to Name";
            IF SalesInvoiceHeader."Currency Factor"<>0 THEN
              Amnt+=(SalesInvoiceLine."Amount Including VAT"/SalesInvoiceHeader."Currency Factor")
            ELSE
              Amnt+=SalesInvoiceLine."Amount Including VAT";
          UNTIL SalesInvoiceLine.NEXT=0;
        END;

        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETFILTER(SalesInvoiceLine."VAT %",'<>%1',0);
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.",mawb);
        IF SalesInvoiceLine.FIND('-') THEN BEGIN
          REPEAT
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            IF SalesInvoiceHeader."Currency Factor"<>0 THEN
              VATAmount+=((SalesInvoiceLine."Amount Including VAT"/SalesInvoiceHeader."Currency Factor")
              -(SalesInvoiceLine.Amount/SalesInvoiceHeader."Currency Factor"))
            ELSE
            VATAmount+=(SalesInvoiceLine."Amount Including VAT"-SalesInvoiceLine.Amount);
          UNTIL SalesInvoiceLine.NEXT = 0;
        END;

        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Freight Charge Code",'<>%1|%2','14','82');
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.",mawb);
        IF SalesInvoiceLine.FIND('-') THEN BEGIN
          REPEAT
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            IF SalesInvoiceHeader."Currency Factor"<>0 THEN
              NonFreight+=(SalesInvoiceLine."Amount Including VAT"/SalesInvoiceHeader."Currency Factor")
            ELSE
              NonFreight+=(SalesInvoiceLine."Amount Including VAT");
          UNTIL SalesInvoiceLine.NEXT = 0;
        END;

        EXIT(Amnt);
    end;

    local procedure GetFreightAmount(MAWB1: Code[50]) FreightAmnt: Decimal
    var
        SalesInvoiceLine: Record "113";
        FreightCharge: Record "50018";
    begin
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.",MAWB1);
        IF SalesInvoiceLine.FINDSET THEN BEGIN
          REPEAT
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            IF FreightCharge.GET(SalesInvoiceLine."Freight Charge Code") THEN;
              IF FreightCharge."Freight Cost" THEN BEGIN
                IF SalesInvoiceHeader."Currency Factor"<>0 THEN
                FreightAmnt+=(SalesInvoiceLine."Amount Including VAT"/SalesInvoiceHeader."Currency Factor")
                ELSE
                   FreightAmnt+=(SalesInvoiceLine."Amount Including VAT");

              END;
          UNTIL SalesInvoiceLine.NEXT = 0;
        END;
        EXIT(FreightAmnt);
    end;

    local procedure GetMarginAmount(mawb15: Code[50]) MarginAmount: Decimal
    var
        SalesInvoiceLine15: Record "113";
    begin
        MarginAmount:=0;
        SalesInvoiceLine15.RESET;
        SalesInvoiceLine15.SETFILTER(SalesInvoiceLine15."Margin Amount",'<>%1',0);
        SalesInvoiceLine15.SETRANGE(SalesInvoiceLine15."MAWB No.",mawb15);
        IF SalesInvoiceLine15.FINDSET THEN BEGIN
          REPEAT
          SalesInvoiceHeader.GET(SalesInvoiceLine15."Document No.");
          IF SalesInvoiceHeader."Currency Factor"<> 0 THEN
             MarginAmount+=(SalesInvoiceLine15."Margin Amount"/SalesInvoiceHeader."Currency Factor")
          ELSE
            MarginAmount+=(SalesInvoiceLine15."Margin Amount");
          UNTIL SalesInvoiceLine15.NEXT = 0;
        END;
        EXIT(MarginAmount);
    end;
}

