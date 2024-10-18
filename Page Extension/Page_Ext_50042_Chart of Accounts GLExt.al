pageextension 50042 ChartofAccountsGLExt extends "Chart of Accounts (G/L)"
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