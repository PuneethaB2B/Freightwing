pageextension 50032 SalesInvoiceExt extends "Sales Invoice"
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
                            REPORT.RUNMODAL(50065, TRUE, FALSE, SalesInvoiceHeader);
                        END ELSE BEGIN
                            REPORT.RUNMODAL(50039, TRUE, FALSE, SalesInvoiceHeader);
                        END;
                    END;
                END;
            }
        }
    }
    var
        SalesInvoiceHeader: Record 36;

}