report 50076 "Purchase Anlitycs."
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseAnlitycs.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table123)
        {
            DataItemTableView = WHERE(Payment Voucher No.=FILTER(<>O),
                                      Amount=FILTER(<>0));
            RequestFilterFields = "Posting Date","Document No.";
            column(No_PurchInvLine;"Purch. Inv. Line"."No.")
            {
            }
            column(BuyfromVendorNo_PurchInvLine;"Purch. Inv. Line"."Buy-from Vendor No.")
            {
            }
            column(DocumentNo_PurchInvLine;"Purch. Inv. Line"."Document No.")
            {
            }
            column(PostingDate_PurchInvLine;"Purch. Inv. Line"."Posting Date")
            {
            }
            column(VendName;VendName)
            {
            }
            column(GlName;"G/LName")
            {
            }
            column(PaymentVoucherNo_PurchInvLine;"Purch. Inv. Line"."Payment Voucher No.")
            {
            }
            column(ShortcutDimension1Code_PurchInvLine;"Purch. Inv. Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchInvLine;"Purch. Inv. Line"."Shortcut Dimension 2 Code")
            {
            }
            column(Description_PurchInvLine;"Purch. Inv. Line".Description)
            {
            }
            column(CustName;CustName)
            {
            }
            column(Amount_PurchInvLine;Amount)
            {
            }
            column(Quantity_PurchInvLine;"Purch. Inv. Line".Quantity)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Get cust name
                SaleRec.SETRANGE(SaleRec."MAWB No.","Purch. Inv. Line"."Payment Voucher No.");
                IF SaleRec.FIND('-')THEN BEGIN
                   MyNo:=SaleRec."Document No.";
                   SalesRecHead.SETFILTER(SalesRecHead."No.",'%1',MyNo);
                   IF SalesRecHead.FIND('-')THEN
                     CustRec.SETRANGE(CustRec."No.",SalesRecHead."Bill-to Customer No.");
                     IF CustRec.FIND('-')THEN
                        CustName:=CustRec.Name;
                  END;
                 PuchHead.SETRANGE(PuchHead."No.","Purch. Inv. Line"."Document No.");
                 IF PuchHead.FIND('-')THEN BEGIN
                   VendName:=PuchHead."Pay-to Name";
                 IF PuchHead."Currency Code"<>'' THEN BEGIN
                    CurrCode:=PuchHead."Currency Code" ;
                    CurrFactor:=PuchHead."Currency Factor";
                    IF CurrCode = '' THEN
                       Amount:="Purch. Inv. Line".Amount
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
        PuchHead: Record "122";
        CurrRate: Record "330";
        CurrCode: Code[30];
        XRate: Decimal;
        Amount: Decimal;
        CurrFactor: Decimal;
        CurrExchRate: Record "330";
}

