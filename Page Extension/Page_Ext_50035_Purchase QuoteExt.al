pageextension 50035 PurchaseQuoteExt extends "Purchase Quote"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Request for Quotation No."; Rec."Request for Quotation No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("No. of Archived Versions")
        {
            field("Validity Date"; Rec."Validity Date")
            {
                ApplicationArea = all;
            }
        }
    }
}