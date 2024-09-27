pageextension 50008 PostedPurchInvoiceSubformExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Payment Voucher No."; Rec."Payment Voucher No.")
            {
                ApplicationArea = all;
            }
            field("Charge Code"; Rec."Charge Code")
            {
                ApplicationArea = all;
            }
        }
    }
}