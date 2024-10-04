report 50060 "Booking Sheet Pre Alert"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/BookingSheetPreAlert.rdl';
    PreviewMode = Normal;
    ApplicationArea = All;

    dataset
    {
        dataitem("Booking Sheet HAWB Allocation"; "Booking Sheet HAWB Allocation")
        {
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(BookingSheetNo_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Booking Sheet No.")
            {
            }
            column(AirlineCode_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Airline Code")
            {
            }
            column(ConsigneeCode_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Consignee Code")
            {
            }
            column(HAWBNo_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."HAWB No.")
            {
            }
            column(ItemNo_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Item No.")
            {
            }
            column(ConsigneeName_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Consignee Name")
            {
            }
            column(MAWBNo_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."MAWB No.")
            {
            }
            column(ShipperCode_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Shipper Code")
            {
            }
            column(HAWBPrepared_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."HAWB Prepared")
            {
            }
            column(FlightCode_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Flight Code")
            {
            }
            column(GrossWeight_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Gross Weight")
            {
            }
            column(ChargeableWeight_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Chargeable Weight")
            {
            }
            column(Quantity_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation".Quantity)
            {
            }
            column(SourceAirport_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Source Airport")
            {
            }
            column(DestinationAirport_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation"."Destination Airport")
            {
            }
            dataitem("Booking Sheet MAWB Allocation"; "Booking Sheet MAWB Allocation")
            {
                DataItemLink = "Booking Sheet No" = FIELD("Booking Sheet No."),
                               "MAWB No" = FIELD("MAWB No."),
                               "Destination Airport" = FIELD("Destination Airport"),
                               "Source Airport" = FIELD("Source Airport"),
                               "Airline Code" = FIELD("Airline Code"),
                               "Shipper Code" = FIELD("Shipper Code");
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
                column(ED; Flight."Departure Time")
                {
                }
                column(EA; Flight."Arrival Time")
                {
                }
                dataitem("Booking Sheet Line"; "Booking Sheet Line")
                {
                    DataItemLink = "Booking Sheet No." = FIELD("Booking Sheet No"),
                                   "Item No." = FIELD("Item No"),
                                   "Source Airport" = FIELD("Source Airport"),
                                   "Shipper Code" = FIELD("Shipper Code"),
                                   "Destination Airport" = FIELD("Destination Airport"),
                                   "Flight Code" = FIELD("Flight No");
                    column(ShippingAgentName; ShippingAgent."Agent Name")
                    {
                    }
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
                    column(SourceAirport_BookingSheetLine; "Booking Sheet Line"."Source Airport")
                    {
                    }
                    column(DestinationAirport_BookingSheetLine; "Booking Sheet Line"."Destination Airport")
                    {
                    }
                    column(SourceCode_BookingSheetLine; "Booking Sheet Line"."Source Code")
                    {
                    }
                    column(ULDTypeCode; gRecBookingSheetULDAlloc."ULD Type Code")
                    {
                    }
                    column(ULDQuantity; gRecBookingSheetULDAlloc.Quantity)
                    {
                    }
                    column(DepartureTime; "Booking Sheet Line"."Departure Time")
                    {
                    }
                    column(ConnectingFlightNo_BookingSheetLine; "Booking Sheet Line"."Connecting Flight No.")
                    {
                    }
                    column(ConnectingFlightDate_BookingSheetLine; "Booking Sheet Line"."Connecting Flight Date")
                    {
                    }
                    column(EstimatedArrivalTime_BookingSheetLine; "Booking Sheet Line"."Estimated Arrival Time")
                    {
                    }
                    column(ConnectedFlightETD_BookingSheetLine; "Booking Sheet Line"."Connected Flight ETD")
                    {
                    }
                    column(ConnectedFlightETA_BookingSheetLine; "Booking Sheet Line"."Connected Flight ETA")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin

                        IF "Booking Sheet Line"."Clearing Agent Code" <> '' THEN
                            ShippingAgent.GET("Booking Sheet Line"."Clearing Agent Code");

                        //Fetch ULD Type and Quantity
                        gRecBookingSheetULDAlloc.RESET;
                        gRecBookingSheetULDAlloc.SETRANGE("Booking Sheet No.", "Booking Sheet Line"."Booking Sheet No.");
                        gRecBookingSheetULDAlloc.SETRANGE("Airline Code", "Booking Sheet HAWB Allocation"."Airline Code");
                        gRecBookingSheetULDAlloc.SETRANGE("Shipper Code", "Booking Sheet HAWB Allocation"."Shipper Code");
                        gRecBookingSheetULDAlloc.SETRANGE("Flight Code", "Booking Sheet HAWB Allocation"."Flight Code");
                        gRecBookingSheetULDAlloc.SETRANGE("MAVB No.", "Booking Sheet HAWB Allocation"."MAWB No.");
                        gRecBookingSheetULDAlloc.SETRANGE("Source Airport", "Booking Sheet HAWB Allocation"."Source Airport");
                        gRecBookingSheetULDAlloc.SETRANGE("Destination Airport", "Booking Sheet HAWB Allocation"."Destination Airport");
                        gRecBookingSheetULDAlloc.SETRANGE(Consignee, "Booking Sheet HAWB Allocation"."Consignee Code");
                        IF gRecBookingSheetULDAlloc.FINDFIRST THEN;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //MESSAGE('HERE');
                    Flight.SETRANGE(Flight."Flight No.", "Booking Sheet MAWB Allocation"."Flight No");
                    Flight.FINDFIRST;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
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
        CompanyInfo: Record "Company Information";
        BookingSheetHeader: Record "Booking Sheet Header";
        ShippingAgent: Record "Shipper Agent";
        Flight: Record Flight;
        gRecBookingSheetULDAlloc: Record "Booking Sheet ULD Allocation";
}

