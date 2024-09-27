pageextension 50019 CustomerLedgerEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Remaining Amt. (LCY)")
        {
            field("Adjusted Currency Factor"; Rec."Adjusted Currency Factor")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Adjusted Currency Factor"; "Salesperson Code")
    }
}