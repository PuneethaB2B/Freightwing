report 50078 "Purchase Anlitycs.CR"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PurchaseAnlitycsCR.rdl';
    ApplicationArea = All;
    UsageCategory=ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            DataItemTableView = WHERE(Amount = FILTER(<> 0),
                                      "Payment Voucher No." = FILTER(<> 0));
            RequestFilterFields = "Posting Date", "Document No.";
            column(No_PurchInvLine; "Purch. Cr. Memo Line"."No.")
            {
            }
            column(BuyfromVendorNo_PurchInvLine; "Purch. Cr. Memo Line"."Buy-from Vendor No.")
            {
            }
            column(DocumentNo_PurchInvLine; "Purch. Cr. Memo Line"."Document No.")
            {
            }
            column(PostingDate_PurchInvLine; "Purch. Cr. Memo Line"."Posting Date")
            {
            }
            column(VendName; VendName)
            {
            }
            column(GlName; "G/LName")
            {
            }
            column(PaymentVoucherNo_PurchInvLine; "Purch. Cr. Memo Line"."Payment Voucher No.")
            {
            }
            column(ShortcutDimension1Code_PurchInvLine; "Purch. Cr. Memo Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchInvLine; "Purch. Cr. Memo Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description_PurchInvLine; "Purch. Cr. Memo Line".Description)
            {
            }
            column(CustName; CustName)
            {
            }
            column(Amount_PurchInvLine; Amount)
            {
            }
            column(Quantity_PurchInvLine; "Purch. Cr. Memo Line".Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get cust name
                SaleRec.SETRANGE(SaleRec."MAWB No.", "Purch. Cr. Memo Line"."Payment Voucher No.");
                IF SaleRec.FIND('-') THEN BEGIN
                    MyNo := SaleRec."Document No.";
                    SalesRecHead.SETFILTER(SalesRecHead."No.", '%1', MyNo);
                    IF SalesRecHead.FIND('-') THEN
                        CustRec.SETRANGE(CustRec."No.", SalesRecHead."Bill-to Customer No.");
                    IF CustRec.FIND('-') THEN
                        CustName := CustRec.Name;
                END;
                PuchHead.SETRANGE(PuchHead."No.", "Purch. Cr. Memo Line"."Document No.");
                IF PuchHead.FIND('-') THEN BEGIN
                    VendName := PuchHead."Buy-from Vendor Name";
                    IF PuchHead."Currency Code" <> '' THEN BEGIN
                        CurrCode := PuchHead."Currency Code";
                        CurrFactor := PuchHead."Currency Factor";
                        IF CurrCode = '' THEN
                            Amount := ("Purch. Cr. Memo Line".Amount * -1)
                        ELSE
                            Amount := ROUND(
                                CurrExchRate.ExchangeAmtFCYToLCY(
                                  "Posting Date", CurrCode,
                                  Amount, CurrFactor));
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Vend: Record Vendor;
        "G/LRec": Record "G/L Account";
        CustRec: Record Customer;
        VendName: Text;
        "G/LName": Text;
        Doctype: Text;
        CustName: Text;
        Creditmemo: Record "Purch. Cr. Memo Line";
        CreditMemoRec: Record "Purch. Cr. Memo Line" temporary;
        CreditHeader: Record "Purch. Cr. Memo Hdr.";
        MyNo: Code[30];
        SaleRec: Record "Sales Invoice Line";
        SalesRecHead: Record "Sales Invoice Header";
        PuchHead: Record "Purch. Cr. Memo Hdr.";
        CurrRate: Record "Currency Exchange Rate";
        CurrCode: Code[30];
        XRate: Decimal;
        Amount: Decimal;
        Amount2: Decimal;
        CurrFactor: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
}

