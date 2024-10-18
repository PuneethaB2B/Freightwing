pageextension 50021 PaymentJournalExt extends "Payment Journal"
{
    layout
    {
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                CASE rec."Account Type" OF
                    rec."Account Type"::Customer:
                        BEGIN
                            Customer.GET(Rec."Account No.");
                            Rec."Payer Information" := Customer.Name;
                        END;
                    Rec."Account Type"::Vendor:
                        BEGIN
                            Vendor.GET(Rec."Account No.");
                            Rec."Payer Information" := Vendor.Name;
                        END;
                END;
            end;
        }
        modify("Recipient Bank Account")
        {
            ShowMandatory = false;
        }
        addafter(TotalExportedAmount)
        {
            field("Payer Information"; Rec."Payer Information")
            {
                Caption = 'Name On Cheque';
                ApplicationArea = all;
            }
        }
        addafter("Has Payment Export Error")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Post and &Print")
        {
            action("Print Cheque")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = PrintCheck;
                PromotedCategory = Report;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.TESTFIELD("Bank Payment Type", "Bank Payment Type"::"Computer Check");
                    Rec.TESTFIELD("Bal. Account No.");
                    Rec.TESTFIELD("Bal. Account Type");
                    Rec.TESTFIELD("Payer Information");
                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", Rec."Journal Batch Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Document Type", Rec."Document Type");
                    GenJnlLine.SETRANGE(GenJnlLine."Document No.", Rec."Document No.");
                    IF GenJnlLine.FINDFIRST THEN BEGIN
                        REPORT.RUN(Report::"Computer Check", TRUE, TRUE, GenJnlLine);
                        IF CONFIRM('Do you want to Print corresponding RTGS?') THEN BEGIN
                            REPORT.RUN(Report::RTGS, TRUE, TRUE, GenJnlLine);
                        END;
                        GenJnlLine."Check Printed" := TRUE;
                        GenJnlLine.MODIFY;
                    END;
                end;
            }
            action("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Report;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", Rec."Journal Batch Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Document Type", Rec."Document Type");
                    GenJnlLine.SETRANGE(GenJnlLine."Document No.", Rec."Document No.");
                    IF GenJnlLine.FINDFIRST THEN
                        REPORT.RUN(Report::"Applied Entries Voucher", TRUE, FALSE, GenJnlLine);
                end;
            }
            action(Close)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //REPORT.RUN(50109,FALSE,FALSE,Rec);

                    IF CONFIRM('Do you want to Close') THEN BEGIN
                        Rec."Check Printed" := TRUE;
                        Rec.MODIFY();
                    END;
                end;
            }
            action(Open)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Undo Check Printing') THEN BEGIN
                        Rec."Check Printed" := FALSE;
                        Rec.MODIFY;
                    END;
                end;
            }
        }
    }

    var
        Vendor: Record Vendor;
        CustomerPriceGroup: Record "Customer Price Group";
        Customer: Record Customer;
        GenJnlLine: Record "Gen. Journal Line";
}