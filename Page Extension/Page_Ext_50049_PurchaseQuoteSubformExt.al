pageextension 50049 PurchaseQuoteSubformExt extends "Purchase Quote Subform"
{
    layout
    {

        moveafter(ShortcutDimCode8; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "Gen. Prod. Posting Group")
        moveafter("Gen. Prod. Posting Group"; "VAT Bus. Posting Group")
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}