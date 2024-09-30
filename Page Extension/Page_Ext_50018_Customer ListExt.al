pageextension 50018 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter("Location Code")
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Balance (LCY)")
        {
            field(Balance; Rec.Balance)
            {
                ApplicationArea = all;
            }
        }
        moveafter("Shipping Agent Code"; "Balance (LCY)")
    }

    actions
    {
        modify(CustomerLedgerEntries)
        {
            PromotedIsBig = true;
            Promoted = true;
        }
        addafter(FinanceReports)
        {
            group("Customer Statements")
            {
                Image = Report;
                action("Customer Statement By Email")
                {
                    Image = Report;
                    RunObject = codeunit 50034;
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //gCduReportOperation.RUN;
                    end;
                }
                action("Customer Statement")
                {
                    captionML = ENU = 'Customer Statement';
                    Image = Report;
                    RunObject = report 116;
                    ApplicationArea = All;
                }

            }
        }
    }
    VAR
        gCduReportOperation: Codeunit 50034;
}