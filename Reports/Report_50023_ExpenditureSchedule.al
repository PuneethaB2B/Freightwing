report 50023 "Expenditure Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ExpenditureSchedule.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
            {
            }
            column(GLAccountNo_GLEntry; "G/L Entry"."G/L Account No.")
            {
            }
            column(PostingDate_GLEntry; "G/L Entry"."Posting Date")
            {
            }
            column(DocumentType_GLEntry; "G/L Entry"."Document Type")
            {
            }
            column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
            {
            }
            column(Description_GLEntry; "G/L Entry".Description)
            {
            }
            column(BalAccountNo_GLEntry; "G/L Entry"."Bal. Account No.")
            {
            }
            column(Amount_GLEntry; "G/L Entry".Amount)
            {
            }
            column(GlobalDimension1Code_GLEntry; "G/L Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_GLEntry; "G/L Entry"."Global Dimension 2 Code")
            {
            }
            column(UserID_GLEntry; "G/L Entry"."User ID")
            {
            }
            column(SourceCode_GLEntry; "G/L Entry"."Source Code")
            {
            }
            column(SystemCreatedEntry_GLEntry; "G/L Entry"."System-Created Entry")
            {
            }
            column(PriorYearEntry_GLEntry; "G/L Entry"."Prior-Year Entry")
            {
            }
            column(JobNo_GLEntry; "G/L Entry"."Job No.")
            {
            }
            column(Quantity_GLEntry; "G/L Entry".Quantity)
            {
            }
            column(VATAmount_GLEntry; "G/L Entry"."VAT Amount")
            {
            }
            column(BusinessUnitCode_GLEntry; "G/L Entry"."Business Unit Code")
            {
            }
            column(JournalBatchName_GLEntry; "G/L Entry"."Journal Batch Name")
            {
            }
            column(ReasonCode_GLEntry; "G/L Entry"."Reason Code")
            {
            }
            column(GenPostingType_GLEntry; "G/L Entry"."Gen. Posting Type")
            {
            }
            column(GenBusPostingGroup_GLEntry; "G/L Entry"."Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup_GLEntry; "G/L Entry"."Gen. Prod. Posting Group")
            {
            }
            column(BalAccountType_GLEntry; "G/L Entry"."Bal. Account Type")
            {
            }
            column(TransactionNo_GLEntry; "G/L Entry"."Transaction No.")
            {
            }
            column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
            {
            }
            column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
            {
            }
            column(DocumentDate_GLEntry; "G/L Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_GLEntry; "G/L Entry"."External Document No.")
            {
            }
            column(SourceType_GLEntry; "G/L Entry"."Source Type")
            {
            }
            column(SourceNo_GLEntry; "G/L Entry"."Source No.")
            {
            }
            column(NoSeries_GLEntry; "G/L Entry"."No. Series")
            {
            }
            column(TaxAreaCode_GLEntry; "G/L Entry"."Tax Area Code")
            {
            }
            column(TaxLiable_GLEntry; "G/L Entry"."Tax Liable")
            {
            }
            column(TaxGroupCode_GLEntry; "G/L Entry"."Tax Group Code")
            {
            }
            column(UseTax_GLEntry; "G/L Entry"."Use Tax")
            {
            }
            column(VATBusPostingGroup_GLEntry; "G/L Entry"."VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup_GLEntry; "G/L Entry"."VAT Prod. Posting Group")
            {
            }
            column(AdditionalCurrencyAmount_GLEntry; "G/L Entry"."Additional-Currency Amount")
            {
            }
            column(AddCurrencyDebitAmount_GLEntry; "G/L Entry"."Add.-Currency Debit Amount")
            {
            }
            column(AddCurrencyCreditAmount_GLEntry; "G/L Entry"."Add.-Currency Credit Amount")
            {
            }
            column(CloseIncomeStatementDimID_GLEntry; "G/L Entry"."Close Income Statement Dim. ID")
            {
            }
            column(ICPartnerCode_GLEntry; "G/L Entry"."IC Partner Code")
            {
            }
            column(Reversed_GLEntry; "G/L Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_GLEntry; "G/L Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_GLEntry; "G/L Entry"."Reversed Entry No.")
            {
            }
            column(GLAccountName_GLEntry; "G/L Entry"."G/L Account Name")
            {
            }
            column(DimensionSetID_GLEntry; "G/L Entry"."Dimension Set ID")
            {
            }
            column(ProdOrderNo_GLEntry; "G/L Entry"."Prod. Order No.")
            {
            }
            column(FAEntryType_GLEntry; "G/L Entry"."FA Entry Type")
            {
            }
            column(FAEntryNo_GLEntry; "G/L Entry"."FA Entry No.")
            {
            }
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
}

