pageextension 50008 PostedPurchCrMemoSubformExt extends "Posted Purch. Cr. Memo Subform"
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