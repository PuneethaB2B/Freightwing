report 50022 "Booking Sheet ULD Allocation"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/BookingSheetULDAllocation.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Booking Sheet Line"; "Booking Sheet Line")
        {
            column(BookingSheetNo_BookingSheetLine; "Booking Sheet Line"."Booking Sheet No.")
            {
            }
            column(LineNo_BookingSheetLine; "Booking Sheet Line"."Line No.")
            {
            }
            column(Description_BookingSheetLine; "Booking Sheet Line".Description)
            {
            }
            column(UnitofMeasureCode_BookingSheetLine; "Booking Sheet Line"."Unit of Measure Code")
            {
            }
            column(Type_BookingSheetLine; "Booking Sheet Line".Type)
            {
            }
            column(ItemNo_BookingSheetLine; "Booking Sheet Line"."Item No.")
            {
            }
            column(BookedWeight_BookingSheetLine; "Booking Sheet Line"."Booked Weight")
            {
            }
            column(ActualWeight_BookingSheetLine; "Booking Sheet Line"."Actual Weight")
            {
            }
            column(ULDTypeCode_BookingSheetLine; "Booking Sheet Line"."ULD Type Code")
            {
            }
            column(ULDNo_BookingSheetLine; "Booking Sheet Line"."ULD No.")
            {
            }
            column(Quantity_BookingSheetLine; "Booking Sheet Line".Quantity)
            {
            }
            column(WeightDifference_BookingSheetLine; "Booking Sheet Line"."Weight Difference")
            {
            }
            column(BookedLineAmount_BookingSheetLine; "Booking Sheet Line"."Booked Line Amount")
            {
            }
            column(ActualLineAmount_BookingSheetLine; "Booking Sheet Line"."Actual Line Amount")
            {
            }
            column(RateAmount_BookingSheetLine; "Booking Sheet Line"."Rate Amount")
            {
            }
            column(LocationCode_BookingSheetLine; "Booking Sheet Line"."Location Code")
            {
            }
            column(ProductGroupCode_BookingSheetLine; "Booking Sheet Line"."Product Group Code")
            {
            }
            column(Status_BookingSheetLine; "Booking Sheet Line".Status)
            {
            }
            column(ApprovedBy_BookingSheetLine; "Booking Sheet Line"."Approved By")
            {
            }
            column(ApprovalDate_BookingSheetLine; "Booking Sheet Line"."Approval Date")
            {
            }
            column(ConsigneeCode_BookingSheetLine; "Booking Sheet Line"."Consignee Code")
            {
            }
            column(ClearingAgentCode_BookingSheetLine; "Booking Sheet Line"."Clearing Agent Code")
            {
            }
            column(AirlineCode_BookingSheetLine; "Booking Sheet Line"."Airline Code")
            {
            }
            column(FlightCode_BookingSheetLine; "Booking Sheet Line"."Flight Code")
            {
            }
            column(MAWBNo_BookingSheetLine; "Booking Sheet Line"."MAWB No.")
            {
            }
            column(PortofLoading_BookingSheetLine; "Booking Sheet Line"."Port of Loading")
            {
            }
            column(CutoffTime_BookingSheetLine; "Booking Sheet Line"."Cut-off Time")
            {
            }
            column(DestinationCode_BookingSheetLine; "Booking Sheet Line"."Destination Code")
            {
            }
            column(PortofDischarge_BookingSheetLine; "Booking Sheet Line"."Port of Discharge")
            {
            }
            column(PlaceofDelivery_BookingSheetLine; "Booking Sheet Line"."Place of Delivery")
            {
            }
            column(ViaRouteTransist_BookingSheetLine; "Booking Sheet Line"."Via Route/Transist")
            {
            }
            column(MAWBDate_BookingSheetLine; "Booking Sheet Line"."MAWB Date")
            {
            }
            column(TypeofDelivery_BookingSheetLine; "Booking Sheet Line"."Type of Delivery")
            {
            }
            column(BookingDate_BookingSheetLine; "Booking Sheet Line"."Booking Date")
            {
            }
            column(ShipperCode_BookingSheetLine; "Booking Sheet Line"."Shipper Code")
            {
            }
            column(DivisionFarmCode_BookingSheetLine; "Booking Sheet Line"."Division/Farm Code")
            {
            }
            column(GoodReceiptNo_BookingSheetLine; "Booking Sheet Line"."Good Receipt No.")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPicture; CompInfo.Picture)
            {
            }
            dataitem("Booking Sheet ULD Allocation"; "Booking Sheet ULD Allocation")
            {
                DataItemLink = "Booking Sheet No." = FIELD("Booking Sheet No.");
                column(BookingSheetNo_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."Booking Sheet No.")
                {
                }
                column(AirlineCode_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."Airline Code")
                {
                }
                column(ULDTypeCode_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."ULD Type Code")
                {
                }
                column(Quantity_BookingSheetULDAllocation; "Booking Sheet ULD Allocation".Quantity)
                {
                }
                column(ItemNo_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."Item No.")
                {
                }
                column(ShipperCode_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."Shipper Code")
                {
                }
                column(FlightCode_BookingSheetULDAllocation; "Booking Sheet ULD Allocation"."Flight Code")
                {
                }
                column(Remarks_BookingSheetULDAllocation; "Booking Sheet ULD Allocation".Remarks)
                {
                }
            }
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}

