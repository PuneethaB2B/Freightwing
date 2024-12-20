report 50018 "Goods Receipt Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/GoodsReceiptNote.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Good Receipt Header"; "Good Receipt Header")
        {
            RequestFilterFields = "No.";
            column(Name; CompanyInfo.Name)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(No_GoodReceiptHeader; "Good Receipt Header"."No.")
            {
            }
            column(ReceiptDate_GoodReceiptHeader; "Good Receipt Header"."Receipt Date")
            {
            }
            column(ShipperCode_GoodReceiptHeader; "Good Receipt Header"."Shipper Code")
            {
            }
            column(ShipperName_GoodReceiptHeader; "Good Receipt Header"."Shipper Name")
            {
            }
            column(ConsigneeCode_GoodReceiptHeader; "Good Receipt Header"."Consignee Code")
            {
            }
            column(ClearingAgentCode_GoodReceiptHeader; "Good Receipt Header"."Clearing Agent Code")
            {
            }
            column(AirlineCode_GoodReceiptHeader; "Good Receipt Header"."Airline Code")
            {
            }
            column(FlightCode_GoodReceiptHeader; "Good Receipt Header"."Flight Code")
            {
            }
            column(MAWBNo_GoodReceiptHeader; "Good Receipt Header"."MAWB No.")
            {
            }
            column(ShipperAddress_GoodReceiptHeader; "Good Receipt Header"."Shipper Address")
            {
            }
            column(Description_GoodReceiptHeader; "Good Receipt Header".Description)
            {
            }
            column(PortofLoading_GoodReceiptHeader; "Good Receipt Header"."Port of Loading")
            {
            }
            column(CutoffTime_GoodReceiptHeader; "Good Receipt Header"."Cut-off Time")
            {
            }
            column(DestinationCode_GoodReceiptHeader; "Good Receipt Header"."Destination Code")
            {
            }
            column(PortofDischarge_GoodReceiptHeader; "Good Receipt Header"."Port of Discharge")
            {
            }
            column(PlaceofDelivery_GoodReceiptHeader; "Good Receipt Header"."Place of Delivery")
            {
            }
            column(ViaRouteTransist_GoodReceiptHeader; "Good Receipt Header"."Via Route/Transist")
            {
            }
            column(BookedWeight_GoodReceiptHeader; "Good Receipt Header"."Booked Weight")
            {
            }
            column(ActualWeight_GoodReceiptHeader; "Good Receipt Header"."Actual Weight")
            {
            }
            column(PreparedBy_GoodReceiptHeader; "Good Receipt Header"."Prepared By")
            {
            }
            column(NoSeries_GoodReceiptHeader; "Good Receipt Header"."No. Series")
            {
            }
            column(WeightDifference_GoodReceiptHeader; "Good Receipt Header"."Weight Difference")
            {
            }
            column(MAWBDate_GoodReceiptHeader; "Good Receipt Header"."MAWB Date")
            {
            }
            column(Received_GoodReceiptHeader; "Good Receipt Header".Received)
            {
            }
            column(Invoiced_GoodReceiptHeader; "Good Receipt Header".Invoiced)
            {
            }
            column(TypeofDelivery_GoodReceiptHeader; "Good Receipt Header"."Type of Delivery")
            {
            }
            column(BookingSheetNo_GoodReceiptHeader; "Good Receipt Header"."Booking Sheet No.")
            {
            }
            column(ExternalDocNo_GoodReceiptHeader; "Good Receipt Header"."External Doc No.")
            {
            }
            column(PostedBy_GoodReceiptHeader; "Good Receipt Header"."Posted By")
            {
            }
            column(VehicleNo_GoodReceiptHeader; "Good Receipt Header"."Vehicle No.")
            {
            }
            column(DriverName_GoodReceiptHeader; "Good Receipt Header"."Driver Name")
            {
            }
            column(VehicleArrivalTime_GoodReceiptHeader; "Good Receipt Header"."Vehicle Arrival Time")
            {
            }
            column(SealNo_GoodReceiptHeader; "Good Receipt Header"."Seal No.")
            {
            }
            column(DeliveryNo_GoodReceiptHeader; "Good Receipt Header"."Delivery No.")
            {
            }
            column(DeliveryDate_GoodReceiptHeader; "Good Receipt Header"."Delivery Date")
            {
            }
            dataitem("Good Receipt Line"; "Good Receipt Line")
            {
                DataItemLink = "Good Receipt No." = FIELD("No.");
                column(GoodReceiptNo_GoodReceiptLine; "Good Receipt Line"."Good Receipt No.")
                {
                }
                column(LineNo_GoodReceiptLine; "Good Receipt Line"."Line No.")
                {
                }
                column(Description_GoodReceiptLine; "Good Receipt Line".Description)
                {
                }
                column(UnitofMeasureCode_GoodReceiptLine; "Good Receipt Line"."Unit of Measure Code")
                {
                }
                column(Type_GoodReceiptLine; "Good Receipt Line".Type)
                {
                }
                column(ItemNo_GoodReceiptLine; "Good Receipt Line"."Item No.")
                {
                }
                column(BookedWeight_GoodReceiptLine; "Good Receipt Line"."Booked Weight")
                {
                }
                column(ActualWeight_GoodReceiptLine; "Good Receipt Line"."Actual Weight")
                {
                }
                column(ULDTypeCode_GoodReceiptLine; "Good Receipt Line"."ULD Type Code")
                {
                }
                column(ULDNo_GoodReceiptLine; "Good Receipt Line"."ULD No.")
                {
                }
                column(Quantity_GoodReceiptLine; "Good Receipt Line".Quantity)
                {
                }
                column(WeightDifference_GoodReceiptLine; "Good Receipt Line"."Weight Difference")
                {
                }
                column(BookedLineAmount_GoodReceiptLine; "Good Receipt Line"."Booked Line Amount")
                {
                }
                column(ActualLineAmount_GoodReceiptLine; "Good Receipt Line"."Actual Line Amount")
                {
                }
                column(RateAmount_GoodReceiptLine; "Good Receipt Line"."Rate Amount")
                {
                }
                column(LocationCode_GoodReceiptLine; "Good Receipt Line"."Location Code")
                {
                }
                column(ProductGroupCode_GoodReceiptLine; "Good Receipt Line"."Product Group Code")
                {
                }
                column(Status_GoodReceiptLine; "Good Receipt Line".Status)
                {
                }
                column(ApprovedBy_GoodReceiptLine; "Good Receipt Line"."Approved By")
                {
                }
                column(ApprovalDate_GoodReceiptLine; "Good Receipt Line"."Approval Date")
                {
                }
                column(ConsigneeCode_GoodReceiptLine; "Good Receipt Line"."Consignee Code")
                {
                }
                column(ClearingAgentCode_GoodReceiptLine; "Good Receipt Line"."Clearing Agent Code")
                {
                }
                column(AirlineCode_GoodReceiptLine; "Good Receipt Line"."Airline Code")
                {
                }
                column(FlightCode_GoodReceiptLine; "Good Receipt Line"."Flight Code")
                {
                }
                column(MAWBNo_GoodReceiptLine; "Good Receipt Line"."MAWB No.")
                {
                }
                column(PortofLoading_GoodReceiptLine; "Good Receipt Line"."Port of Loading")
                {
                }
                column(CutoffTime_GoodReceiptLine; "Good Receipt Line"."Cut-off Time")
                {
                }
                column(DestinationCode_GoodReceiptLine; "Good Receipt Line"."Destination Code")
                {
                }
                column(PortofDischarge_GoodReceiptLine; "Good Receipt Line"."Port of Discharge")
                {
                }
                column(PlaceofDelivery_GoodReceiptLine; "Good Receipt Line"."Place of Delivery")
                {
                }
                column(ViaRouteTransist_GoodReceiptLine; "Good Receipt Line"."Via Route/Transist")
                {
                }
                column(MAWBDate_GoodReceiptLine; "Good Receipt Line"."MAWB Date")
                {
                }
                column(TypeofDelivery_GoodReceiptLine; "Good Receipt Line"."Type of Delivery")
                {
                }
                column(BookingDate_GoodReceiptLine; "Good Receipt Line"."Booking Date")
                {
                }
                column(ShipperCode_GoodReceiptLine; "Good Receipt Line"."Shipper Code")
                {
                }
                column(DivisionFarmCode_GoodReceiptLine; "Good Receipt Line"."Division/Farm Code")
                {
                }
                column(LoadingSheetNo_GoodReceiptLine; "Good Receipt Line"."Loading Sheet No.")
                {
                }
                column(DestinationAirport_GoodReceiptLine; "Good Receipt Line"."Destination Airport")
                {
                }
                column(SourceAirport_GoodReceiptLine; "Good Receipt Line"."Source Airport")
                {
                }
                column(SourceCode_GoodReceiptLine; "Good Receipt Line"."Source Code")
                {
                }
                column(ArrivalTemperature_GoodReceiptLine; "Good Receipt Line"."Arrival Temperature")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
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
}

