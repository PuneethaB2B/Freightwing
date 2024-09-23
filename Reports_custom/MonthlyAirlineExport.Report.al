report 50080 "Monthly Airline Export"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MonthlyAirlineExport.rdlc';
    Caption = 'Airline Freight';

    dataset
    {
        dataitem(DataItem1000000056; Table50039)
        {
            DataItemTableView = WHERE (Assigned Date=FILTER(<>''),
                                      MAWB No.=FILTER(<>''));
            RequestFilterFields = "Airline Code","MAWB No.","Assigned Date";
            column(Logo;CompanyInfo.Picture)
            {
            }
            column(PostCode;CompanyInfo."Post Code")
            {
            }
            column(Address;CompanyInfo.Address)
            {
            }
            column(City;CompanyInfo.City)
            {
            }
            column(AirlineName;Airlines.Name)
            {
            }
            column(TotalAmount;TotalAmount)
            {
            }
            column(ItemName;Item.Description)
            {
            }
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
            column(Weight;TotalWeight)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount:=GetFreight("MAWB Receipt"."MAWB No.");
                TotalWeight:=GetWeight("MAWB Receipt"."MAWB No.","MAWB Receipt"."Airline Code");
                IF GetItemCode("MAWB Receipt"."MAWB No.")<>'' THEN
                  Item.GET(GetItemCode("MAWB Receipt"."MAWB No."));
                Airlines.GET("MAWB Receipt"."Airline Code");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Display)
                {
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
        Airlines: Record "50021";
        CompanyInfo: Record "79";
        FilterString: Text[250];
        TotalAmount: Decimal;
        TotalWeight: Decimal;
        Item: Record "27";
        gRecPurchInvLines: Record "123";

    local procedure GetFreight(mawb: Code[20]) FreightCost: Decimal
    var
        MAWBInvoiceCharge: Record "50073";
    begin
        MAWBInvoiceCharge.RESET;
        MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.",mawb);
        MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."Freight Charge Code",'14');
        IF MAWBInvoiceCharge.FINDFIRST THEN BEGIN
          FreightCost := MAWBInvoiceCharge."Base Unit Price";
        END// Group Freight Cost
        ELSE BEGIN
          MAWBInvoiceCharge.RESET;
          MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.",mawb);
          MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."Freight Charge Code",'82');
          IF MAWBInvoiceCharge.FINDFIRST THEN BEGIN
            FreightCost := MAWBInvoiceCharge."Base Unit Price";
          END ELSE BEGIN
            gRecPurchInvLines.RESET;
            gRecPurchInvLines.SETRANGE(gRecPurchInvLines."Payment Voucher No.",mawb);
            gRecPurchInvLines.SETRANGE(gRecPurchInvLines."Charge Code",'14');
            IF gRecPurchInvLines.FINDFIRST THEN BEGIN
              FreightCost := gRecPurchInvLines.Amount;
            END ELSE BEGIN
              gRecPurchInvLines.RESET;
              gRecPurchInvLines.SETRANGE(gRecPurchInvLines."Payment Voucher No.",mawb);
              gRecPurchInvLines.SETRANGE(gRecPurchInvLines."Charge Code",'82');
              IF gRecPurchInvLines.FINDFIRST THEN BEGIN
                FreightCost := gRecPurchInvLines.Amount;
               END;
            END;
          END;
        END;//Get Third Party Freight
        EXIT(FreightCost);
    end;

    local procedure GetWeight(mawb1: Code[20];Airlinecode: Code[10]) Weight: Decimal
    var
        MAWBInvoiceCharge1: Record "50073";
        LoadingSheetLine: Record "50061";
    begin
        Weight:=0;
        LoadingSheetLine.RESET;
        LoadingSheetLine.SETRANGE(LoadingSheetLine."MAWB No.",mawb1);
        LoadingSheetLine.SETRANGE(LoadingSheetLine."Airline Code",Airlinecode);
        IF LoadingSheetLine.FINDSET THEN BEGIN
          REPEAT
            LoadingSheetLine.CALCFIELDS(LoadingSheetLine."FWL Docket Weight");
            Weight+=LoadingSheetLine."FWL Docket Weight";
          UNTIL LoadingSheetLine.NEXT = 0;
        END;
        EXIT(Weight);
    end;

    local procedure GetItemCode(MAWB2: Code[20]) Itemcode: Code[50]
    var
        BookingSheetMAWBAllocation: Record "50070";
    begin
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No",MAWB2);
        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
          Itemcode:=BookingSheetMAWBAllocation."Item No";
        END;
        EXIT(Itemcode);
    end;
}

