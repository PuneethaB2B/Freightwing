report 50073 "Update MAWB receipt Batch"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "MAWB Receipt"."MAWB No.");
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB Receipt"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    IF BookingSheetHeader.GET(BookingSheetMAWBAllocation."Booking Sheet No") THEN
                        "MAWB Receipt"."Assigned Date" := BookingSheetHeader."Booking Date";
                END;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF SalesInvoiceHeader.FINDFIRST THEN
                    "MAWB Receipt"."Invioced Date" := SalesInvoiceHeader."Document Date";
                "MAWB Receipt".Invoiced := TRUE;

                "MAWB Receipt".MODIFY;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Updating MAWBs \MAWB No. #1####');
                SETRANGE("MAWB Receipt".Invoiced, FALSE);
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
        BookingSheetMAWBAllocation: Record "50070";
        BookingSheetHeader: Record "50053";
        SalesInvoiceHeader: Record "112";
}

