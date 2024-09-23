report 50004 "Booking Sheet NP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BookingSheetNP.rdlc';

    dataset
    {
        dataitem(DataItem1; Table50057)
        {
            column(BookingSheetNo_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Booking Sheet No.")
            {
            }
            column(AirlineCode_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Airline Code")
            {
            }
            column(NotifyPartyNo_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Notify-Party No.")
            {
            }
            column(NotifyPartyName_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Notify-Party Name")
            {
            }
            column(ItemNo_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Item No.")
            {
            }
            column(ShipperCode_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Shipper Code")
            {
            }
            column(FlightCode_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Flight Code")
            {
            }
            column(SourceCode_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Source Code")
            {
            }
            column(SourceType_BookingSheetNotifyParty; "Booking Sheet Notify Party"."Source Type")
            {
            }
            column(CompPicture; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            dataitem(DataItem48; Table50053)
            {
                DataItemLink = No.=FIELD(Booking Sheet No.);
                RequestFilterFields = "No.";
                column(No_BookingSheetHeader; "Booking Sheet Header"."No.")
                {
                }
                column(BookingDate_BookingSheetHeader; "Booking Sheet Header"."Booking Date")
                {
                }
                column(ShipperCode_BookingSheetHeader; "Booking Sheet Header"."Shipper Code")
                {
                }
                column(ShipperName_BookingSheetHeader; "Booking Sheet Header"."Shipper Name")
                {
                }
                column(ConsigneeCode_BookingSheetHeader; "Booking Sheet Header"."Consignee Code")
                {
                }
                column(ClearingAgentCode_BookingSheetHeader; "Booking Sheet Header"."Clearing Agent Code")
                {
                }
                column(AirlineCode_BookingSheetHeader; "Booking Sheet Header"."Airline Code")
                {
                }
                column(FlightCode_BookingSheetHeader; "Booking Sheet Header"."Flight Code")
                {
                }
                column(MAWBNo_BookingSheetHeader; "Booking Sheet Header"."MAWB No.")
                {
                }
                column(ShipperAddress_BookingSheetHeader; "Booking Sheet Header"."Shipper Address")
                {
                }
                column(Description_BookingSheetHeader; "Booking Sheet Header".Description)
                {
                }
                column(PortofLoading_BookingSheetHeader; "Booking Sheet Header"."Port of Loading")
                {
                }
                column(CutoffTime_BookingSheetHeader; "Booking Sheet Header"."Cut-off Time")
                {
                }
                column(DestinationCode_BookingSheetHeader; "Booking Sheet Header"."Destination Code")
                {
                }
                column(PortofDischarge_BookingSheetHeader; "Booking Sheet Header"."Port of Discharge")
                {
                }
                column(PlaceofDelivery_BookingSheetHeader; "Booking Sheet Header"."Place of Delivery")
                {
                }
                column(ViaRouteTransist_BookingSheetHeader; "Booking Sheet Header"."Via Route/Transist")
                {
                }
                column(BookedWeight_BookingSheetHeader; "Booking Sheet Header"."Booked Weight")
                {
                }
                column(ActualWeight_BookingSheetHeader; "Booking Sheet Header"."Actual Weight")
                {
                }
                column(PreparedBy_BookingSheetHeader; "Booking Sheet Header"."Prepared By")
                {
                }
                column(NoSeries_BookingSheetHeader; "Booking Sheet Header"."No. Series")
                {
                }
                column(WeightDifference_BookingSheetHeader; "Booking Sheet Header"."Weight Difference")
                {
                }
                column(MAWBDate_BookingSheetHeader; "Booking Sheet Header"."MAWB Date")
                {
                }
                column(Received_BookingSheetHeader; "Booking Sheet Header".Received)
                {
                }
                column(Invoiced_BookingSheetHeader; "Booking Sheet Header".Invoiced)
                {
                }
                column(TypeofDelivery_BookingSheetHeader; "Booking Sheet Header"."Type of Delivery")
                {
                }
                dataitem(DataItem11; Table50054)
                {
                    DataItemLink = Booking Sheet No.=FIELD(No.);
                    column(Description_BookingSheetLine; "Booking Sheet Line".Description)
                    {
                    }
                    column(UnitofMeasure_BookingSheetLine; "Booking Sheet Line"."Unit of Measure Code")
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
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "79";
}

