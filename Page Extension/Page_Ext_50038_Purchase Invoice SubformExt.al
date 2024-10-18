pageextension 50038 PurchInvoiceSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Charge Code"; Rec."Charge Code")
            {
                ApplicationArea = all;
            }
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Job No.")
        {
            field("Freight Handling Type"; Rec."Freight Handling Type")
            {
                ApplicationArea = all;
            }
        }
        moveafter(ShortcutDimCode8; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "VAT Bus. Posting Group")
    }
}