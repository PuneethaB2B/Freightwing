report 50005 "Goods Receipt Note NP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GoodsReceiptNoteNP.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Good Receipt Notify Party"; "Good Receipt Notify Party")
        {
            column(GoodReceiptNo_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Good Receipt No.")
            {
            }
            column(AirlineCode_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Airline Code")
            {
            }
            column(NotifyPartyNo_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Notify-Party No.")
            {
            }
            column(NotifyPartyName_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Notify-Party Name")
            {
            }
            column(ItemNo_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Item No.")
            {
            }
            column(ShipperCode_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Shipper Code")
            {
            }
            column(FlightCode_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Flight Code")
            {
            }
            column(SourceCode_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Source Code")
            {
            }
            column(SourceType_GoodReceiptNotifyParty; "Good Receipt Notify Party"."Source Type")
            {
            }
            column(CompanyPicture; CompInfo.Picture)
            {
            }
            dataitem("Good Receipt Line"; "Good Receipt Line")
            {
                DataItemLink = "Good Receipt No."=FIELD("Good Receipt No.");
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

