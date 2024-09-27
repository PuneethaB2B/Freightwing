pageextension 50043 ChartofAccountsGLExt extends "Chart of Accounts (G/L)"
{
    actions
    {
        modify(AccountGeneralLedgerEntries)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
    }
}