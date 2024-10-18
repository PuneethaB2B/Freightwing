pageextension 50022 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        addafter("Payment Reference")
        {
            field("Adjusted Currency Factor"; Rec."Adjusted Currency Factor")
            {
                ApplicationArea = all;
            }
        }
    }
}