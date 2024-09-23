report 50011 "Loading Sheet NP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './LoadingSheetNP.rdlc';

    dataset
    {
        dataitem(DataItem1; Table50064)
        {
            column(LoadingSheetNo_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Loading Sheet No.")
            {
            }
            column(AirlineCode_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Airline Code")
            {
            }
            column(NotifyPartyNo_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Notify-Party No.")
            {
            }
            column(NotifyPartyName_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Notify-Party Name")
            {
            }
            column(ItemNo_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Item No.")
            {
            }
            column(ShipperCode_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Shipper Code")
            {
            }
            column(FlightCode_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Flight Code")
            {
            }
            column(SourceCode_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Source Code")
            {
            }
            column(SourceType_LoadingSheetNotifyParty; "Loading Sheet Notify Party"."Source Type")
            {
            }
            dataitem(DataItem11; Table50060)
            {
                DataItemLink = No.=FIELD(Loading Sheet No.);
                RequestFilterFields = "No.";
                column(No_LoadingSheetHeader; "Loading Sheet Header"."No.")
                {
                }
                column(LoadingDate_LoadingSheetHeader; "Loading Sheet Header"."Loading Date")
                {
                }
                column(ShipperCode_LoadingSheetHeader; "Loading Sheet Header"."Shipper Code")
                {
                }
                column(ShipperName_LoadingSheetHeader; "Loading Sheet Header"."Shipper Name")
                {
                }
                column(MAWBNo_LoadingSheetHeader; "Loading Sheet Header"."MAWB No.")
                {
                }
                column(BookingSheetNo_LoadingSheetHeader; "Loading Sheet Header"."Booking Sheet No.")
                {
                }
                column(BookingSheetDate_LoadingSheetHeader; "Loading Sheet Header"."Booking Sheet Date")
                {
                }
                column(FlightCode_LoadingSheetHeader; "Loading Sheet Header"."Flight Code")
                {
                }
                column(DestinationCode_LoadingSheetHeader; "Loading Sheet Header"."Destination Code")
                {
                }
                column(OffloadingStartTime_LoadingSheetHeader; "Loading Sheet Header"."Offloading Start Time")
                {
                }
                column(OffloadingEndTime_LoadingSheetHeader; "Loading Sheet Header"."Offloading End Time")
                {
                }
                column(VehicleNo_LoadingSheetHeader; "Loading Sheet Header"."Vehicle No.")
                {
                }
                column(VehicleArrivalTime_LoadingSheetHeader; "Loading Sheet Header"."Vehicle Arrival Time")
                {
                }
                column(SealNo_LoadingSheetHeader; "Loading Sheet Header"."Seal No.")
                {
                }
                column(ScreenerName_LoadingSheetHeader; "Loading Sheet Header"."Screener Name")
                {
                }
                column(CommodityOrigin_LoadingSheetHeader; "Loading Sheet Header"."Commodity Origin")
                {
                }
                column(ConsigneeCode_LoadingSheetHeader; "Loading Sheet Header"."Consignee Code")
                {
                }
                column(OffloadingPlace_LoadingSheetHeader; "Loading Sheet Header"."Offloading Place")
                {
                }
                column(AirlineCode_LoadingSheetHeader; "Loading Sheet Header"."Airline Code")
                {
                }
                column(PreparedBy_LoadingSheetHeader; "Loading Sheet Header"."Prepared By")
                {
                }
                column(NoSeries_LoadingSheetHeader; "Loading Sheet Header"."No. Series")
                {
                }
                column(Description_LoadingSheetHeader; "Loading Sheet Header".Description)
                {
                }
                column(Shipped_LoadingSheetHeader; "Loading Sheet Header".Shipped)
                {
                }
                column(CompName; CompInfo.Name)
                {
                }
                column(CompPicture; CompInfo.Picture)
                {
                }
                dataitem(DataItem35; Table50061)
                {
                    DataItemLink = Loading Sheet No.=FIELD(No.);
                    column(LoadingSheetNo_LoadingSheetLine; "Loading Sheet Line"."Loading Sheet No.")
                    {
                    }
                    column(LineNo_LoadingSheetLine; "Loading Sheet Line"."Line No.")
                    {
                    }
                    column(Description_LoadingSheetLine; "Loading Sheet Line".Description)
                    {
                    }
                    column(UnitofMeasureCode_LoadingSheetLine; "Loading Sheet Line"."Unit of Measure Code")
                    {
                    }
                    column(DivisionFarmCode_LoadingSheetLine; "Loading Sheet Line"."Division/Farm Code")
                    {
                    }
                    column(FWLDocketNo_LoadingSheetLine; "Loading Sheet Line"."FWL Docket No.")
                    {
                    }
                    column(FWLDocketWeight_LoadingSheetLine; "Loading Sheet Line"."FWL Docket Weight")
                    {
                    }
                    column(FWLGrossWeight_LoadingSheetLine; "Loading Sheet Line"."FWL Gross Weight")
                    {
                    }
                    column(AirlineDocketWeight_LoadingSheetLine; "Loading Sheet Line"."Airline Docket Weight")
                    {
                    }
                    column(Quantity_LoadingSheetLine; "Loading Sheet Line".Quantity)
                    {
                    }
                    column(ULDTypeCode_LoadingSheetLine; "Loading Sheet Line"."ULD Type Code")
                    {
                    }
                    column(SkidPer_LoadingSheetLine; "Loading Sheet Line"."Skid Per")
                    {
                    }
                    column(ULDNo_LoadingSheetLine; "Loading Sheet Line"."ULD No.")
                    {
                    }
                    column(ULDQuantity_LoadingSheetLine; "Loading Sheet Line"."ULD Quantity")
                    {
                    }
                    column(Position_LoadingSheetLine; "Loading Sheet Line".Position)
                    {
                    }
                    column(ArrivalTemperature_LoadingSheetLine; "Loading Sheet Line"."Arrival Temperature")
                    {
                    }
                    column(DepartureTemperature_LoadingSheetLine; "Loading Sheet Line"."Departure Temperature")
                    {
                    }
                    column(XRay_LoadingSheetLine; "Loading Sheet Line"."X-Ray")
                    {
                    }
                    column(ShipperCode_LoadingSheetLine; "Loading Sheet Line"."Shipper Code")
                    {
                    }
                    column(FlightCode_LoadingSheetLine; "Loading Sheet Line"."Flight Code")
                    {
                    }
                    column(DestinationCode_LoadingSheetLine; "Loading Sheet Line"."Destination Code")
                    {
                    }
                    column(ConsigneeCode_LoadingSheetLine; "Loading Sheet Line"."Consignee Code")
                    {
                    }
                    column(AirlineCode_LoadingSheetLine; "Loading Sheet Line"."Airline Code")
                    {
                    }
                    column(MAWBNo_LoadingSheetLine; "Loading Sheet Line"."MAWB No.")
                    {
                    }
                    column(Type_LoadingSheetLine; "Loading Sheet Line".Type)
                    {
                    }
                    column(ItemNo_LoadingSheetLine; "Loading Sheet Line"."Item No.")
                    {
                    }
                    column(LocationCode_LoadingSheetLine; "Loading Sheet Line"."Location Code")
                    {
                    }
                    column(QuantityAvailable_LoadingSheetLine; "Loading Sheet Line"."Quantity Available")
                    {
                    }
                    column(LoadingQuantity_LoadingSheetLine; "Loading Sheet Line"."Loading Quantity")
                    {
                    }
                    column(ShippedQuantity_LoadingSheetLine; "Loading Sheet Line"."Shipped Quantity")
                    {
                    }
                    column(BalanceQuantity_LoadingSheetLine; "Loading Sheet Line"."Balance Quantity")
                    {
                    }
                    column(Temperature_LoadingSheetLine; "Loading Sheet Line".Temperature)
                    {
                    }
                    column(Return_LoadingSheetLine; "Loading Sheet Line".Return)
                    {
                    }
                    column(ReturntoLocationCode_LoadingSheetLine; "Loading Sheet Line"."Return-to Location Code")
                    {
                    }
                    column(GatePassNo_LoadingSheetLine; "Loading Sheet Line"."Gate-Pass No.")
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "79";
}

