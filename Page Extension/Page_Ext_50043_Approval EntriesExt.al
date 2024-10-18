pageextension 50043 ApprovalEntriesExt extends "Approval Entries"
{
    actions
    {
        addafter("&Delegate")
        {
            action(Preview)
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = PreviewChecks;
                PromotedCategory = Report;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    SalesHeader.RESET;
                    SalesHeader.SETRANGE("No.", Rec."Document No.");
                    IF SalesHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(Report::"MAWB Invoice TP", TRUE, FALSE, SalesHeader)
                    ELSE
                        MESSAGE('The Sales Invoice type cannot be previewed');
                END;
            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
}