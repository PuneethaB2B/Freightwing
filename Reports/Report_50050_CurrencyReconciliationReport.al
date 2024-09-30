report 50050 "Currency Reconciliation Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/CurrencyReconciliationReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE(Open = CONST(true),
                                      "Currency Code" = FILTER(<> ''));
            column(ShowCustomer; gBoolShowCustomer)
            {
            }
            column(ShowVendor; gBoolShowVendor)
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(CustomerNo_CustLedgerEntry; gRecCustomer."Search Name")
            {
            }
            column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
            {
            }
            column(Amount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(BookingRate_Customer; gDecBookingRate)
            {
            }
            column(AuditRate_Customer; gDecAuditRate)
            {
            }
            column(AmountLCY_Customer; gDecCustomerAmtLCY)
            {
            }
            column(RateDiff_Customer; gDecCustRateDiff)
            {
            }
            column(UnRealAmt_Customer; gDecCustUnRealAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Customer Name
                IF gRecCustomer.GET("Cust. Ledger Entry"."Customer No.") THEN;
                //Booking Rate
                CLEAR(gDecBookingRate);
                gRecCurrencyExch.RESET;
                gRecCurrencyExch.SETRANGE("Currency Code", "Cust. Ledger Entry"."Currency Code");
                gRecCurrencyExch.SETFILTER("Starting Date", '<=%1', "Cust. Ledger Entry"."Posting Date");
                IF gRecCurrencyExch.FINDLAST THEN
                    gDecBookingRate := gRecCurrencyExch."Relational Exch. Rate Amount";

                //Audit Rate
                CLEAR(gDecAuditRate);
                gRecCurrencyExch.RESET;
                gRecCurrencyExch.SETRANGE("Currency Code", "Cust. Ledger Entry"."Currency Code");
                gRecCurrencyExch.SETFILTER("Starting Date", '<=%1', gDateEndDate);
                IF gRecCurrencyExch.FINDLAST THEN
                    gDecAuditRate := gRecCurrencyExch."Relational Exch. Rate Amount";

                //Amount in LCY
                gDecCustomerAmtLCY := gDecBookingRate * "Cust. Ledger Entry"."Remaining Amount";

                //Rate Difference
                gDecCustRateDiff := gDecAuditRate - gDecBookingRate;

                //UnRealizing amount
                gDecCustUnRealAmt := gDecCustRateDiff * "Cust. Ledger Entry"."Remaining Amount";
            end;

            trigger OnPreDataItem()
            begin
                "Cust. Ledger Entry".SETRANGE("Posting Date", gDateStartDate, gDateEndDate);
            end;
        }
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = WHERE(Open = CONST(true),
                                      "Currency Code" = FILTER(<> ''));
            column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(VendorNo_VendorLedgerEntry; gRecVendor."Search Name")
            {
            }
            column(CurrencyCode_VendorLedgerEntry; "Vendor Ledger Entry"."Currency Code")
            {
            }
            column(RemainingAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Remaining Amount")
            {
            }
            column(BookingRate_Vendor; gDecBookingRate2)
            {
            }
            column(AuditRate_Vendor; gDecAuditRate2)
            {
            }
            column(AmountLCY_Vendor; gDecVendorAmtLCY)
            {
            }
            column(RateDiff_Vendor; gDecVendRateDiff)
            {
            }
            column(UnRealAmt_Vendor; gDecVendUnRealAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Vendor Name
                IF gRecVendor.GET("Vendor Ledger Entry"."Vendor No.") THEN;

                //Booking Rate
                CLEAR(gDecBookingRate2);
                gRecCurrencyExch.RESET;
                gRecCurrencyExch.SETRANGE("Currency Code", "Vendor Ledger Entry"."Currency Code");
                gRecCurrencyExch.SETFILTER("Starting Date", '<=%1', "Vendor Ledger Entry"."Posting Date");
                IF gRecCurrencyExch.FINDLAST THEN
                    gDecBookingRate2 := gRecCurrencyExch."Relational Exch. Rate Amount";

                //Audit Rate
                CLEAR(gDecAuditRate2);
                gRecCurrencyExch.RESET;
                gRecCurrencyExch.SETRANGE("Currency Code", "Vendor Ledger Entry"."Currency Code");
                gRecCurrencyExch.SETFILTER("Starting Date", '<=%1', gDateEndDate);
                IF gRecCurrencyExch.FINDLAST THEN
                    gDecAuditRate2 := gRecCurrencyExch."Relational Exch. Rate Amount";

                //Amount in LCY
                gDecVendorAmtLCY := gDecBookingRate2 * "Vendor Ledger Entry"."Remaining Amount";

                //Rate Difference
                gDecVendRateDiff := gDecAuditRate2 - gDecBookingRate2;

                //UnRealizing amount
                gDecVendUnRealAmt := gDecVendRateDiff * "Vendor Ledger Entry"."Remaining Amount";
            end;

            trigger OnPreDataItem()
            begin
                "Vendor Ledger Entry".SETRANGE("Posting Date", gDateStartDate, gDateEndDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show Customer"; gBoolShowCustomer)
                {
                }
                field("Show Vendor"; gBoolShowVendor)
                {
                }
                field("Start Date"; gDateStartDate)
                {
                }
                field("End Date"; gDateEndDate)
                {
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF (gDateStartDate = 0D) OR (gDateEndDate = 0D) THEN
            ERROR('Please enter Start and End Dates');
    end;

    var
        gDateStartDate: Date;
        gDateEndDate: Date;
        gRecCurrencyExch: Record "Currency Exchange Rate";
        gRecCustomer: Record Customer;
        gBoolShowCustomer: Boolean;
        gBoolShowVendor: Boolean;
        gDecBookingRate: Decimal;
        gDecAuditRate: Decimal;
        gRecVendor: Record Vendor;
        gDecBookingRate2: Decimal;
        gDecAuditRate2: Decimal;
        gDecCustomerAmtLCY: Decimal;
        gDecVendorAmtLCY: Decimal;
        gDecCustRateDiff: Decimal;
        gDecVendRateDiff: Decimal;
        gDecCustUnRealAmt: Decimal;
        gDecVendUnRealAmt: Decimal;
}

