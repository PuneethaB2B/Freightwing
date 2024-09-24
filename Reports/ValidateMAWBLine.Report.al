report 50103 "Validate MAWB Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50076)
        {

            trigger OnAfterGetRecord()
            begin
                IF (("MAWB Line"."Destination Airport" = '') OR ("MAWB Line"."Destination Code" = '')) THEN BEGIN
                    BookingSheetMAWBAllocation.RESET;
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB Line"."MAWB No.");
                    IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                        "MAWB Line"."Destination Airport" := BookingSheetMAWBAllocation."Destination Airport";
                        BookingSheetLine.RESET;
                        BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", BookingSheetMAWBAllocation."Booking Sheet No");
                        IF BookingSheetLine.FINDFIRST THEN
                            "MAWB Line"."Destination Code" := BookingSheetLine."Destination Code";
                        "MAWB Line"."Shipment Date" := BookingSheetLine."Booking Date";
                    END ELSE BEGIN

                    END;
                    "MAWB Line".MODIFY;
                END;
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
        BookingSheetLine: Record "50054";
}
