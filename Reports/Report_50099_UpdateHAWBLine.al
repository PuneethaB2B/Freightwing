report 50099 "Update HAWB Line"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Booking Sheet MAWB Allocation"; "Booking Sheet MAWB Allocation")
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Booking Sheet MAWB Allocation"."MAWB No");
                IF BookingSheetHeader.GET("Booking Sheet MAWB Allocation"."Booking Sheet No") THEN BEGIN
                    HAWBLine.RESET;
                    HAWBLine.SETRANGE(HAWBLine."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                    IF HAWBLine.FINDSET THEN BEGIN
                        REPEAT
                            Window.UPDATE(2, HAWBLine."HAWB No.");
                            Window.UPDATE(3, BookingSheetHeader."Booking Date");
                            HAWBLine."Shipment Date" := BookingSheetHeader."Booking Date";
                            HAWBLine.MODIFY;
                        UNTIL HAWBLine.NEXT = 0;
                    END;
                END;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating Dates \ MAWB #1### \HAWB #2### \Date #3###');
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
        HAWBLine: Record 50074;
        BookingSheetHeader: Record 50053;
        Window: Dialog;
}

