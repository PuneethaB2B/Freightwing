pageextension 50012 PostedPurchaseInvoicesExt extends "Posted Purchase Invoices"
{
    layout
    {

        addafter("Payment Method Code")
        {
            field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
            {
                ApplicationArea = all;
            }
            field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
            {
                ApplicationArea = all;
            }

        }
        moveafter("No."; "Posting Date")
        moveafter("Pay-to Contact"; "Vendor Invoice No.")
    }
}