pageextension 50000 SalesCreditMemoExt extends "Sales Credit Memo"
{
    actions
    {

        modify(Post)
        {
            trigger OnAfterAction()
            begin
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."Applies-to Doc. No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    MAWBReceipt.RESET;
                    MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", SalesInvoiceHeader."External Document No.");
                    IF MAWBReceipt.FINDFIRST THEN BEGIN
                        MAWBReceipt.Invoiced := FALSE;
                        MAWBReceipt.MODIFY;
                    END;
                END;
            end;
        }
    }

    var
        MAWBReceipt: Record "MAWB Receipt";
        SalesInvoiceHeader: Record "Sales Invoice Header";
}

