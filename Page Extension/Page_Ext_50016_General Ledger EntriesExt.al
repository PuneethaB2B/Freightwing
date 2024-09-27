pageextension 50016 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    layout
    {
        modify("G/L Account Name")
        {
            Visible = true;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }

        moveafter(Description; "VAT Prod. Posting Group")
        moveafter("FA Entry No."; "Source Type")
        moveafter("Source Type"; "Source No.")
    }
}