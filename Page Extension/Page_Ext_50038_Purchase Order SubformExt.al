pageextension 50038 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        moveafter(ShortcutDimCode8; "Gen. Bus. Posting Group")
        moveafter("Gen. Bus. Posting Group"; "VAT Bus. Posting Group")
        moveafter("VAT Bus. Posting Group"; "Gen. Prod. Posting Group")
    }

}
