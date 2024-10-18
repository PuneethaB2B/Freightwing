pageextension 50013 ChartOfAccountsExt extends "Chart Of Accounts"
{
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = true;
            PromotedIsBig = true;
            ApplicationArea = all;
        }
    }
}