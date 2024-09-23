report 50117 "Dates Audit"
{
    ProcessingOnly = true;

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
                    "MAWB Receipt".Assigned := TRUE;
                END;
                LoadingSheetHeader.RESET;
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF LoadingSheetHeader.FINDFIRST THEN BEGIN
                    "MAWB Receipt"."Assigned Date" := LoadingSheetHeader."Loading Date";
                    "MAWB Receipt".Assigned := TRUE;
                END;
                "MAWB Receipt".MODIFY;
                SLEEP(10);
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Updated');
                Window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("MAWB Receipt"."Assigned Date", 0D);
                Window.OPEN('Updating \Doc No #1### \Line No #2####');
                //
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
        SalesInvoiceHeader: Record "112";
        SalesInvoiceLine: Record "113";
        Window: Dialog;
        BookingSheetMAWBAllocation: Record "50070";
        BookingSheetHeader: Record "50053";
        LoadingSheetHeader: Record "50060";
}

