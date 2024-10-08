report 50035 RTGS
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/RTGS.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(PayTo; PayTo)
            {
            }
            column(AmountInWords; AmountInWords)
            {
            }
            column(Beneficiary; Beneficiary)
            {
            }
            column(BeneficiaryAddress; BeneficiaryAddress)
            {
            }
            column(BeneficiaryBank; BeneficiaryBank)
            {
            }
            column(BICCode; BICCode)
            {
            }
            column(IBAN; IBAN)
            {
            }
            column(AccountNo; AccountNo)
            {
            }
            column(NameOfBank; NameOfBank)
            {
            }
            column(DebitAccount; Account)
            {
            }
            column(ReferenceNo; gCodeReferenceNo)
            {
            }
            column(BankBranchNo; gCodeVendBankBranchNo)
            {
            }
            column(BankBranchName; gCodeVendBankBranchName)
            {
            }
            column(JournalTemplateName_GenJournalLine; "Gen. Journal Line"."Journal Template Name")
            {
            }
            column(LineNo_GenJournalLine; "Gen. Journal Line"."Line No.")
            {
            }
            column(AccountType_GenJournalLine; "Gen. Journal Line"."Account Type")
            {
            }
            column(AccountNo_GenJournalLine; "Gen. Journal Line"."Account No.")
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(DocumentType_GenJournalLine; "Gen. Journal Line"."Document Type")
            {
            }
            column(DocumentNo_GenJournalLine; "Gen. Journal Line"."Document No.")
            {
            }
            column(Description_GenJournalLine; "Gen. Journal Line".Description)
            {
            }
            column(VAT_GenJournalLine; "Gen. Journal Line"."VAT %")
            {
            }
            column(BalAccountNo_GenJournalLine; "Gen. Journal Line"."Bal. Account No.")
            {
            }
            column(CurrencyCode_GenJournalLine; "Gen. Journal Line"."Currency Code")
            {
            }
            column(Amount_GenJournalLine; "Gen. Journal Line".Amount)
            {
            }
            column(DebitAmount_GenJournalLine; "Gen. Journal Line"."Debit Amount")
            {
            }
            column(CreditAmount_GenJournalLine; "Gen. Journal Line"."Credit Amount")
            {
            }
            column(AmountLCY_GenJournalLine; "Gen. Journal Line"."Amount (LCY)")
            {
            }
            column(BalanceLCY_GenJournalLine; "Gen. Journal Line"."Balance (LCY)")
            {
            }
            column(CurrencyFactor_GenJournalLine; "Gen. Journal Line"."Currency Factor")
            {
            }
            column(SalesPurchLCY_GenJournalLine; "Gen. Journal Line"."Sales/Purch. (LCY)")
            {
            }
            column(ProfitLCY_GenJournalLine; "Gen. Journal Line"."Profit (LCY)")
            {
            }
            column(InvDiscountLCY_GenJournalLine; "Gen. Journal Line"."Inv. Discount (LCY)")
            {
            }
            column(BilltoPaytoNo_GenJournalLine; "Gen. Journal Line"."Bill-to/Pay-to No.")
            {
            }
            column(PostingGroup_GenJournalLine; "Gen. Journal Line"."Posting Group")
            {
            }
            column(ShortcutDimension1Code_GenJournalLine; "Gen. Journal Line"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_GenJournalLine; "Gen. Journal Line"."Shortcut Dimension 2 Code")
            {
            }
            column(SalespersPurchCode_GenJournalLine; "Gen. Journal Line"."Salespers./Purch. Code")
            {
            }
            column(SourceCode_GenJournalLine; "Gen. Journal Line"."Source Code")
            {
            }
            column(SystemCreatedEntry_GenJournalLine; "Gen. Journal Line"."System-Created Entry")
            {
            }
            column(OnHold_GenJournalLine; "Gen. Journal Line"."On Hold")
            {
            }
            column(AppliestoDocType_GenJournalLine; "Gen. Journal Line"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_GenJournalLine; "Gen. Journal Line"."Applies-to Doc. No.")
            {
            }
            column(DueDate_GenJournalLine; "Gen. Journal Line"."Due Date")
            {
            }
            column(PmtDiscountDate_GenJournalLine; "Gen. Journal Line"."Pmt. Discount Date")
            {
            }
            column(PaymentDiscount_GenJournalLine; "Gen. Journal Line"."Payment Discount %")
            {
            }
            column(JobNo_GenJournalLine; "Gen. Journal Line"."Job No.")
            {
            }
            column(Quantity_GenJournalLine; "Gen. Journal Line".Quantity)
            {
            }
            column(VATAmount_GenJournalLine; "Gen. Journal Line"."VAT Amount")
            {
            }
            column(VATPosting_GenJournalLine; "Gen. Journal Line"."VAT Posting")
            {
            }
            column(PaymentTermsCode_GenJournalLine; "Gen. Journal Line"."Payment Terms Code")
            {
            }
            column(AppliestoID_GenJournalLine; "Gen. Journal Line"."Applies-to ID")
            {
            }
            column(BusinessUnitCode_GenJournalLine; "Gen. Journal Line"."Business Unit Code")
            {
            }
            column(JournalBatchName_GenJournalLine; "Gen. Journal Line"."Journal Batch Name")
            {
            }
            column(ReasonCode_GenJournalLine; "Gen. Journal Line"."Reason Code")
            {
            }
            column(RecurringMethod_GenJournalLine; "Gen. Journal Line"."Recurring Method")
            {
            }
            column(ExpirationDate_GenJournalLine; "Gen. Journal Line"."Expiration Date")
            {
            }
            column(RecurringFrequency_GenJournalLine; "Gen. Journal Line"."Recurring Frequency")
            {
            }
            column(AllocatedAmtLCY_GenJournalLine; "Gen. Journal Line"."Allocated Amt. (LCY)")
            {
            }
            column(GenPostingType_GenJournalLine; "Gen. Journal Line"."Gen. Posting Type")
            {
            }
            column(GenBusPostingGroup_GenJournalLine; "Gen. Journal Line"."Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup_GenJournalLine; "Gen. Journal Line"."Gen. Prod. Posting Group")
            {
            }
            column(VATCalculationType_GenJournalLine; "Gen. Journal Line"."VAT Calculation Type")
            {
            }
            column(EU3PartyTrade_GenJournalLine; "Gen. Journal Line"."EU 3-Party Trade")
            {
            }
            column(AllowApplication_GenJournalLine; "Gen. Journal Line"."Allow Application")
            {
            }
            column(BalAccountType_GenJournalLine; "Gen. Journal Line"."Bal. Account Type")
            {
            }
            column(BalGenPostingType_GenJournalLine; "Gen. Journal Line"."Bal. Gen. Posting Type")
            {
            }
            column(BalGenBusPostingGroup_GenJournalLine; "Gen. Journal Line"."Bal. Gen. Bus. Posting Group")
            {
            }
            column(BalGenProdPostingGroup_GenJournalLine; "Gen. Journal Line"."Bal. Gen. Prod. Posting Group")
            {
            }
            column(BalVATCalculationType_GenJournalLine; "Gen. Journal Line"."Bal. VAT Calculation Type")
            {
            }
            column(BalVAT_GenJournalLine; "Gen. Journal Line"."Bal. VAT %")
            {
            }
            column(BalVATAmount_GenJournalLine; "Gen. Journal Line"."Bal. VAT Amount")
            {
            }
            column(BankPaymentType_GenJournalLine; "Gen. Journal Line"."Bank Payment Type")
            {
            }
            column(VATBaseAmount_GenJournalLine; "Gen. Journal Line"."VAT Base Amount")
            {
            }
            column(BalVATBaseAmount_GenJournalLine; "Gen. Journal Line"."Bal. VAT Base Amount")
            {
            }
            column(Correction_GenJournalLine; "Gen. Journal Line".Correction)
            {
            }
            column(CheckPrinted_GenJournalLine; "Gen. Journal Line"."Check Printed")
            {
            }
            column(DocumentDate_GenJournalLine; "Gen. Journal Line"."Document Date")
            {
            }
            column(ExternalDocumentNo_GenJournalLine; "Gen. Journal Line"."External Document No.")
            {
            }
            column(SourceType_GenJournalLine; "Gen. Journal Line"."Source Type")
            {
            }
            column(SourceNo_GenJournalLine; "Gen. Journal Line"."Source No.")
            {
            }
            column(PostingNoSeries_GenJournalLine; "Gen. Journal Line"."Posting No. Series")
            {
            }
            column(TaxAreaCode_GenJournalLine; "Gen. Journal Line"."Tax Area Code")
            {
            }
            column(TaxLiable_GenJournalLine; "Gen. Journal Line"."Tax Liable")
            {
            }
            column(TaxGroupCode_GenJournalLine; "Gen. Journal Line"."Tax Group Code")
            {
            }
            column(UseTax_GenJournalLine; "Gen. Journal Line"."Use Tax")
            {
            }
            column(BalTaxAreaCode_GenJournalLine; "Gen. Journal Line"."Bal. Tax Area Code")
            {
            }
            column(BalTaxLiable_GenJournalLine; "Gen. Journal Line"."Bal. Tax Liable")
            {
            }
            column(BalTaxGroupCode_GenJournalLine; "Gen. Journal Line"."Bal. Tax Group Code")
            {
            }
            column(BalUseTax_GenJournalLine; "Gen. Journal Line"."Bal. Use Tax")
            {
            }
            column(VATBusPostingGroup_GenJournalLine; "Gen. Journal Line"."VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup_GenJournalLine; "Gen. Journal Line"."VAT Prod. Posting Group")
            {
            }
            column(BalVATBusPostingGroup_GenJournalLine; "Gen. Journal Line"."Bal. VAT Bus. Posting Group")
            {
            }
            column(BalVATProdPostingGroup_GenJournalLine; "Gen. Journal Line"."Bal. VAT Prod. Posting Group")
            {
            }
            column(AdditionalCurrencyPosting_GenJournalLine; "Gen. Journal Line"."Additional-Currency Posting")
            {
            }
            column(FAAddCurrencyFactor_GenJournalLine; "Gen. Journal Line"."FA Add.-Currency Factor")
            {
            }
            column(SourceCurrencyCode_GenJournalLine; "Gen. Journal Line"."Source Currency Code")
            {
            }
            column(SourceCurrencyAmount_GenJournalLine; "Gen. Journal Line"."Source Currency Amount")
            {
            }
            column(SourceCurrVATBaseAmount_GenJournalLine; "Gen. Journal Line"."Source Curr. VAT Base Amount")
            {
            }
            column(SourceCurrVATAmount_GenJournalLine; "Gen. Journal Line"."Source Curr. VAT Amount")
            {
            }
            column(VATBaseDiscount_GenJournalLine; "Gen. Journal Line"."VAT Base Discount %")
            {
            }
            column(VATAmountLCY_GenJournalLine; "Gen. Journal Line"."VAT Amount (LCY)")
            {
            }
            column(VATBaseAmountLCY_GenJournalLine; "Gen. Journal Line"."VAT Base Amount (LCY)")
            {
            }
            column(BalVATAmountLCY_GenJournalLine; "Gen. Journal Line"."Bal. VAT Amount (LCY)")
            {
            }
            column(BalVATBaseAmountLCY_GenJournalLine; "Gen. Journal Line"."Bal. VAT Base Amount (LCY)")
            {
            }
            column(ReversingEntry_GenJournalLine; "Gen. Journal Line"."Reversing Entry")
            {
            }
            column(AllowZeroAmountPosting_GenJournalLine; "Gen. Journal Line"."Allow Zero-Amount Posting")
            {
            }
            column(ShiptoOrderAddressCode_GenJournalLine; "Gen. Journal Line"."Ship-to/Order Address Code")
            {
            }
            column(VATDifference_GenJournalLine; "Gen. Journal Line"."VAT Difference")
            {
            }
            column(BalVATDifference_GenJournalLine; "Gen. Journal Line"."Bal. VAT Difference")
            {
            }
            column(ICPartnerCode_GenJournalLine; "Gen. Journal Line"."IC Partner Code")
            {
            }
            column(ICDirection_GenJournalLine; "Gen. Journal Line"."IC Direction")
            {
            }
            column(ICPartnerGLAccNo_GenJournalLine; "Gen. Journal Line"."IC Partner G/L Acc. No.")
            {
            }
            column(ICPartnerTransactionNo_GenJournalLine; "Gen. Journal Line"."IC Partner Transaction No.")
            {
            }
            column(SelltoBuyfromNo_GenJournalLine; "Gen. Journal Line"."Sell-to/Buy-from No.")
            {
            }
            column(VATRegistrationNo_GenJournalLine; "Gen. Journal Line"."VAT Registration No.")
            {
            }
            column(CountryRegionCode_GenJournalLine; "Gen. Journal Line"."Country/Region Code")
            {
            }
            column(Prepayment_GenJournalLine; "Gen. Journal Line".Prepayment)
            {
            }
            column(FinancialVoid_GenJournalLine; "Gen. Journal Line"."Financial Void")
            {
            }
            column(IncomingDocumentEntryNo_GenJournalLine; "Gen. Journal Line"."Incoming Document Entry No.")
            {
            }
            column(CreditorNo_GenJournalLine; "Gen. Journal Line"."Creditor No.")
            {
            }
            column(PaymentReference_GenJournalLine; "Gen. Journal Line"."Payment Reference")
            {
            }
            column(PaymentMethodCode_GenJournalLine; "Gen. Journal Line"."Payment Method Code")
            {
            }
            column(AppliestoExtDocNo_GenJournalLine; "Gen. Journal Line"."Applies-to Ext. Doc. No.")
            {
            }
            column(RecipientBankAccount_GenJournalLine; "Gen. Journal Line"."Recipient Bank Account")
            {
            }
            column(MessagetoRecipient_GenJournalLine; "Gen. Journal Line"."Message to Recipient")
            {
            }
            column(ExportedtoPaymentFile_GenJournalLine; "Gen. Journal Line"."Exported to Payment File")
            {
            }
            column(HasPaymentExportError_GenJournalLine; "Gen. Journal Line"."Has Payment Export Error")
            {
            }
            column(DimensionSetID_GenJournalLine; "Gen. Journal Line"."Dimension Set ID")
            {
            }
            /*  column(CreditCardNo_GenJournalLine; "Gen. Journal Line"."Credit Card No.")
             {
             } */ //B2BUPG removed in higher version
            column(JobTaskNo_GenJournalLine; "Gen. Journal Line"."Job Task No.")
            {
            }
            column(JobUnitPriceLCY_GenJournalLine; "Gen. Journal Line"."Job Unit Price (LCY)")
            {
            }
            column(JobTotalPriceLCY_GenJournalLine; "Gen. Journal Line"."Job Total Price (LCY)")
            {
            }
            column(JobQuantity_GenJournalLine; "Gen. Journal Line"."Job Quantity")
            {
            }
            column(JobUnitCostLCY_GenJournalLine; "Gen. Journal Line"."Job Unit Cost (LCY)")
            {
            }
            column(JobLineDiscount_GenJournalLine; "Gen. Journal Line"."Job Line Discount %")
            {
            }
            column(JobLineDiscAmountLCY_GenJournalLine; "Gen. Journal Line"."Job Line Disc. Amount (LCY)")
            {
            }
            column(JobUnitOfMeasureCode_GenJournalLine; "Gen. Journal Line"."Job Unit Of Measure Code")
            {
            }
            column(JobLineType_GenJournalLine; "Gen. Journal Line"."Job Line Type")
            {
            }
            column(JobUnitPrice_GenJournalLine; "Gen. Journal Line"."Job Unit Price")
            {
            }
            column(JobTotalPrice_GenJournalLine; "Gen. Journal Line"."Job Total Price")
            {
            }
            column(JobUnitCost_GenJournalLine; "Gen. Journal Line"."Job Unit Cost")
            {
            }
            column(JobTotalCost_GenJournalLine; "Gen. Journal Line"."Job Total Cost")
            {
            }
            column(JobLineDiscountAmount_GenJournalLine; "Gen. Journal Line"."Job Line Discount Amount")
            {
            }
            column(JobLineAmount_GenJournalLine; "Gen. Journal Line"."Job Line Amount")
            {
            }
            column(JobTotalCostLCY_GenJournalLine; "Gen. Journal Line"."Job Total Cost (LCY)")
            {
            }
            column(JobLineAmountLCY_GenJournalLine; "Gen. Journal Line"."Job Line Amount (LCY)")
            {
            }
            column(JobCurrencyFactor_GenJournalLine; "Gen. Journal Line"."Job Currency Factor")
            {
            }
            column(JobCurrencyCode_GenJournalLine; "Gen. Journal Line"."Job Currency Code")
            {
            }
            column(JobPlanningLineNo_GenJournalLine; "Gen. Journal Line"."Job Planning Line No.")
            {
            }
            column(JobRemainingQty_GenJournalLine; "Gen. Journal Line"."Job Remaining Qty.")
            {
            }
            column(DirectDebitMandateID_GenJournalLine; "Gen. Journal Line"."Direct Debit Mandate ID")
            {
            }
            // column(PostingExchEntryNo_GenJournalLine; "Gen. Journal Line"."Posting Exch. Entry No.")
            // {
            // }
            column(PayerInformation_GenJournalLine; "Gen. Journal Line"."Payer Information")
            {
            }
            column(TransactionInformation_GenJournalLine; "Gen. Journal Line"."Transaction Information")
            {
            }
            // column(PostingExchLineNo_GenJournalLine; "Gen. Journal Line"."Posting Exch. Line No.")
            // {
            // }  //B2BUPG
            column(AppliedAutomatically_GenJournalLine; "Gen. Journal Line"."Applied Automatically")
            {
            }
            column(CampaignNo_GenJournalLine; "Gen. Journal Line"."Campaign No.")
            {
            }
            column(ProdOrderNo_GenJournalLine; "Gen. Journal Line"."Prod. Order No.")
            {
            }
            column(FAPostingDate_GenJournalLine; "Gen. Journal Line"."FA Posting Date")
            {
            }
            column(FAPostingType_GenJournalLine; "Gen. Journal Line"."FA Posting Type")
            {
            }
            column(DepreciationBookCode_GenJournalLine; "Gen. Journal Line"."Depreciation Book Code")
            {
            }
            column(SalvageValue_GenJournalLine; "Gen. Journal Line"."Salvage Value")
            {
            }
            column(NoofDepreciationDays_GenJournalLine; "Gen. Journal Line"."No. of Depreciation Days")
            {
            }
            column(DepruntilFAPostingDate_GenJournalLine; "Gen. Journal Line"."Depr. until FA Posting Date")
            {
            }
            column(DeprAcquisitionCost_GenJournalLine; "Gen. Journal Line"."Depr. Acquisition Cost")
            {
            }
            column(MaintenanceCode_GenJournalLine; "Gen. Journal Line"."Maintenance Code")
            {
            }
            column(InsuranceNo_GenJournalLine; "Gen. Journal Line"."Insurance No.")
            {
            }
            column(BudgetedFANo_GenJournalLine; "Gen. Journal Line"."Budgeted FA No.")
            {
            }
            column(DuplicateinDepreciationBook_GenJournalLine; "Gen. Journal Line"."Duplicate in Depreciation Book")
            {
            }
            column(UseDuplicationList_GenJournalLine; "Gen. Journal Line"."Use Duplication List")
            {
            }
            column(FAReclassificationEntry_GenJournalLine; "Gen. Journal Line"."FA Reclassification Entry")
            {
            }
            column(FAErrorEntryNo_GenJournalLine; "Gen. Journal Line"."FA Error Entry No.")
            {
            }
            column(IndexEntry_GenJournalLine; "Gen. Journal Line"."Index Entry")
            {
            }
            column(SourceLineNo_GenJournalLine; "Gen. Journal Line"."Source Line No.")
            {
            }
            column(Comment_GenJournalLine; "Gen. Journal Line".Comment)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AmountInWords := ConvertToText(FORMAT(Amount), "Gen. Journal Line"."Currency Code");
                NameOfBank := '';
                PayTo := '';
                CASE "Gen. Journal Line"."Account Type" OF
                    "Gen. Journal Line"."Bal. Account Type"::Customer:
                        BEGIN
                            Cust.GET("Gen. Journal Line"."Account No.");
                            PayTo := Cust.Name;
                        END;
                    "Gen. Journal Line"."Account Type"::Vendor:
                        BEGIN
                            Vend.GET("Gen. Journal Line"."Account No.");
                            Beneficiary := Vend.Name;
                            BeneficiaryAddress := Vend.Address + ' ' + Vend.City;
                            VendorBankAccount.RESET;
                            VendorBankAccount.SETRANGE(VendorBankAccount."Vendor No.", "Gen. Journal Line"."Account No.");
                            IF VendorBankAccount.FINDFIRST THEN BEGIN
                                BeneficiaryBank := VendorBankAccount.Name;
                                BICCode := VendorBankAccount."SWIFT Code";
                                IBAN := VendorBankAccount.IBAN;
                                AccountNo := VendorBankAccount."Bank Account No.";
                                gCodeVendBankBranchNo := VendorBankAccount."Bank Branch No.";
                                gCodeVendBankBranchName := VendorBankAccount."Bank Branch Name";
                            END;
                        END;
                END;
                //MESSAGE('Pay %1',PayTo);

                CASE "Gen. Journal Line"."Bal. Account Type" OF
                    "Gen. Journal Line"."Bal. Account Type"::"Bank Account":
                        BEGIN
                            BankAccount.GET("Gen. Journal Line"."Bal. Account No.");
                            NameOfBank := BankAccount.Name + '. <br>' + BankAccount.City;
                            Account := BankAccount."Bank Account No.";
                        END;
                END;

                //TBL
                AmountInWords := '( ' + AmountInWords + ' )';
                CLEAR(gCodeReferenceNo);
                IF NOT BankAccount.ISEMPTY THEN
                    gCodeReferenceNo := 'FWL/' + BankAccount."No." + '/' + "Gen. Journal Line"."Document No."
                ELSE
                    gCodeReferenceNo := 'FWL/' + "Gen. Journal Line"."Document No.";
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
        BankAccount: Record "Bank Account";
        NameOfBank: Text[250];
        Vend: Record Vendor;
        VendorBankAccount: Record "Vendor Bank Account";
        PayTo: Text[250];
        AmntInWOrds: Text[250];
        CompanyInfo: Record "Company Information";
        BillToAddress: Text[250];
        BenfAccountName: Text;
        HideBenf: Boolean;
        Banks1: Record "Bank Account";
        BenfAccount: Code[50];
        BenfBranch: Text[50];
        BenfBankname: Text[50];
        BenF: Record "Beneficiary Details";
        BenfName: Text[250];
        PrepBy: Code[50];
        TotBoxes: Decimal;
        DivNoOfBoxes: Decimal;
        TotalWeight: Decimal;
        Houses: Boolean;
        DivCustom: Text[50];
        DivWeight: Decimal;
        DivEuro: Text[50];
        Division: Text[50];
        CompInfo: Record "Company Information";
        Consignees: Record Consignee;
        Shippers: Record "Shipper Agent";
        ShipperName: Text[50];
        ConsigneeName: Text[50];
        Phyto: Text[50];
        Euro: Text[50];
        Custom: Text[50];
        Banks: Record "Bank Account";
        Account: Code[50];
        Branch: Text[50];
        name: Text[50];
        Cust: Record Customer;
        Currex: Record "Currency Exchange Rate";
        Exchange: Decimal;
        BillTo: Text[250];
        BookingSheetMAWB: Record "Booking Sheet MAWB Allocation";
        FlightNo: Code[50];
        NoOfBoxes: Decimal;
        LoadingSheetLine: Record "Loading Sheet Line";
        Airports: Record Airport;
        Dest: Text[50];
        txt: Text[250];
        CommaPosition: Integer;
        StartPosition: Integer;
        boolPrintDecimal: Boolean;
        AmountInWords: Text[250];
        TotalAmount: Decimal;
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        MAWBLine: Record "MAWB Line";
        Setup: Record "Import/Export Setup";
        Beneficiary: Text[200];
        BeneficiaryAddress: Text[200];
        BeneficiaryBank: Text[200];
        BICCode: Text[200];
        IBAN: Text[200];
        AccountNo: Text[200];
        gCodeReferenceNo: Code[250];
        gCodeVendBankBranchNo: Text;
        gCodeVendBankBranchName: Text;


    procedure ConvertToText(MyAmount: Text[259]; CurrencyCode: Code[10]) txtConvertedAmount: Text[250]
    var
        txtMyAmount: Text[250];
        txtIntegerPart: Text[250];
        txtDecimalPart: Text[250];
        intDecimalPlace: Integer;
        intCount: Integer;
        txtTemp: Text[250];
        txtFinalInteger: Text[250];
        txtFinalDecimal: Text[250];
        arrPlace: array[9] of Text[20];
        recCurrency: Record Currency;
        txtCurrencyNumericPos: Text[30];
        txtCurrencyDecimalPos: Text[30];
        txtTemp2: Text[2];
    begin
        IF STRPOS(MyAmount, ',') > 0 THEN BEGIN
            StartPosition := 1;
            REPEAT
                CommaPosition := STRPOS(MyAmount, ',');
                txt := txt + COPYSTR(MyAmount, StartPosition, CommaPosition - 1);
                MyAmount := COPYSTR(MyAmount, CommaPosition + 1);
            UNTIL STRPOS(MyAmount, ',') = 0;
            txt := txt + COPYSTR(MyAmount, StartPosition);
            MyAmount := txt;
        END;
        arrPlace[2] := ' THOUSAND ';
        arrPlace[3] := ' MILLION ';
        arrPlace[4] := ' BILLION ';
        arrPlace[5] := ' TRILLION ';
        /*IF (CurrencyCode = '') OR (CurrencyCode='') THEN
           boolPrintDecimal:=FALSE;
        */
        boolPrintDecimal := TRUE;
        recCurrency.RESET;
        recCurrency.SETRANGE(Code, CurrencyCode);
        IF recCurrency.FIND('-') THEN BEGIN
            txtCurrencyNumericPos := recCurrency."Currency Numeric Description";
            txtCurrencyDecimalPos := recCurrency."Currency Decimal Description";
            IF CurrencyCode <> 'GBP' THEN BEGIN
                txtCurrencyDecimalPos := 'CENT';
            END ELSE BEGIN
                txtCurrencyDecimalPos := 'PENCE'
            END;

        END
        ELSE BEGIN
            txtCurrencyNumericPos := '';
            IF CurrencyCode <> 'GBP' THEN BEGIN
                txtCurrencyDecimalPos := 'CENT';
            END ELSE BEGIN
                txtCurrencyDecimalPos := 'PENCE'
            END;
        END;



        //txtMyAmount := FORMAT(MyAmount);
        txtMyAmount := MyAmount;
        // Position of decimal place 0 if none.
        intDecimalPlace := STRPOS(txtMyAmount, '.');
        // Convert cents and set txtMyAmount to dollar amount.
        IF intDecimalPlace > 0 THEN BEGIN
            txtDecimalPart := COPYSTR(txtMyAmount, intDecimalPlace + 1, 2);
            txtDecimalPart := fnGetTens(txtDecimalPart);
            txtIntegerPart := COPYSTR(txtMyAmount, 1, intDecimalPlace - 1);
        END
        ELSE BEGIN
            txtIntegerPart := COPYSTR(txtMyAmount, 1);
        END;

        intCount := 1;
        REPEAT
            IF STRLEN(txtIntegerPart) >= 3 THEN
                txtTemp := COPYSTR(txtIntegerPart, STRLEN(txtIntegerPart) - 2, 3)
            ELSE
                txtTemp := txtIntegerPart;

            txtTemp := fnGetHundreds(txtTemp);
            IF txtTemp <> '' THEN
                txtFinalInteger := txtTemp + arrPlace[intCount] + txtFinalInteger;
            IF STRLEN(txtIntegerPart) > 3 THEN
                txtIntegerPart := COPYSTR(txtIntegerPart, 1, STRLEN(txtIntegerPart) - 3)
            ELSE
                txtIntegerPart := '';

            intCount := intCount + 1;
        UNTIL txtIntegerPart = '';

        IF txtFinalInteger = '' THEN
            txtFinalInteger := txtCurrencyNumericPos + ' ZERO'
        ELSE BEGIN
            IF txtFinalInteger = 'ONE' THEN
                txtFinalInteger := txtCurrencyNumericPos + ' ONE'
            ELSE
                txtFinalInteger := txtCurrencyNumericPos + ' ' + txtFinalInteger;
            //      txtFinalInteger := txtCurrencyNumericPos + 'S ' + txtFinalInteger ;
        END;
        IF boolPrintDecimal THEN BEGIN
            IF txtDecimalPart = '' THEN
                txtDecimalPart := ' AND ZERO ' + txtCurrencyDecimalPos + 'S'
            ELSE BEGIN
                IF txtDecimalPart = 'ONE' THEN
                    txtDecimalPart := ' AND ONE ' + txtCurrencyDecimalPos
                ELSE
                    txtDecimalPart := ' AND ' + txtDecimalPart + ' ' + txtCurrencyDecimalPos + 'S';
            END;
        END
        ELSE
            txtDecimalPart := ' AND ' + txtDecimalPart;
        IF boolPrintDecimal THEN
            txtConvertedAmount := txtFinalInteger + txtDecimalPart + ' ONLY'
        ELSE
            txtConvertedAmount := txtFinalInteger + ' ONLY';

    end;


    procedure fnGetTens(txtTens_in: Text[2]) txtTens_out: Text[100]
    var
        txtTemp: Text[50];
    begin
        // If value between 10-19...
        txtTemp := COPYSTR(txtTens_in, 1, 1);
        IF txtTemp = '1' THEN BEGIN
            IF txtTens_in = '10' THEN
                txtTens_out := 'TEN'
            ELSE
                IF txtTens_in = '11' THEN
                    txtTens_out := 'ELEVEN'
                ELSE
                    IF txtTens_in = '12' THEN
                        txtTens_out := 'TWELVE'
                    ELSE
                        IF txtTens_in = '13' THEN
                            txtTens_out := 'THIRTEEN'
                        ELSE
                            IF txtTens_in = '14' THEN
                                txtTens_out := 'FOURTEEN'
                            ELSE
                                IF txtTens_in = '15' THEN
                                    txtTens_out := 'FIFTEEN'
                                ELSE
                                    IF txtTens_in = '16' THEN
                                        txtTens_out := 'SIXTEEN'
                                    ELSE
                                        IF txtTens_in = '17' THEN
                                            txtTens_out := 'SEVENTEEN'
                                        ELSE
                                            IF txtTens_in = '18' THEN
                                                txtTens_out := 'EIGHTEEN'
                                            ELSE
                                                IF txtTens_in = '19' THEN
                                                    txtTens_out := 'NINETEEN'
        END
        ELSE BEGIN
            //If value between 20-99...
            IF txtTemp = '2' THEN
                txtTens_out := 'TWENTY '
            ELSE
                IF txtTemp = '3' THEN
                    txtTens_out := 'THIRTY '
                ELSE
                    IF txtTemp = '4' THEN
                        txtTens_out := 'FORTY '
                    ELSE
                        IF txtTemp = '5' THEN
                            txtTens_out := 'FIFTY '
                        ELSE
                            IF txtTemp = '6' THEN
                                txtTens_out := 'SIXTY '
                            ELSE
                                IF txtTemp = '7' THEN
                                    txtTens_out := 'SEVENTY '
                                ELSE
                                    IF txtTemp = '8' THEN
                                        txtTens_out := 'EIGHTY '
                                    ELSE
                                        IF txtTemp = '9' THEN
                                            txtTens_out := 'NINETY ';
            txtTens_out := txtTens_out + fnGetDigits(COPYSTR(txtTens_in, 2, 1));
        END;
    end;


    procedure fnGetDigits(txtDigits_in: Text[1]) txtDigits_out: Text[100]
    begin
        IF txtDigits_in = '1' THEN
            txtDigits_out := 'ONE';
        IF txtDigits_in = '2' THEN
            txtDigits_out := 'TWO';
        IF txtDigits_in = '3' THEN
            txtDigits_out := 'THREE';
        IF txtDigits_in = '4' THEN
            txtDigits_out := 'FOUR';
        IF txtDigits_in = '5' THEN
            txtDigits_out := 'FIVE';
        IF txtDigits_in = '6' THEN
            txtDigits_out := 'SIX';
        IF txtDigits_in = '7' THEN
            txtDigits_out := 'SEVEN';
        IF txtDigits_in = '8' THEN
            txtDigits_out := 'EIGHT';
        IF txtDigits_in = '9' THEN
            txtDigits_out := 'NINE';
    end;


    procedure fnGetHundreds(txtHundreds_in: Text[50]) txtHundreds_out: Text[100]
    var
        txtMyNumber: Text[100];
        txtResult: Text[250];
        txtTemp: Text[50];
    begin
        IF txtHundreds_in = '000' THEN EXIT;
        txtHundreds_in := '000' + txtHundreds_in;
        txtMyNumber := COPYSTR(txtHundreds_in, STRLEN(txtHundreds_in) - 2, 3);
        //Convert the hundreds place.
        txtTemp := COPYSTR(txtMyNumber, 1, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 1, 1);
            txtResult := fnGetDigits(txtTemp) + ' HUNDRED ';
        END;

        //Convert the tens and ones place.
        txtTemp := COPYSTR(txtMyNumber, 2, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 2, 2);
            txtResult := txtResult + fnGetTens(txtTemp);
        END
        ELSE BEGIN
            txtTemp := COPYSTR(txtMyNumber, 3, 1);
            txtResult := txtResult + fnGetDigits(txtTemp);
        END;
        txtHundreds_out := txtResult;
    end;
}

