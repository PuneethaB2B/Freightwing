pageextension 50026 BankAccountListExt extends "Bank Account List"
{
    actions
    {
        modify("Ledger E&ntries")
        {
            ApplicationArea = all;
            Promoted = true;
            PromotedIsBig = true;
        }
    }
}