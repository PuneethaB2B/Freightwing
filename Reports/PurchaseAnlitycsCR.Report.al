report 50078 "Purchase Anlitycs.CR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseAnlitycsCR.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table125)
        {
            DataItemTableView = WHERE(Amount = FILTER(<> 0),
                                      Payment Voucher No.=FILTER(<>0));
            RequestFilterFields = "Posting Date","Document No.";
            column(No_PurchInvLine;"Purch. Cr. Memo Line"."No.")
            {
            }
            column(BuyfromVendorNo_PurchInvLine;"Purch. Cr. Memo Line"."Buy-from Vendor No.")
            {
            }
            column(DocumentNo_PurchInvLine;"Purch. Cr. Memo Line"."Document No.")
            {
            }
            column(PostingDate_PurchInvLine;"Purch. Cr. Memo Line"."Posting Date")
            {
            }
            column(VendName;VendName)
            {
            }
            column(GlName;"G/LName")
            {
            }
            column(PaymentVoucherNo_PurchInvLine;"Purch. Cr. Memo Line"."Payment Voucher No.")
            {
            }
            column(ShortcutDimension1Code_PurchInvLine;"Purch. Cr. Memo Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchInvLine;"Purch. Cr. Memo Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description_PurchInvLine;"Purch. Cr. Memo Line".Description)
            {
            }
            column(CustName;CustName)
            {
            }
            column(Amount_PurchInvLine;Amount)
            {
            }
            column(Quantity_PurchInvLine;"Purch. Cr. Memo Line".Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get cust name
                SaleRec.SETRANGE(SaleRec."MAWB No.","Purch. Cr. Memo Line"."Payment Voucher No.");
                IF SaleRec.FIND('-')THEN BEGIN
                   MyNo:=SaleRec."Document No.";
                   SalesRecHead.SETFILTER(SalesRecHead."No.",'%1',MyNo);
                   IF SalesRecHead.FIND('-')THEN
                     CustRec.SETRANGE(CustRec."No.",SalesRecHead."Bill-to Customer No.");
                     IF CustRec.FIND('-')THEN
                        CustName:=CustRec.Name;
                  END;
                 PuchHead.SETRANGE(PuchHead."No.","Purch. Cr. Memo Line"."Document No.");
                 IF PuchHead.FIND('-')THEN BEGIN
                   VendName:=PuchHead."Buy-from Vendor Name";
                 IF PuchHead."Currency Code"<>'' THEN BEGIN
                    CurrCode:=PuchHead."Currency Code" ;
                    CurrFactor:=PuchHead."Currency Factor";
                    IF CurrCode = '' THEN
                       Amount:=("Purch. Cr. Memo Line".Amount*-1)
                    ELSE
                      Amount:= ROUND(
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            "Posting Date",CurrCode,
                            Amount,CurrFactor));
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
        Vend: Record "23";
        "G/LRec": Record "15";
        CustRec: Record "18";
        VendName: Text;
        "G/LName": Text;
        Doctype: Text;
        CustName: Text;
        Creditmemo: Record "125";
        CreditMemoRec: Record "125" temporary;
        CreditHeader: Record "124";
        MyNo: Code[30];
        SaleRec: Record "113";
        SalesRecHead: Record "112";
        PuchHead: Record "124";
        CurrRate: Record "330";
        CurrCode: Code[30];
        XRate: Decimal;
        Amount: Decimal;
        Amount2: Decimal;
        CurrFactor: Decimal;
        CurrExchRate: Record "330";
}

