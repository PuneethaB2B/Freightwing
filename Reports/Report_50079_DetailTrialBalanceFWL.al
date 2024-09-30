report 50079 "Detail Trial Balance FWL"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DetailTrialBalanceFWL.rdlc';
    Caption = 'Detail Trial Balance';
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type"=CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; STRSUBSTNO(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            dataitem(PageCounter; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = CONST(1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No."=FIELD("No."),
                                   "Posting Date"=FIELD("Date Filter"),
                                   "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"),
                                   "Business Unit Code"=FIELD("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING("G/L Account No.","Posting Date");
                    RequestFilterFields = "Document Type","G/L Account No.";
                    column(VATAmount_GLEntry;"VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry;"Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry;"Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry;"Posting Date")
                    {
                    }
                    column(DocumentNo_GLEntry;"Document No.")
                    {
                    }
                    column(Description_GLEntry;Description)
                    {
                    }
                    column(GLBalance;GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry;"Entry No.")
                    {
                    }
                    column(ClosingEntry;ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry;Reversed)
                    {
                    }
                    column(BalAccountType_GLEntry;"Bal. Account Type")
                    {
                    }
                    column(BalAccountNo_GLEntry;"Bal. Account No.")
                    {
                    }
                    column(VendName;VendName)
                    {
                    }
                    column(PIN;PIN)
                    {
                    }
                    column(Name;Name)
                    {
                    }
                    column(FundCheckTxt_2;FundCheckTxt[2])
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //************
                        VendName :='';// PIN:='';

                        FundCheckTxt[1]:='';
                        FundCheckTxt[2]:='';
                        FundCheckTxt[1]:=( COPYSTR(Description,13));
                        FundCheckTxt[2]:=PADSTR(FundCheckTxt[1],6);

                        //IF "Source Type" = "Source Type"::Vendor  THEN BEGIN
                        Vendor.RESET;
                        Vendor.SETRANGE("No.",FundCheckTxt[2]);
                        IF Vendor.FIND('-') THEN BEGIN
                        VendName := Vendor.Name;
                        //PIN:=Vendor."Vendor PIN"; END;
                        END;
                        //************

                        IF "G/L Entry"."Bal. Account Type"="G/L Entry"."Bal. Account Type"::Vendor THEN BEGIN
                             Vendor.GET("G/L Entry"."Bal. Account No.");

                             Name :=Vendor.Name;
                        END;


                        IF PrintOnlyCorrections THEN
                          IF NOT (("Debit Amount" < 0) OR ("Credit Amount" < 0)) THEN
                            CurrReport.SKIP;
                        IF NOT PrintReversedEntries AND Reversed THEN
                          CurrReport.SKIP;

                        GLBalance := GLBalance + Amount;
                        IF ("Posting Date" = CLOSINGDATE("Posting Date")) AND
                           NOT PrintClosingEntries
                        THEN BEGIN
                          "Debit Amount" := 0;
                          "Credit Amount" := 0;
                        END;

                        IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                          ClosingEntry := TRUE
                        ELSE
                          ClosingEntry := FALSE;
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                        CurrReport.CREATETOTALS(Amount,"Debit Amount","Credit Amount","VAT Amount");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PRINTONLYIFDETAIL := ExcludeBalanceOnly OR (StartBalance = 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                StartBalance := 0;
                IF GLDateFilter <> '' THEN
                  IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                    SETRANGE("Date Filter",0D,CLOSINGDATE(GETRANGEMIN("Date Filter") - 1));
                    CALCFIELDS("Net Change");
                    StartBalance := "Net Change";
                    SETFILTER("Date Filter",GLDateFilter);
                  END;

                IF PrintOnlyOnePerPage THEN BEGIN
                  GLEntryPage.RESET;
                  GLEntryPage.SETRANGE("G/L Account No.","No.");
                  IF CurrReport.PRINTONLYIFDETAIL AND GLEntryPage.FINDFIRST THEN
                    PageGroupNo := PageGroupNo + 1;
                END;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;

                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc;PrintOnlyOnePerPage)
                    {
                        Caption = 'New Page per G/L Acc.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly;ExcludeBalanceOnly)
                    {
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(InclClosingEntriesWithinPeriod;PrintClosingEntries)
                    {
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                    }
                    field(IncludeReversedEntries;PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                    }
                    field(PrintCorrectionsOnly;PrintOnlyCorrections)
                    {
                        Caption = 'Print Corrections Only';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        GLDateFilter := "G/L Account".GETFILTER("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text[30];
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        GLEntryPage: Record "G/L Entry";
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        "----tbl---": Integer;
        Vendor: Record Vendor;
        Customer: Record Customer;
        Name: Text[100];
        PIN: Code[50];
        VendName: Text[250];
        FundCheckTxt: array [2] of Text;
        StringLen: Integer;

    
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean;NewExcludeBalanceOnly: Boolean;NewPrintClosingEntries: Boolean;NewPrintReversedEntries: Boolean;NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;
}

