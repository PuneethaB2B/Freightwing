pageextension 50025 BankAccountListExt extends "Bank Account List"
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