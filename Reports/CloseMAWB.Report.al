report 50072 "Close MAWB"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {

            trigger OnAfterGetRecord()
            begin
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB Receipt"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    "MAWB Receipt".Assigned := TRUE;
                    "MAWB Receipt".MODIFY;
                END ELSE BEGIN
                    "MAWB Receipt".Assigned := FALSE;
                    "MAWB Receipt".MODIFY;
                END;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    "MAWB Receipt"."Invioced Date" := SalesInvoiceHeader."Document Date";
                    "MAWB Receipt".Invoiced := TRUE;
                    "MAWB Receipt".MODIFY;
                END ELSE BEGIN
                    "MAWB Receipt"."Invioced Date" := 0D;//TODAY;//SalesInvoiceHeader."Document Date";
                    "MAWB Receipt".Invoiced := FALSE;
                    "MAWB Receipt".MODIFY;

                END;
            end;

            trigger OnPreDataItem()
            begin
                //"MAWB Receipt".SETRANGE("MAWB Receipt".Invoiced,FALSE);
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
        BookingSheetMAWBAllocation: Record "50070";
        SalesInvoiceHeader: Record "112";
}

