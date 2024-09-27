pageextension 50051 PurchCrMemSubformExt extends "Purch. Cr. Memo Subform"
{
    layout
    {
        addafter("Return Reason Code")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                Caption = 'MAWB No.';
                ApplicationArea = All;
            }
        }
    }

   
}