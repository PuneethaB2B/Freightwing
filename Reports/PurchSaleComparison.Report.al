report 50096 "Purch. Sale Comparison"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchSaleComparison.rdlc';

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
            column(MAWBCredit;MawbCredit)
            {
            }
            column(NoHouses;NoHouses)
            {
            }
            column(AirlineName;Airline.Name)
            {
            }
            column(Summary;Summary)
            {
            }
            column(Loss;Losses)
            {
            }
            dataitem(DataItem1000000001;Table112)
            {
                DataItemLink = MAWB No.=FIELD(MAWB No.);
                RequestFilterFields = "Bill-to Customer No.","Posting Date";
                column(PurchCreditMemoAmount;PurchCreditMemoAmount)
                {
                }
                column(CrMemoNo;CrMemoNo)
                {
                }
                column(Lines;Lines)
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader;"Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceHeader;"Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(CurrencyFactor_SalesInvoiceHeader;"Sales Invoice Header"."Currency Factor")
                {
                }
                column(No_SalesInvoiceHeader;"Sales Invoice Header"."No.")
                {
                }
                column(BilltoCustomerNo_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Name")
                {
                }
                column(BilltoName2_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Name 2")
                {
                }
                column(BilltoAddress_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Address")
                {
                }
                column(BilltoAddress2_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Address 2")
                {
                }
                column(BilltoCity_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to City")
                {
                }
                column(BilltoContact_SalesInvoiceHeader;"Sales Invoice Header"."Bill-to Contact")
                {
                }
                column(YourReference_SalesInvoiceHeader;"Sales Invoice Header"."Your Reference")
                {
                }
                column(ShiptoCode_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Code")
                {
                }
                column(ShiptoName_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Name")
                {
                }
                column(ShiptoName2_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Name 2")
                {
                }
                column(ShiptoAddress_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Address")
                {
                }
                column(ShiptoAddress2_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Address 2")
                {
                }
                column(ShiptoCity_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to City")
                {
                }
                column(ShiptoContact_SalesInvoiceHeader;"Sales Invoice Header"."Ship-to Contact")
                {
                }
                column(OrderDate_SalesInvoiceHeader;"Sales Invoice Header"."Order Date")
                {
                }
                column(PostingDate_SalesInvoiceHeader;"Sales Invoice Header"."Posting Date")
                {
                }
                column(ShipmentDate_SalesInvoiceHeader;"Sales Invoice Header"."Shipment Date")
                {
                }
                column(PostingDescription_SalesInvoiceHeader;"Sales Invoice Header"."Posting Description")
                {
                }
                column(SalesCreditMemoAmount;SalesCreditMemoAmount)
                {
                }
                dataitem(DataItem1000000002;Table113)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    DataItemTableView = SORTING(Document No.,Line No.)
                                        ORDER(Ascending);
                    column(SelltoCustomerNo_SalesInvoiceLine;"Sales Invoice Line"."Sell-to Customer No.")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine;"Sales Invoice Line"."Document No.")
                    {
                    }
                    column(LineNo_SalesInvoiceLine;"Sales Invoice Line"."Line No.")
                    {
                    }
                    column(Type_SalesInvoiceLine;"Sales Invoice Line".Type)
                    {
                    }
                    column(No_SalesInvoiceLine;"Sales Invoice Line"."No.")
                    {
                    }
                    column(LocationCode_SalesInvoiceLine;"Sales Invoice Line"."Location Code")
                    {
                    }
                    column(PostingGroup_SalesInvoiceLine;"Sales Invoice Line"."Posting Group")
                    {
                    }
                    column(ShipmentDate_SalesInvoiceLine;"Sales Invoice Line"."Shipment Date")
                    {
                    }
                    column(Description_SalesInvoiceLine;"Sales Invoice Line".Description)
                    {
                    }
                    column(Description2_SalesInvoiceLine;"Sales Invoice Line"."Description 2")
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine;"Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Quantity_SalesInvoiceLine;"Sales Invoice Line".Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine;"Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(UnitCostLCY_SalesInvoiceLine;"Sales Invoice Line"."Unit Cost (LCY)")
                    {
                    }
                    column(VAT_SalesInvoiceLine;"Sales Invoice Line"."VAT %")
                    {
                    }
                    column(LineDiscount_SalesInvoiceLine;"Sales Invoice Line"."Line Discount %")
                    {
                    }
                    column(LineDiscountAmount_SalesInvoiceLine;"Sales Invoice Line"."Line Discount Amount")
                    {
                    }
                    column(Amount_SalesInvoiceLine;"Sales Invoice Line".Amount)
                    {
                    }
                    column(PurchaseAmount;PurchaseAmount)
                    {
                    }
                    column(LineCreditPurch;LineCreditPurch)
                    {
                    }
                    column(InvNo12;InvNo12)
                    {
                    }
                    column(Vendor;Vendor)
                    {
                    }
                    column(HAWBNo_SalesInvoiceLine;"Sales Invoice Line"."HAWB No.")
                    {
                    }
                    column(PPdate;PPdate)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PurchCreditMemoAmount:=0;
                        PurchaseAmount:=0;
                        PPdate:=0D;

                        IF FreightCharge.GET("Sales Invoice Line"."Freight Charge Code") THEN;
                        IF FreightCharge."Split On"=FreightCharge."Split On"::Weights THEN BEGIN
                        PurchaseAmount:="Sales Invoice Line"."Split Factor"*GetPurchaseAmount("Sales Invoice Line"."MAWB No.","Sales Invoice Line"."Freight Charge Code");
                        PurchCreditMemoAmount:="Sales Invoice Line"."Split Factor"*GetPurchaseCreditMemoTotal("Sales Invoice Line"."MAWB No.","Sales Invoice Line"."Freight Charge Code");
                        END ELSE BEGIN
                          IF "Sales Invoice Line"."Split Factor"<>0 THEN BEGIN
                            PurchaseAmount:=GetPurchaseAmount("Sales Invoice Line"."MAWB No.","Sales Invoice Line"."Freight Charge Code")/"Sales Invoice Line"."Split Factor";
                            PurchCreditMemoAmount:=GetPurchaseCreditMemoTotal("Sales Invoice Line"."MAWB No.","Sales Invoice Line"."Freight Charge Code")/"Sales Invoice Line"."Split Factor";
                          END;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Lines:=0;
                    SalesCreditMemoAmount:=0;
                    Lines:=GetInvoiceLinesCount("Sales Invoice Header"."MAWB No.","Sales Invoice Header"."No.");
                    IF Lines=0 THEN
                      Lines:=1;
                    SalesCreditMemoAmount:=GetSalesCreditMemoTotal("Sales Invoice Header"."No.")/Lines;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoHouses:=0;
                NoHouses:=GetNumberofHouses("MAWB Receipt"."MAWB No.");
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
                    field("Show Summary Only";Summary)
                    {
                    }
                    field("Show Loss Only";Losses)
                    {

                        trigger OnValidate()
                        begin
                            IF Losses THEN
                              Summary:=TRUE
                            ELSE
                              Summary:=FALSE;
                        end;
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

    trigger OnPostReport()
    begin
           //Gaurav
    end;

    var
        PurchaseAmount: Decimal;
        SalesCreditMemoAmount: Decimal;
        PurchCreditMemoAmount: Decimal;
        MawbCredit: Decimal;
        NoHouses: Integer;
        Lines: Integer;
        LineCreditPurch: Decimal;
        InvNo12: Code[50];
        Vendor: Text[250];
        CrMemoNo: Code[50];
        PPdate: Date;
        FreightCharge: Record "50018";
        Summary: Boolean;
        Losses: Boolean;
        Airline: Record "50021";

    local procedure GetPurchaseAmount(Mawb: Code[50];ChargeCode: Code[50]) PurchAmount: Decimal
    var
        PurchInvHeader: Record "122";
        PurchInvLine: Record "123";
        PurchCrMemoHdr2: Record "124";
        PurchCrMemoLine2: Record "125";
    begin
        InvNo12:='';
        Vendor:='';
        PurchAmount:=0;
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.",Mawb);
        PurchInvLine.SETRANGE(PurchInvLine."Charge Code",ChargeCode);
        IF PurchInvLine.FINDFIRST THEN BEGIN
          InvNo12:=PurchInvLine."Document No.";
          PurchInvHeader.GET(PurchInvLine."Document No.");
          PPdate:=PurchInvHeader."Posting Date";
          Vendor:=PurchInvHeader."Buy-from Vendor Name";
          IF PurchInvHeader."Currency Factor"=0 THEN BEGIN
            PurchAmount:=PurchInvLine.Amount;
          END ELSE BEGIN
            PurchAmount:=PurchInvLine.Amount/PurchInvHeader."Currency Factor";
          END;
        END ELSE BEGIN
          IF ChargeCode='14' THEN BEGIN
            PurchInvLine.RESET;
            PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.",Mawb);
            PurchInvLine.SETRANGE(PurchInvLine."Charge Code",'82');
            IF PurchInvLine.FINDFIRST THEN BEGIN
              InvNo12:=PurchInvLine."Document No.";
              PurchInvHeader.GET(PurchInvLine."Document No.");
              PPdate:=PurchInvHeader."Posting Date";
              Vendor:=PurchInvHeader."Buy-from Vendor Name";
              IF PurchInvHeader."Currency Factor"=0 THEN BEGIN
                PurchAmount:=PurchInvLine.Amount;
              END ELSE BEGIN
                PurchAmount:=PurchInvLine.Amount/PurchInvHeader."Currency Factor";
              END;
            END;
          END ELSE IF ChargeCode='82' THEN BEGIN
            PurchInvLine.RESET;
            PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.",Mawb);
            PurchInvLine.SETRANGE(PurchInvLine."Charge Code",'82');
            IF PurchInvLine.FINDFIRST THEN BEGIN
              PPdate:=PurchInvHeader."Posting Date";
              InvNo12:=PurchInvLine."Document No.";
              PurchInvHeader.GET(PurchInvLine."Document No.");
              Vendor:=PurchInvHeader."Buy-from Vendor Name";
              IF PurchInvHeader."Currency Factor"=0 THEN BEGIN
                PurchAmount:=PurchInvLine.Amount;
              END ELSE BEGIN
                PurchAmount:=PurchInvLine.Amount/PurchInvHeader."Currency Factor";
              END;
            END;
          END;
        END;
        EXIT(PurchAmount);
    end;

    local procedure GetSalesCreditMemoTotal(InvoiceNo: Code[50]) CreditMemoAmount: Decimal
    var
        SalesCrMemoHeader: Record "114";
        SalesCrMemoLine: Record "115";
    begin
        CreditMemoAmount:=0;
        CrMemoNo:='';
        SalesCrMemoHeader.RESET;
        SalesCrMemoHeader.SETRANGE(SalesCrMemoHeader."Applies-to Doc. No.",InvoiceNo);
        IF SalesCrMemoHeader.FIND('-') THEN BEGIN
          CrMemoNo:=SalesCrMemoHeader."No.";
          SalesCrMemoHeader.CALCFIELDS(SalesCrMemoHeader.Amount);
          CreditMemoAmount:=SalesCrMemoHeader.Amount/SalesCrMemoHeader."Currency Factor";
          //MESSAGE('Amount=%1, Currency=%2 Exchange Rate=%3 LCY =%4',SalesCrMemoHeader.Amount,SalesCrMemoHeader."Currency Code",FORMAT(1/(SalesCrMemoHeader."Currency Factor")),CreditMemoAMount);
        END;//Get Credit Memo Amount
        EXIT(-1*CreditMemoAmount);
    end;

    local procedure GetPurchaseCreditMemoTotal(MAWBNo: Code[50];Charge: Code[10]) PurchCrMemoAmnt: Decimal
    var
        PurchCrMemoHdr: Record "124";
        PurchInvLine1: Record "123";
        PurchCrMemoLine12: Record "125";
    begin
        PurchCrMemoLine12.RESET;
        PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Payment Voucher No.",MAWBNo);
        PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code",Charge);
        IF PurchCrMemoLine12.FINDFIRST THEN BEGIN
          PurchCrMemoHdr.GET(PurchCrMemoLine12."Document No.");
          IF PurchCrMemoHdr."Currency Factor"<>0 THEN
            PurchCrMemoAmnt:=PurchCrMemoLine12.Amount/PurchCrMemoHdr."Currency Factor"
          ELSE
            PurchCrMemoAmnt:=PurchCrMemoLine12.Amount;
        END ELSE BEGIN
          PurchCrMemoLine12.RESET;
          PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Payment Voucher No.",MAWBNo);
          IF Charge='14' THEN
            PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code",'82')
          ELSE
            PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code",'14');
          IF PurchCrMemoLine12.FINDFIRST THEN BEGIN
            PurchCrMemoHdr.GET(PurchCrMemoLine12."Document No.");
            IF PurchCrMemoHdr."Currency Factor"<>0 THEN
              PurchCrMemoAmnt:=PurchCrMemoLine12.Amount/PurchCrMemoHdr."Currency Factor"
            ELSE
              PurchCrMemoAmnt:=PurchCrMemoLine12.Amount;
          END;
        END;
    end;

    local procedure GetVendor()
    begin
    end;

    local procedure GetMawbCreditNote(MAWB23: Code[50]) TotalCredit: Decimal
    var
        InvHeader: Record "112";
    begin
        InvHeader.RESET;
        InvHeader.SETRANGE(InvHeader."MAWB No.",MAWB23);
        IF InvHeader.FINDSET THEN BEGIN
          REPEAT
            //TotalCredit+=GetSalesCreditMemoTotal(InvHeader."No.");
          UNTIL InvHeader.NEXT = 0;
        END;//Get all credit notes appleied to invoices with mawb23
        EXIT(TotalCredit);
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

    local procedure GetInvoiceLinesCount(MAWB2: Code[50];Inno: Code[50]) LinesCount: Integer
    var
        SalesInvoiceLine2: Record "113";
    begin
        SalesInvoiceLine2.RESET;
        SalesInvoiceLine2.SETRANGE(SalesInvoiceLine2."MAWB No.",MAWB2);
        SalesInvoiceLine2.SETRANGE(SalesInvoiceLine2."Document No.",Inno);
        IF SalesInvoiceLine2.FINDSET THEN BEGIN
          REPEAT
            LinesCount+=1;
          UNTIL SalesInvoiceLine2.NEXT = 0;
        END;
        EXIT(LinesCount);
    end;

    local procedure GetPurchCrMemoLine(PurchInvNo: Code[50];Amount: Decimal) LineCredit: Decimal
    var
        PurchCrMemoHdr1: Record "124";
        PurchCrMemoLine1: Record "125";
    begin
        LineCredit:=0;
        PurchCrMemoHdr1.RESET;
        PurchCrMemoHdr1.SETRANGE(PurchCrMemoHdr1."Applies-to Doc. No.",PurchInvNo);
        IF PurchCrMemoHdr1.FINDFIRST THEN BEGIN
          PurchCrMemoLine1.RESET;
          PurchCrMemoLine1.SETRANGE(PurchCrMemoLine1."Document No.",PurchCrMemoHdr1."No.");
          IF PurchCrMemoLine1.FINDFIRST THEN BEGIN
            IF PurchCrMemoHdr1."Currency Factor"<>0 THEN
              LineCredit:=PurchCrMemoLine1.Amount
            ELSE
              LineCredit:=PurchCrMemoLine1.Amount/PurchCrMemoHdr1."Currency Factor";
          END;
        END;//Get Credit memo lines
        EXIT(LineCredit);
    end;
}

