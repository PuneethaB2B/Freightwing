report 50027 "Curr Reconciliation Customer"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/CurrReconciliationCustomer.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            DataItemTableView = WHERE("Entry Type" = FILTER("Unrealized Loss" | "Unrealized Gain"));
            column(PostingDate; "Detailed Cust. Ledg. Entry"."Posting Date")
            {
            }
            column(EntryType; "Detailed Cust. Ledg. Entry"."Entry Type")
            {
            }
            column(Cust_PostingDate; gRecCustLedgerEntry."Posting Date")
            {
            }
            column(CustomerName; gRecCustomer."Search Name")
            {
            }
            column(DocumentNo; gRecCustLedgerEntry."Document No.")
            {
            }
            column(CurrencyCode; "Detailed Cust. Ledg. Entry"."Currency Code")
            {
            }
            column(DetailedAmount; "Detailed Cust. Ledg. Entry"."Amount (LCY)")
            {
            }
            column(OriginalAmount; gRecCustLedgerEntry.Amount)
            {
            }
            column(BookingRate; gDecBookingRate)
            {
            }
            column(AuditRate; gDecAuditRate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Customer Ledger Entries
                gRecCustLedgerEntry.RESET;
                gRecCustLedgerEntry.SETRANGE("Entry No.", "Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.");
                IF gRecCustLedgerEntry.FINDFIRST THEN BEGIN
                    gRecCustLedgerEntry.CALCFIELDS(gRecCustLedgerEntry.Amount);
                    gDateEndDate := CALCDATE('CY', gRecCustLedgerEntry."Posting Date");
                END;
                //Customer Name
                IF gRecCustomer.GET("Detailed Cust. Ledg. Entry"."Customer No.") THEN;


                //Booking Rate
                gDecBookingRate := 0;
                gRecCurrExch.RESET;
                gRecCurrExch.SETRANGE("Currency Code", gRecCustLedgerEntry."Currency Code");
                gRecCurrExch.SETFILTER("Starting Date", '<=%1', gRecCustLedgerEntry."Posting Date");
                IF gRecCurrExch.FINDLAST THEN
                    gDecBookingRate := gRecCurrExch."Relational Exch. Rate Amount";

                //Audit Rate
                gDecAuditRate := 0;
                gRecCurrExch.RESET;
                gRecCurrExch.SETRANGE("Currency Code", "Detailed Cust. Ledg. Entry"."Currency Code");
                gRecCurrExch.SETFILTER("Starting Date", '<=%1', gDateEndDate);
                IF gRecCurrExch.FINDLAST THEN
                    gDecAuditRate := gRecCurrExch."Relational Exch. Rate Amount";
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
        gDecAuditRate: Decimal;
        gDecBookingRate: Decimal;
        gRecCurrExch: Record "Currency Exchange Rate";
        gRecCustLedgerEntry: Record "Cust. Ledger Entry";
        gDateEndDate: Date;
        gRecCustomer: Record Customer;
}

