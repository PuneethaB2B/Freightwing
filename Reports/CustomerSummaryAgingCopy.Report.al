report 50009 "Customer - Summary AgingCopy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerSummaryAgingCopy.rdlc';
    Caption = 'Customer - Summary Aging';

    dataset
    {
        dataitem(DataItem6836; Table18)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Currency Filter", "Salesperson Code";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(PeriodStartDate_2_; FORMAT(PeriodStartDate[2]))
            {
            }
            column(PeriodStartDate_3_; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate_4_; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate_3_1; FORMAT(PeriodStartDate[3] - 1))
            {
            }
            column(PeriodStartDate_4_1; FORMAT(PeriodStartDate[4] - 1))
            {
            }
            column(PeriodStartDate_5_1; FORMAT(PeriodStartDate[5] - 1))
            {
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(TotalCustBalanceLCY; TotalCustBalanceLCY)
            {
                AutoFormatType = 1;
            }
            column(LineTotalCustBalance; LineTotalCustBalance)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDue_5_; CustBalanceDue[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDue_4_; CustBalanceDue[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDue_3_; CustBalanceDue[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDue_2_; CustBalanceDue[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDue_1_; CustBalanceDue[1])
            {
                AutoFormatType = 1;
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_No_; "No.")
            {
            }
            column(InCustBalanceDueLCY_1; InCustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(InCustBalanceDueLCY_2; InCustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(InCustBalanceDueLCY_3; InCustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(InCustBalanceDueLCY_4; InCustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(InCustBalanceDueLCY_5; InCustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(Customer_Summary_AgingCaption; Customer_Summary_AgingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Balance_DueCaption; Balance_DueCaptionLbl)
            {
            }
            column(Customer_No_Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(CustBalanceDue_1_Caption; CustBalanceDue_1_CaptionLbl)
            {
            }
            column(CustBalanceDue_5_Caption; CustBalanceDue_5_CaptionLbl)
            {
            }
            column(LineTotalCustBalanceCaption; LineTotalCustBalanceCaptionLbl)
            {
            }
            column(Total_LCY_Caption; Total_LCY_CaptionLbl)
            {
            }
            dataitem(DataItem5444; Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(LineTotalCustBalance_Control67; LineTotalCustBalance)
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_5_Control68; CustBalanceDue[5])
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_4_Control69; CustBalanceDue[4])
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_3_Control70; CustBalanceDue[3])
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_2_Control71; CustBalanceDue[2])
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(CustBalanceDue_1_Control72; CustBalanceDue[1])
                {
                    AutoFormatExpression = Currency2.Code;
                    AutoFormatType = 1;
                }
                column(Currency2_Code; Currency2.Code)
                {
                }
                column(Customer_Name_Control74; Customer.Name)
                {
                }
                column(Customer_No_Control75; Customer."No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    DtldCustLedgEntry: Record "379";
                begin
                    IF Number = 1 THEN
                        Currency2.FIND('-')
                    ELSE
                        IF Currency2.NEXT = 0 THEN
                            CurrReport.BREAK;
                    Currency2.CALCFIELDS("Cust. Ledg. Entries in Filter");
                    IF NOT Currency2."Cust. Ledg. Entries in Filter" THEN
                        CurrReport.SKIP;

                    PrintLine := FALSE;
                    LineTotalCustBalance := 0;
                    FOR i := 1 TO 5 DO BEGIN
                        DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date");
                        DtldCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                        DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        DtldCustLedgEntry.SETRANGE("Currency Code", Currency2.Code);
                        DtldCustLedgEntry.CALCSUMS(Amount);
                        CustBalanceDue[i] := DtldCustLedgEntry.Amount;
                        InCustBalanceDueLCY[i] := InCustBalanceDueLCY2[i];
                        IF CustBalanceDue[i] <> 0 THEN
                            PrintLine := TRUE;
                        LineTotalCustBalance := LineTotalCustBalance + CustBalanceDue[i];
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF PrintAmountsInLCY OR NOT PrintLine THEN
                        CurrReport.BREAK;
                    Currency2.RESET;
                    Currency2.SETRANGE("Customer Filter", Customer."No.");
                    Customer.COPYFILTER("Currency Filter", Currency2.Code);
                    IF (Customer.GETFILTER("Global Dimension 1 Filter") <> '') OR
                       (Customer.GETFILTER("Global Dimension 2 Filter") <> '')
                    THEN BEGIN
                        Customer.COPYFILTER("Global Dimension 1 Filter", Currency2."Global Dimension 1 Filter");
                        Customer.COPYFILTER("Global Dimension 2 Filter", Currency2."Global Dimension 2 Filter");
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            var
                DtldCustLedgEntry: Record "379";
            begin
                PrintLine := FALSE;
                LineTotalCustBalance := 0;
                COPYFILTER("Currency Filter", DtldCustLedgEntry."Currency Code");
                FOR i := 1 TO 5 DO BEGIN
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                    CustBalanceDue[i] := DtldCustLedgEntry."Amount (LCY)";
                    CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
                    IF PrintAmountsInLCY THEN
                        InCustBalanceDueLCY[i] += DtldCustLedgEntry."Amount (LCY)"
                    ELSE
                        InCustBalanceDueLCY2[i] += DtldCustLedgEntry."Amount (LCY)";
                    IF CustBalanceDue[i] <> 0 THEN
                        PrintLine := TRUE;
                    LineTotalCustBalance := LineTotalCustBalance + CustBalanceDueLCY[i];
                    TotalCustBalanceLCY := TotalCustBalanceLCY + CustBalanceDueLCY[i];
                END;

                IF NOT PrintLine THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDue, CustBalanceDueLCY, TotalCustBalanceLCY);
                Currency2.Code := '';
                Currency2.INSERT;
                IF Currency.FIND('-') THEN
                    REPEAT
                        Currency2 := Currency;
                        Currency2.INSERT;
                    UNTIL Currency.NEXT = 0;
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
                    field(StartingDate; PeriodStartDate[2])
                    {
                        Caption = 'Starting Date';
                        NotBlank = true;
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        Caption = 'Period Length';
                    }
                    field(ShowAmountsInLCY; PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in LCY';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF PeriodStartDate[2] = 0D THEN
                PeriodStartDate[2] := WORKDATE;
            IF FORMAT(PeriodLength) = '' THEN
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        FOR i := 3 TO 5 DO
            PeriodStartDate[i] := CALCDATE(PeriodLength, PeriodStartDate[i - 1]);
        PeriodStartDate[6] := 31129999D;
    end;

    var
        Currency: Record "4";
        Currency2: Record "4" temporary;
        CustFilter: Text;
        PrintAmountsInLCY: Boolean;
        PeriodLength: DateFormula;
        PeriodStartDate: array[6] of Date;
        CustBalanceDue: array[5] of Decimal;
        CustBalanceDueLCY: array[5] of Decimal;
        LineTotalCustBalance: Decimal;
        TotalCustBalanceLCY: Decimal;
        PrintLine: Boolean;
        i: Integer;
        InCustBalanceDueLCY: array[5] of Decimal;
        InCustBalanceDueLCY2: array[5] of Decimal;
        Customer_Summary_AgingCaptionLbl: Label 'Customer - Summary Aging';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        Balance_DueCaptionLbl: Label 'Balance Due';
        CustBalanceDue_1_CaptionLbl: Label '...Before';
        CustBalanceDue_5_CaptionLbl: Label 'After...';
        LineTotalCustBalanceCaptionLbl: Label 'Balance';
        Total_LCY_CaptionLbl: Label 'Total (LCY)';

    [Scope('Internal')]
    procedure InitializeRequest(StartingDate: Date; SetPeriodLength: Text[1024]; ShowAmountInLCY: Boolean)
    begin
        PeriodStartDate[2] := StartingDate;
        EVALUATE(PeriodLength, SetPeriodLength);
        PrintAmountsInLCY := ShowAmountInLCY;
    end;
}

