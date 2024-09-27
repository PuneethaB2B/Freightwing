pageextension 50028 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Shipper Code"; Rec."Shipper Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Remaining Quantity")
        {
            field(Weight; Rec.Weight)
            {
                ApplicationArea = all;
            }
        }
    }
}