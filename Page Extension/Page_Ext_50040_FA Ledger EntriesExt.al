pageextension 50040 FALedgerEntriesExt extends "FA Ledger Entries"
{
    layout
    {
        addafter("FA Posting Type")
        {
            field("FA Subclass Code"; Rec."FA Subclass Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Entry No.")
        {
            field("Part of Book Value"; Rec."Part of Book Value")
            {
                ApplicationArea = all;
            }
            field("Part of Depreciable Basis"; Rec."Part of Depreciable Basis")
            {
                ApplicationArea = all;
            }
            field("Disposal Calculation Method"; Rec."Disposal Calculation Method")
            {
                ApplicationArea = all;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        modify(ReverseTransaction)
        {
            ApplicationArea = all;
            Visible = false;
        }
    }
}