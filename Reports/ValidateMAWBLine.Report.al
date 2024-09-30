report 50103 "Validate MAWB Line"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Line"; "MAWB Line")
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
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        BookingSheetLine: Record "Booking Sheet Line";
}

