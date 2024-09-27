pageextension 50034 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Type)
        {
            field("Freight Charge Code"; Rec."Freight Charge Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
            }
            field("HAWB No."; Rec."HAWB No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Description 2")
        {
            Visible = false;
        }

        addafter("Line No.")
        {
            field("Cost Amount"; Rec."Cost Amount")
            {
                ApplicationArea = all;
            }
        }
        moveafter("VAT Prod. Posting Group"; "Gen. Bus. Posting Group")
        moveafter("Document No."; "Gen. Prod. Posting Group")
    }
}