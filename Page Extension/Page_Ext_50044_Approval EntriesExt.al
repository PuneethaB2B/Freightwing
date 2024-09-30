pageextension 50044 ApprovalEntriesExt extends "Approval Entries"
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
                        REPORT.RUNMODAL(50039, TRUE, FALSE, SalesHeader)
                    ELSE
                        MESSAGE('The Sales Invoice type cannot be previewed');
                END;
            }
        }
    }

    var
        SalesHeader: Record "Sales Header";
}