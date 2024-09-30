report 50091 "Purch. Sale Comparison ii"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PurchSaleComparisonii.rdl';
    Caption = 'Purch. Sale Comparison';
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {
            DataItemTableView = WHERE("MAWB No." = FILTER(<> ''));
            RequestFilterFields = "Airline Code", "MAWB No.";
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
            column(MAWBCredit; MawbCredit)
            {
            }
            column(NoHouses; NoHouses)
            {
            }
            column(AirlineName; Airline.Name)
            {
            }
            column(Summary; Summary)
            {
            }
            column(Loss; Losses)
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "External Document No." = FIELD("MAWB No.");
                RequestFilterFields = "Bill-to Customer No.", "Posting Date";
                column(PurchCreditMemoAmount; PurchCreditMemoAmount)
                {
                }
                column(CrMemoNo; CrMemoNo)
                {
                }
                column(Lines; Lines)
                {
                }
                column(SelltoCustomerName_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer Name")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(CurrencyFactor_SalesInvoiceHeader; "Sales Invoice Header"."Currency Factor")
                {
                }
                column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
                {
                }
                column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(BilltoName2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name 2")
                {
                }
                column(BilltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address")
                {
                }
                column(BilltoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address 2")
                {
                }
                column(BilltoCity_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to City")
                {
                }
                column(BilltoContact_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Contact")
                {
                }
                column(YourReference_SalesInvoiceHeader; "Sales Invoice Header"."Your Reference")
                {
                }
                column(ShiptoCode_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Code")
                {
                }
                column(ShiptoName_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name")
                {
                }
                column(ShiptoName2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Name 2")
                {
                }
                column(ShiptoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address")
                {
                }
                column(ShiptoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Address 2")
                {
                }
                column(ShiptoCity_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to City")
                {
                }
                column(ShiptoContact_SalesInvoiceHeader; "Sales Invoice Header"."Ship-to Contact")
                {
                }
                column(OrderDate_SalesInvoiceHeader; "Sales Invoice Header"."Order Date")
                {
                }
                column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
                {
                }
                column(ShipmentDate_SalesInvoiceHeader; "Sales Invoice Header"."Shipment Date")
                {
                }
                column(PostingDescription_SalesInvoiceHeader; "Sales Invoice Header"."Posting Description")
                {
                }
                column(SalesCreditMemoAmount; SalesCreditMemoAmount)
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.")
                                        ORDER(Ascending);
                    column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
                    {
                    }
                    column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                    {
                    }
                    column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                    {
                    }
                    column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                    {
                    }
                    column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                    {
                    }
                    column(LocationCode_SalesInvoiceLine; "Sales Invoice Line"."Location Code")
                    {
                    }
                    column(PostingGroup_SalesInvoiceLine; "Sales Invoice Line"."Posting Group")
                    {
                    }
                    column(ShipmentDate_SalesInvoiceLine; "Sales Invoice Line"."Shipment Date")
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }
                    column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(UnitCostLCY_SalesInvoiceLine; "Sales Invoice Line"."Unit Cost (LCY)")
                    {
                    }
                    column(VAT_SalesInvoiceLine; "Sales Invoice Line"."VAT %")
                    {
                    }
                    column(LineDiscount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount %")
                    {
                    }
                    column(LineDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount Amount")
                    {
                    }
                    column(Amount_SalesInvoiceLine; LineMant)
                    {
                    }
                    column(PurchaseAmount; PurchaseAmount)
                    {
                    }
                    column(LineCreditPurch; LineCreditPurch)
                    {
                    }
                    column(InvNo12; InvNo12)
                    {
                    }
                    column(Vendor; Vendor)
                    {
                    }
                    column(HAWBNo_SalesInvoiceLine; "Sales Invoice Line"."HAWB No.")
                    {
                    }
                    column(PPdate; PPdate)
                    {
                    }
                    column(SalesLineAmntLCY; SaleLineAmntLCY)
                    {
                    }
                    column(PurchLineAmntLCY; PurchLineAmntLCY)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        PurchCreditMemoAmount := 0;
                        PurchaseAmount := 0;
                        PPdate := 0D;
                        LineMant := 0;
                        IF FreightCharge.GET("Sales Invoice Line"."Freight Charge Code") THEN;
                        IF FreightCharge."Split On" = FreightCharge."Split On"::Weights THEN BEGIN
                            PurchaseAmount := "Sales Invoice Line"."Split Factor" * GetPurchaseAmount("Sales Invoice Line"."MAWB No.", "Sales Invoice Line"."Freight Charge Code");
                            PurchCreditMemoAmount := "Sales Invoice Line"."Split Factor" * GetPurchaseCreditMemoTotal("Sales Invoice Line"."MAWB No.", "Sales Invoice Line"."Freight Charge Code");
                        END ELSE BEGIN
                            IF "Sales Invoice Line"."Split Factor" <> 0 THEN BEGIN
                                PurchaseAmount := GetPurchaseAmount("Sales Invoice Line"."MAWB No.", "Sales Invoice Line"."Freight Charge Code") / "Sales Invoice Line"."Split Factor";
                                PurchCreditMemoAmount := GetPurchaseCreditMemoTotal("Sales Invoice Line"."MAWB No.", "Sales Invoice Line"."Freight Charge Code") / "Sales Invoice Line"."Split Factor";
                            END;
                        END;
                        Header.GET("Sales Invoice Line"."Document No.");
                        IF Header."Currency Factor" <> 0 THEN
                            SaleLineAmntLCY := "Sales Invoice Line".Amount / Header."Currency Factor"
                        ELSE
                            SaleLineAmntLCY := "Sales Invoice Line".Amount;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Lines := 0;
                    SalesCreditMemoAmount := 0;
                    Lines := GetInvoiceLinesCount("Sales Invoice Header"."MAWB No.", "Sales Invoice Header"."No.");
                    IF Lines = 0 THEN
                        Lines := 1;
                    SalesCreditMemoAmount := GetSalesCreditMemoTotal("Sales Invoice Header"."No.") / Lines;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NoHouses := 0;
                NoHouses := GetNumberofHouses("MAWB Receipt"."MAWB No.");
                IF NoHouses = 0 THEN
                    NoHouses := 1;
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
                    field("Show Summary Only"; Summary)
                    {
                        ApplicationArea = All;
                    }
                    field("Show Loss Only"; Losses)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Losses THEN
                                Summary := TRUE
                            ELSE
                                Summary := FALSE;
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
        FreightCharge: Record "Freight Charge";
        Summary: Boolean;
        Losses: Boolean;
        Airline: Record Airline;
        LineMant: Decimal;
        Header: Record "Sales Invoice Header";
        SaleLineAmntLCY: Decimal;
        PurchLineAmntLCY: Decimal;

    local procedure GetPurchaseAmount(Mawb: Code[50]; ChargeCode: Code[50]) PurchAmount: Decimal
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoHdr2: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine2: Record "Purch. Cr. Memo Line";
    begin
        InvNo12 := '';
        Vendor := '';
        PurchLineAmntLCY := 0;
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.", Mawb);
        PurchInvLine.SETRANGE(PurchInvLine."Charge Code", ChargeCode);
        IF PurchInvLine.FINDFIRST THEN BEGIN
            InvNo12 := PurchInvLine."Document No.";
            PurchInvHeader.GET(PurchInvLine."Document No.");
            PPdate := PurchInvHeader."Posting Date";
            Vendor := PurchInvHeader."Buy-from Vendor Name";
            IF PurchInvHeader."Currency Factor" = 0 THEN BEGIN
                PurchLineAmntLCY := PurchInvLine.Amount;
            END ELSE BEGIN
                PurchLineAmntLCY := PurchInvLine.Amount / PurchInvHeader."Currency Factor";
            END;
        END ELSE BEGIN
            IF ChargeCode = '14' THEN BEGIN
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.", Mawb);
                PurchInvLine.SETRANGE(PurchInvLine."Charge Code", '82');
                IF PurchInvLine.FINDFIRST THEN BEGIN
                    InvNo12 := PurchInvLine."Document No.";
                    PurchInvHeader.GET(PurchInvLine."Document No.");
                    PPdate := PurchInvHeader."Posting Date";
                    Vendor := PurchInvHeader."Buy-from Vendor Name";
                    IF PurchInvHeader."Currency Factor" = 0 THEN BEGIN
                        PurchAmount := PurchInvLine.Amount;
                    END ELSE BEGIN
                        PurchAmount := PurchInvLine.Amount / PurchInvHeader."Currency Factor";
                    END;
                END;
            END ELSE IF ChargeCode = '82' THEN BEGIN
                PurchInvLine.RESET;
                PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.", Mawb);
                PurchInvLine.SETRANGE(PurchInvLine."Charge Code", '82');
                IF PurchInvLine.FINDFIRST THEN BEGIN
                    PPdate := PurchInvHeader."Posting Date";
                    InvNo12 := PurchInvLine."Document No.";
                    PurchInvHeader.GET(PurchInvLine."Document No.");
                    Vendor := PurchInvHeader."Buy-from Vendor Name";
                    IF PurchInvHeader."Currency Factor" = 0 THEN BEGIN
                        PurchLineAmntLCY := PurchInvLine.Amount;
                    END ELSE BEGIN
                        PurchLineAmntLCY := PurchInvLine.Amount / PurchInvHeader."Currency Factor";
                    END;
                END;
            END;
        END;
        EXIT(PurchLineAmntLCY);
    end;

    local procedure GetSalesCreditMemoTotal(InvoiceNo: Code[50]) CreditMemoAmount: Decimal
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        CreditMemoAmount := 0;
        CrMemoNo := '';
        SalesCrMemoHeader.RESET;
        SalesCrMemoHeader.SETRANGE(SalesCrMemoHeader."Applies-to Doc. No.", InvoiceNo);
        IF SalesCrMemoHeader.FIND('-') THEN BEGIN
            CrMemoNo := SalesCrMemoHeader."No.";
            SalesCrMemoHeader.CALCFIELDS(SalesCrMemoHeader.Amount);
            IF SalesCrMemoHeader."Currency Factor" <> 0 THEN
                CreditMemoAmount := SalesCrMemoHeader.Amount / SalesCrMemoHeader."Currency Factor"
            ELSE
                CreditMemoAmount := SalesCrMemoHeader.Amount;
            //MESSAGE('Amount=%1, Currency=%2 Exchange Rate=%3 LCY =%4',SalesCrMemoHeader.Amount,SalesCrMemoHeader."Currency Code",FORMAT(1/(SalesCrMemoHeader."Currency Factor")),CreditMemoAMount);
        END;//Get Credit Memo Amount
        EXIT(-1 * CreditMemoAmount);
    end;

    local procedure GetPurchaseCreditMemoTotal(MAWBNo: Code[50]; Charge: Code[10]) PurchCrMemoAmnt: Decimal
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchInvLine1: Record "Purch. Inv. Line";
        PurchCrMemoLine12: Record "Purch. Cr. Memo Line";
    begin
        PurchCrMemoLine12.RESET;
        PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Payment Voucher No.", MAWBNo);
        PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code", Charge);
        IF PurchCrMemoLine12.FINDFIRST THEN BEGIN
            PurchCrMemoHdr.GET(PurchCrMemoLine12."Document No.");
            IF PurchCrMemoHdr."Currency Factor" <> 0 THEN
                PurchCrMemoAmnt := PurchCrMemoLine12.Amount / PurchCrMemoHdr."Currency Factor"
            ELSE
                PurchCrMemoAmnt := PurchCrMemoLine12.Amount;
        END ELSE BEGIN
            PurchCrMemoLine12.RESET;
            PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Payment Voucher No.", MAWBNo);
            IF Charge = '14' THEN
                PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code", '82')
            ELSE
                PurchCrMemoLine12.SETRANGE(PurchCrMemoLine12."Charge Code", '14');
            IF PurchCrMemoLine12.FINDFIRST THEN BEGIN
                PurchCrMemoHdr.GET(PurchCrMemoLine12."Document No.");
                IF PurchCrMemoHdr."Currency Factor" <> 0 THEN
                    PurchCrMemoAmnt := PurchCrMemoLine12.Amount / PurchCrMemoHdr."Currency Factor"
                ELSE
                    PurchCrMemoAmnt := PurchCrMemoLine12.Amount;
            END;
        END;
    end;

    local procedure GetVendor()
    begin
    end;

    local procedure GetMawbCreditNote(MAWB23: Code[50]) TotalCredit: Decimal
    var
        InvHeader: Record "Sales Invoice Header";
    begin
        InvHeader.RESET;
        InvHeader.SETRANGE(InvHeader."MAWB No.", MAWB23);
        IF InvHeader.FINDSET THEN BEGIN
            REPEAT
            //TotalCredit+=GetSalesCreditMemoTotal(InvHeader."No.");
            UNTIL InvHeader.NEXT = 0;
        END;//Get all credit notes appleied to invoices with mawb23
        EXIT(TotalCredit);
    end;

    local procedure GetNumberofHouses(mawb24: Code[50]) Houses: Integer
    var
        HAWBLine: Record "HAWB Line";
    begin
        HAWBLine.RESET;
        HAWBLine.SETRANGE(HAWBLine."MAWB No.", mawb24);
        //MESSAGE(mawb24);
        IF HAWBLine.FINDSET THEN BEGIN
            REPEAT
                Houses += 1;
            //MESSAGE('%1',Houses);
            UNTIL HAWBLine.NEXT = 0;
        END;//Count Houses
        IF Houses = 0 THEN
            Houses := 1;

        EXIT(Houses);
    end;

    local procedure GetInvoiceLinesCount(MAWB2: Code[50]; Inno: Code[50]) LinesCount: Integer
    var
        SalesInvoiceLine2: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine2.RESET;
        SalesInvoiceLine2.SETRANGE(SalesInvoiceLine2."MAWB No.", MAWB2);
        SalesInvoiceLine2.SETRANGE(SalesInvoiceLine2."Document No.", Inno);
        IF SalesInvoiceLine2.FINDSET THEN BEGIN
            REPEAT
                LinesCount += 1;
            UNTIL SalesInvoiceLine2.NEXT = 0;
        END;
        EXIT(LinesCount);
    end;

    local procedure GetPurchCrMemoLine(PurchInvNo: Code[50]; Amount: Decimal) LineCredit: Decimal
    var
        PurchCrMemoHdr1: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine1: Record "Purch. Cr. Memo Line";
    begin
        LineCredit := 0;
        PurchCrMemoHdr1.RESET;
        PurchCrMemoHdr1.SETRANGE(PurchCrMemoHdr1."Applies-to Doc. No.", PurchInvNo);
        IF PurchCrMemoHdr1.FINDFIRST THEN BEGIN
            PurchCrMemoLine1.RESET;
            PurchCrMemoLine1.SETRANGE(PurchCrMemoLine1."Document No.", PurchCrMemoHdr1."No.");
            IF PurchCrMemoLine1.FINDFIRST THEN BEGIN
                IF PurchCrMemoHdr1."Currency Factor" <> 0 THEN
                    LineCredit := PurchCrMemoLine1.Amount
                ELSE
                    LineCredit := PurchCrMemoLine1.Amount / PurchCrMemoHdr1."Currency Factor";
            END;
        END;//Get Credit memo lines
        EXIT(LineCredit);
    end;
}

