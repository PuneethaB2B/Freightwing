report 50069 "MAWB Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAWBStatus.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {
            column(AirlineCode_MAWBReceipt; "MAWB Receipt"."Airline Code")
            {
            }
            column(MAWBNo_MAWBReceipt; "MAWB Receipt"."MAWB No.")
            {
            }
            column(ReceiptDate_MAWBReceipt; "MAWB Receipt"."Receipt Date")
            {
            }
            column(MAWBFees_MAWBReceipt; "MAWB Receipt"."MAWB Fees")
            {
            }
            column(Assigned_MAWBReceipt; "MAWB Receipt".Assigned)
            {
            }
            column(FreightChargeCode_MAWBReceipt; "MAWB Receipt"."Freight Charge Code")
            {
            }
            column(Prepared_MAWBReceipt; "MAWB Receipt".Prepared)
            {
            }
            column(PrefixCode_MAWBReceipt; "MAWB Receipt"."Prefix Code")
            {
            }
            column(BillNo_MAWBReceipt; "MAWB Receipt"."Bill No.")
            {
            }
            column(StartNo_MAWBReceipt; "MAWB Receipt"."Start No.")
            {
            }
            column(EndNo_MAWBReceipt; "MAWB Receipt"."End No.")
            {
            }
            column(KAAFees_MAWBReceipt; "MAWB Receipt"."KAA Fees")
            {
            }
            column(Invoiced_MAWBReceipt; "MAWB Receipt".Invoiced)
            {
            }
            column(AirlineName; Airlines.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(AssignedDate_; AssignedDate)
            {
            }
            column(BillTo; InvoicedShipper)
            {
            }
            column(InvoiceNo; Status)
            {
            }
            column(Filters; Filters)
            {
            }
            column(Uninvoiced; InvoicedFilter)
            {
            }
            column(Comment; Comment)
            {
            }
            column(InvoicedAmount; InvoicedAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                InvoicedShipper := '';
                Comment := '';
                AssignedDate := 0D;
                IF "MAWB Receipt"."Airline Code" <> '' THEN
                    Airlines.GET("MAWB Receipt"."Airline Code");
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB Receipt"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    IF BookingSheetHeader.GET(BookingSheetMAWBAllocation."Booking Sheet No") THEN
                        AssignedDate := BookingSheetHeader."Booking Date";
                END;
                IF "MAWB Receipt".Invoiced THEN BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        InvoicedShipper := SalesInvoiceHeader."Bill-to Name";
                    END;
                END ELSE BEGIN
                    BookingSheetMAWBAllocation1.RESET;
                    BookingSheetMAWBAllocation1.SETRANGE(BookingSheetMAWBAllocation1."MAWB No", "MAWB Receipt"."MAWB No.");
                    IF BookingSheetMAWBAllocation1.FINDFIRST THEN BEGIN
                        Customer.GET(BookingSheetMAWBAllocation1."Shipper Code");
                        InvoicedShipper := Customer.Name;
                    END;
                END;
                Status := '';
                InvoicedAmount := 0;
                SalesHeader.RESET;
                SalesHeader.SETRANGE(SalesHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    Status := SalesHeader."No.";
                    SalesHeader.CALCFIELDS(SalesHeader.Amount);
                    IF SalesHeader."Currency Factor" <> 0 THEN
                        InvoicedAmount := SalesHeader.Amount / SalesHeader."Currency Factor"
                    ELSE
                        InvoicedAmount := SalesHeader.Amount;
                    Comment := 'Pending';
                END
                ELSE BEGIN
                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."External Document No.", "MAWB Receipt"."MAWB No.");
                    IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                        Status := SalesInvoiceHeader."No.";
                        SalesInvoiceHeader.CALCFIELDS(SalesInvoiceHeader.Amount);
                        IF SalesInvoiceHeader."Currency Factor" <> 0 THEN
                            InvoicedAmount := SalesInvoiceHeader.Amount / SalesInvoiceHeader."Currency Factor"
                        ELSE
                            InvoicedAmount := SalesInvoiceHeader.Amount;
                        Comment := 'Completely Invoiced';
                    END ELSE BEGIN
                        Status := 'Uninvoiced';
                        InvoicedAmount := 0;
                        Comment := 'Pending';
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                InvoicedFilter := "MAWB Receipt".GETFILTER("MAWB Receipt".Invoiced);
                //Message(InvoicedFilter);
                Filters := "MAWB Receipt".GETFILTERS;
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
        Airlines: Record "50021";
        CompanyInfo: Record "79";
        AssignedDate: Date;
        BookingSheetHeader: Record "50053";
        BookingSheetMAWBAllocation: Record "50070";
        SalesInvoiceHeader: Record "112";
        InvoicedShipper: Text[250];
        BookingSheetMAWBAllocation1: Record "50070";
        Customer: Record "18";
        SalesInvoiceLine: Record "113";
        SalesHeader: Record "36";
        Status: Text[250];
        Filters: Text[250];
        InvoicedFilter: Text[50];
        Comment: Text[250];
        InvoicedAmount: Decimal;
}

