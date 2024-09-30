report 50117 "Dates Audit"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Window: Dialog;
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        BookingSheetHeader: Record "Booking Sheet Header";
        LoadingSheetHeader: Record "Loading Sheet Header";
}

