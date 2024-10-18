pageextension 50031 SalesInvoiceExt extends "Sales Invoice"
{
    actions
    {
        modify(PostAndSend)
        {
            Promoted = true;
            PromotedIsBig = true;
            PromotedCategory = Process;
        }
        addafter("Remove From Job Queue")
        {
            action(Print)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        IF CONFIRM('Print General Sales Invoice Format') THEN BEGIN
                            REPORT.RUNMODAL(Report::"General Sales Invoice", TRUE, FALSE, SalesInvoiceHeader);
                        END ELSE BEGIN
                            REPORT.RUNMODAL(Report::"MAWB Invoice TP", TRUE, FALSE, SalesInvoiceHeader);
                        END;
                    END;
                END;
            }
        }
    }
    var
        SalesInvoiceHeader: Record "Sales Header";

}