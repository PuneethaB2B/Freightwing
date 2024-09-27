pageextension 50027 BankAccountLedgerEntriesExt extends "Bank Account Ledger Entries"
{
    layout
    {
        addafter(Open)
        {
            field("Statement Status"; Rec."Statement Status")
            {
                ApplicationArea = all;
            }
            field("Statement No."; Rec."Statement No.")
            {
                ApplicationArea = all;
            }
            field(statementdate; statementdate)
            {
                CaptionML = ENU = 'Statement Date';
                ApplicationArea = all;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        statementdate := 0D;
        BankAccountStatement.RESET;
        BankAccountStatement.SETRANGE(BankAccountStatement."Bank Account No.", Rec."Bank Account No.");
        BankAccountStatement.SETRANGE(BankAccountStatement."Statement No.", Rec."Statement No.");
        IF BankAccountStatement.FINDFIRST THEN
            statementdate := BankAccountStatement."Statement Date";
    END;

    var
        statementdate: Date;
        BankAccountStatement: Record 275;
}
