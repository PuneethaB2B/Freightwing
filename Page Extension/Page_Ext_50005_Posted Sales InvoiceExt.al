pageextension 50005 PostedSalesInvoiceExt extends "Posted Sales Invoice"
{
    layout
    {
        addbefore("No.")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("No.")
        {
            field("HAWB No."; Rec."HAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Order No.")
        {
            field("CC/PP"; Rec."CC/PP")
            {
                ApplicationArea = all;
            }
        }
        addafter("No. Printed")
        {
            field(Commodity; Rec.Commodity)
            {
                ApplicationArea = all;
            }
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = all;
            }
            field("Invoice Number"; Rec."Invoice Number")
            {
                ApplicationArea = all;
            }
            field("Agreed Rate"; Rec."Agreed Rate")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Control1900383207)
        {
            part(QRCode; "QR Code.")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action("Import Invoice")
            {
                Promoted = true;
                Image = Print;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(Report::"Posted Import Invoice", TRUE, FALSE, SalesInvoiceHeader);
                END;
            }
            action("General Invoice")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN
                        REPORT.RUNMODAL(50128, TRUE, FALSE, SalesInvoiceHeader);
                END;
            }
            action("&Print")
            {
                CaptionML = ENU = '&Print';
                Ellipsis = true;
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                VAR
                    SalesInvHeader: Record "Sales Invoice Header";
                BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        MAWBHeader.RESET;
                        MAWBHeader.SETRANGE(MAWBHeader."No.", Rec."MAWB No.");
                        IF MAWBHeader.FINDFIRST THEN BEGIN
                            IF MAWBHeader."Has Houses" THEN BEGIN
                                REPORT.RUNMODAL(Report::"Posted MAWB Invoice", TRUE, FALSE, SalesInvoiceHeader);
                            END ELSE BEGIN
                                REPORT.RUNMODAL(Report::"MAWB Invoice Posted", TRUE, FALSE, SalesInvoiceHeader)
                            END;//Has no houses
                        END ELSE
                            MESSAGE('Documentation for MAWB %1 NOT Found', Rec."MAWB No.");
                        ;//MAWB HEader
                    END;//Sales Invoice Header
                END;
            }
            action("Create Tims")
            {
                Caption = 'Create Tims';
                ApplicationArea = all;
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TIMSManager: Codeunit "TIMS Manager.";
                begin
                    TIMSManager.ProcessSalesDocument(Rec);
                end;
            }
            action("Generate JSON")
            {
                Caption = 'Generate JSON';
                ApplicationArea = all;
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TIMSManager: Codeunit "TIMS Manager.";
                begin
                    TIMSManager.GetJSONData(Rec);
                end;
            }
        }
    }
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        MAWBHeader: Record "MAWB Header 2";
}