pageextension 50029 GeneralJournalExt extends "General Journal"
{
    layout
    {
        addafter("Applies-to Doc. No.")
        {
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = all;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Incoming Document Entry No.")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = true;
        }
        modify("Currency Code")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        moveafter("Campaign No."; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter("Credit Amount"; Amount)
        moveafter("Currency Code"; "Amount (LCY)")
        moveafter("Amount (LCY)"; "Bal. Account Type")
        moveafter("Bal. Account Type"; "Bal. Account No.")
        moveafter("Bal. Account No."; "VAT Amount")
    }
}