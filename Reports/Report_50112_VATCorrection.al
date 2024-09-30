report 50112 "VAT Correction"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "G/L Entry"."Document No.");
                GLAccount.GET("G/L Entry"."G/L Account No.");
                IF ((("G/L Entry"."Source Code" = 'SALES') AND (GLAccount."Gen. Posting Type" <> GLAccount."Gen. Posting Type"::Sale)) OR
                (("G/L Entry"."Source Code" = 'PURCHASES') AND (GLAccount."Gen. Posting Type" <> GLAccount."Gen. Posting Type"::Purchase))) THEN BEGIN
                    IF "G/L Entry"."VAT Prod. Posting Group" <> GLAccount."VAT Prod. Posting Group" THEN BEGIN
                        GLAccount1.RESET;
                        GLAccount1.SETRANGE(GLAccount1."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                        IF "G/L Entry"."Source Code" = 'SALES' THEN BEGIN
                            GLAccount1.SETRANGE(GLAccount1."Gen. Posting Type", GLAccount1."Gen. Posting Type"::Sale);
                        END ELSE BEGIN
                            GLAccount1.SETRANGE(GLAccount1."Gen. Posting Type", GLAccount1."Gen. Posting Type"::Purchase);
                        END;
                        IF GLAccount1.FINDFIRST THEN
                            GenJournalLine.INIT;
                        GenJournalLine."Journal Template Name" := 'GENERAL';
                        GenJournalLine."Journal Batch Name" := 'VAT';
                        GenJournalLine."Line No." := Lineno;
                        IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice THEN BEGIN
                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "G/L Entry"."Document No.");
                            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                            IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                                FreightCharge.GET(SalesInvoiceLine."Freight Charge Code");
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                GenJournalLine.VALIDATE(GenJournalLine."Account No.", "G/L Entry"."G/L Account No.");
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", FreightCharge."G/L Account");
                                SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                                GenJournalLine.VALIDATE(GenJournalLine."Currency Code", SalesInvoiceHeader."Currency Code");
                            END;
                            GenJournalLine."Document Type" := GenJournalLine."Document Type"::"Credit Memo";
                        END ELSE
                            IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::"Credit Memo" THEN BEGIN
                                SalesCrMemoLine.RESET;
                                SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.", "G/L Entry"."Document No.");
                                SalesCrMemoLine.SETRANGE(SalesCrMemoLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                                IF SalesCrMemoLine.FINDFIRST THEN BEGIN
                                    SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
                                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                    SalesInvoiceLine.RESET;
                                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesCrMemoHeader."Applies-to Doc. No.");
                                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                                    IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                                        FreightCharge.GET(SalesInvoiceLine."Freight Charge Code");
                                        GenJournalLine.VALIDATE(GenJournalLine."Account No.", FreightCharge."G/L Account");
                                    END;
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", "G/L Entry"."G/L Account No.");
                                END;
                                GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
                            END;
                        GenJournalLine."VAT Prod. Posting Group" := '';
                        GenJournalLine."Bal. VAT Prod. Posting Group" := '';
                        GenJournalLine."Posting Date" := "G/L Entry"."Posting Date";
                        GenJournalLine."Document No." := "G/L Entry"."Document No.";
                        GenJournalLine.Description := "G/L Entry".Description;
                        GenJournalLine.VALIDATE(GenJournalLine.Amount, ABS("G/L Entry".Amount));
                        GenJournalLine."Dimension Set ID" := "G/L Entry"."Dimension Set ID";
                        GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
                        GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
                        GenJournalLine."Gen. Bus. Posting Group" := '';
                        GenJournalLine."Gen. Prod. Posting Group" := '';
                        GenJournalLine."Bal. Gen. Posting Type" := GenJournalLine."Bal. Gen. Posting Type"::" ";
                        GenJournalLine."Bal. Gen. Bus. Posting Group" := '';
                        GenJournalLine."Bal. Gen. Prod. Posting Group" := '';
                        GenJournalLine."VAT %" := 0;
                        GenJournalLine."VAT Amount" := 0;
                        GenJournalLine."VAT Base Amount" := 0;
                        GenJournalLine."Bal. VAT Base Amount" := 0;
                        GenJournalLine."VAT Bus. Posting Group" := '';
                        GenJournalLine."Bal. VAT Bus. Posting Group" := '';
                        GenJournalLine.INSERT;
                        Lineno += 1000;
                    END;
                END ELSE BEGIN
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name" := 'GENERAL';
                    GenJournalLine."Journal Batch Name" := 'VAT';
                    GenJournalLine."Line No." := Lineno;
                    IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "G/L Entry"."Document No.");
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            FreightCharge.GET(SalesInvoiceLine."Freight Charge Code");
                            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Account No.", "G/L Entry"."G/L Account No.");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", FreightCharge."G/L Account");
                            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
                            GenJournalLine.VALIDATE(GenJournalLine."Currency Code", SalesInvoiceHeader."Currency Code");
                        END;
                        GenJournalLine."Document Type" := GenJournalLine."Document Type"::"Credit Memo";
                    END ELSE
                        IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::"Credit Memo" THEN BEGIN
                            SalesCrMemoLine.RESET;
                            SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.", "G/L Entry"."Document No.");
                            SalesCrMemoLine.SETRANGE(SalesCrMemoLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                            IF SalesCrMemoLine.FINDFIRST THEN BEGIN
                                SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
                                GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesCrMemoHeader."Applies-to Doc. No.");
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "G/L Entry"."VAT Prod. Posting Group");
                                IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                                    FreightCharge.GET(SalesInvoiceLine."Freight Charge Code");
                                    GenJournalLine.VALIDATE(GenJournalLine."Account No.", FreightCharge."G/L Account");
                                END;
                                GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                                GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.", "G/L Entry"."G/L Account No.");
                            END;
                            GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
                        END;
                    GenJournalLine."VAT Prod. Posting Group" := '';
                    GenJournalLine."Bal. VAT Prod. Posting Group" := '';
                    GenJournalLine."Posting Date" := "G/L Entry"."Posting Date";
                    GenJournalLine."Document No." := "G/L Entry"."Document No.";
                    GenJournalLine.Description := "G/L Entry".Description;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount, ABS("G/L Entry".Amount));
                    GenJournalLine."Dimension Set ID" := "G/L Entry"."Dimension Set ID";
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::Invoice;
                    GenJournalLine."Gen. Posting Type" := GenJournalLine."Gen. Posting Type"::" ";
                    GenJournalLine."Gen. Bus. Posting Group" := '';
                    GenJournalLine."Gen. Prod. Posting Group" := '';
                    GenJournalLine."Bal. Gen. Posting Type" := GenJournalLine."Bal. Gen. Posting Type"::" ";
                    GenJournalLine."Bal. Gen. Bus. Posting Group" := '';
                    GenJournalLine."Bal. Gen. Prod. Posting Group" := '';
                    GenJournalLine."VAT %" := 0;
                    GenJournalLine."VAT Amount" := 0;
                    GenJournalLine."VAT Base Amount" := 0;
                    GenJournalLine."Bal. VAT Base Amount" := 0;
                    GenJournalLine."VAT Bus. Posting Group" := '';
                    GenJournalLine."Bal. VAT Bus. Posting Group" := '';
                    GenJournalLine.INSERT;
                    Lineno += 1000;

                END;
                SLEEP(5);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                MESSAGE('Jouurnal Lines Created');
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("G/L Entry"."G/L Account No.", '=%1|%2|%3|%4|%5', '20202', '20203', '20204', '20205', '20102|20105');
                //SETFILTER("G/L Entry"."G/L Account No.",'=%1','20202');
                SETFILTER("G/L Entry"."Gen. Posting Type", '=%1', "G/L Entry"."Gen. Posting Type"::Sale);
                SETFILTER("G/L Entry"."VAT Prod. Posting Group", '=%1|%2', 'VAT0', 'NOVAT');
                Window.OPEN('Creating Lines \ Document No #1###');
                Lineno := 1000;
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE(GenJournalLine."Journal Batch Name", 'VAT');
                IF GenJournalLine.FINDSET THEN
                    GenJournalLine.DELETEALL;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Window: Dialog;
        GenJournalLine: Record 81;
        FreightCharge: Record 50018;
        SalesInvoiceLine: Record 113;
        SalesInvoiceHeader: Record 112;
        Lineno: Integer;
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine: Record 115;
        GLAccount: Record 15;
        GLAccount1: Record 15;
        GLAccount2: Record 15;
}

