report 50026 "Curr Reconciliation Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CurrReconciliationVendor.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table380)
        {
            DataItemTableView = WHERE(Entry Type=FILTER(Unrealized Loss|Unrealized Gain));
            column(PostingDate;"Detailed Vendor Ledg. Entry"."Posting Date")
            {
            }
            column(EntryType;"Detailed Vendor Ledg. Entry"."Entry Type")
            {
            }
            column(Vend_PostingDate;gRecVendLedgerEntry."Posting Date")
            {
            }
            column(VendorName;gRecVendor."Search Name")
            {
            }
            column(DocumentNo;gRecVendLedgerEntry."Document No.")
            {
            }
            column(CurrencyCode;"Detailed Vendor Ledg. Entry"."Currency Code")
            {
            }
            column(DetailedAmount;"Detailed Vendor Ledg. Entry"."Amount (LCY)")
            {
            }
            column(OriginalAmount;gRecVendLedgerEntry.Amount)
            {
            }
            column(BookingRate;gDecBookingRate)
            {
            }
            column(AuditRate;gDecAuditRate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Customer Ledger Entries
                gRecVendLedgerEntry.RESET;
                gRecVendLedgerEntry.SETRANGE("Entry No.","Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.");
                IF gRecVendLedgerEntry.FINDFIRST THEN BEGIN
                  gRecVendLedgerEntry.CALCFIELDS(gRecVendLedgerEntry.Amount);
                  gDateEndDate := CALCDATE('CY',gRecVendLedgerEntry."Posting Date");
                END;
                //Customer Name
                IF gRecVendor.GET("Detailed Vendor Ledg. Entry"."Vendor No.") THEN;


                //Booking Rate
                gDecBookingRate := 0;
                gRecCurrExch.RESET;
                gRecCurrExch.SETRANGE("Currency Code",gRecVendLedgerEntry."Currency Code");
                gRecCurrExch.SETFILTER("Starting Date",'<=%1',gRecVendLedgerEntry."Posting Date");
                IF gRecCurrExch.FINDLAST THEN
                  gDecBookingRate := gRecCurrExch."Relational Exch. Rate Amount";

                //Audit Rate
                gDecAuditRate := 0;
                gRecCurrExch.RESET;
                gRecCurrExch.SETRANGE("Currency Code","Detailed Vendor Ledg. Entry"."Currency Code");
                gRecCurrExch.SETFILTER("Starting Date",'<=%1',gDateEndDate);
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
        gRecCurrExch: Record "330";
        gRecVendLedgerEntry: Record "25";
        gDateEndDate: Date;
        gRecVendor: Record "23";
}

