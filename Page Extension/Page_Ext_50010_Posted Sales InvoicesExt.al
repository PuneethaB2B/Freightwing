pageextension 50010 PostedSalesInvoicesExt extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
            }
        }
        addafter(Amount)
        {
            field("Total Weight"; Rec."Total Weight")
            {
                ApplicationArea = all;
            }
            field(Commodity; Rec.Commodity)
            {
                ApplicationArea = all;
            }
        }
        addafter("Shipment Method Code")
        {
            field("TIMS Time"; Rec."TIMS Time")
            {
                ApplicationArea = all;
            }
            field("QR Code"; Rec."QR Code")
            {
                ApplicationArea = all;
            }
        }
        moveafter("No."; "Posting Date")
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
        addlast("&Invoice")
        {
            action("Import Invoice")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50106, TRUE, FALSE, SalesInvoiceHeader);
                    END;
                    ;
                end;
            }
            action("General Invoice")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        REPORT.RUNMODAL(50093, TRUE, FALSE, SalesInvoiceHeader);
                    END;
                end;
            }
        }
        modify(Print)
        {
            trigger OnAfterAction()
            begin
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    MAWBHeader.RESET;
                    MAWBHeader.SETRANGE(MAWBHeader."No.", Rec."MAWB No.");
                    IF MAWBHeader.FINDFIRST THEN BEGIN
                        IF MAWBHeader."Has Houses" THEN BEGIN
                            REPORT.RUNMODAL(50070, TRUE, FALSE, SalesInvoiceHeader);
                        END ELSE BEGIN
                            REPORT.RUNMODAL(50064, TRUE, FALSE, SalesInvoiceHeader)
                        END;//Has no houses
                    END ELSE
                        MESSAGE('Documentation for MAWB %1 NOT Found', Rec."MAWB No.");
                    ;//MAWB HEader
                END;//Sales Invoice Header
            end;
        }
        addafter(Navigate)
        {
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
                    TIMSManager: Codeunit 50035;
                begin
                    TIMSManager.ProcessSalesDocument(Rec);
                end;
            }
        }
    }
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        MAWBHeader: Record "MAWB Header 2";

}