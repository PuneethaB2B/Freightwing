report 50038 Update
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50070)
        {
            column(BookingSheetNo_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Booking Sheet No")
            {
            }
            column(LineNo_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Line No.")
            {
            }
            column(ItemNo_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Item No")
            {
            }
            column(MAWBNo_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."MAWB No")
            {
            }
            column(WeightAllocated_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Weight Allocated")
            {
            }
            column(FlightNo_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Flight No")
            {
            }
            column(AirlineCode_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Airline Code")
            {
            }
            column(SourceAirport_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Source Airport")
            {
            }
            column(DestinationAirport_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Destination Airport")
            {
            }

            trigger OnAfterGetRecord()
            begin
                BookingSheetLine.RESET;
                BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", "Booking Sheet MAWB Allocation"."Booking Sheet No");
                IF BookingSheetLine.FINDFIRST THEN BEGIN
                    "Booking Sheet MAWB Allocation"."Shipper Code" := BookingSheetLine."Shipper Code";
                    "Booking Sheet MAWB Allocation".MODIFY;

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
        MAWBAlloc: Record "50070";
        Flight: Record "50022";
        BookingSheetLine: Record "50054";
}

