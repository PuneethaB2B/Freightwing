report 50021 "Loading Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/LoadingSheet.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Loading Sheet Header"; "Loading Sheet Header")
        {
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
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
            column(AirlineCode_LoadingSheetHeader; "Loading Sheet Header"."Airline Code")
            {
            }
            column(OffloadingPlace_LoadingSheetHeader; "Loading Sheet Header"."Offloading Place")
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
            column(PostedBy_LoadingSheetHeader; "Loading Sheet Header"."Posted By")
            {
            }
            dataitem("Loading Sheet Line"; "Loading Sheet Line")
            {
                DataItemLink = "Loading Sheet No." = FIELD("No.");
                column(Dimension; Dim)
                {
                }
                column(Origin; Origin)
                {
                }
                column(uldstring; ULDString)
                {
                }
                column(ULDNos; Uldnos)
                {
                }
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
                column(Dimension_LoadingSheetLine; "Loading Sheet Line".Dimension)
                {
                }
                column(Length_LoadingSheetLine; "Loading Sheet Line".Length)
                {
                }
                column(Width_LoadingSheetLine; "Loading Sheet Line".Width)
                {
                }
                column(Height_LoadingSheetLine; "Loading Sheet Line".Height)
                {
                }
                column(ConsigneeName_LoadingSheetLine; "Loading Sheet Line"."Consignee Name")
                {
                }
                dataitem("Loading Sheet ULD Allocation"; "Loading Sheet ULD Allocation")
                {
                    DataItemLink = "Loading Sheet No." = FIELD("Loading Sheet No."),
                                   "Airline Code" = FIELD("Airline Code"),
                                   "Item No." = FIELD("Item No."),
                                   "MWAB No." = FIELD("MAWB No."),
                                   FAM = FIELD("Division/Farm Code");
                    column(LoadingSheetNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."Loading Sheet No.")
                    {
                    }
                    column(AirlineCode_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."Airline Code")
                    {
                    }
                    column(ULDTypeCode_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."ULD Type Code")
                    {
                    }
                    column(Quantity_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation".Quantity)
                    {
                    }
                    column(ItemNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."Item No.")
                    {
                    }
                    column(ULDNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."ULD No.")
                    {
                    }
                    column(Remarks_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation".Remarks)
                    {
                    }
                    column(LineNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."Line No")
                    {
                    }
                    column(FWLDocketWeight_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."FWL Docket Weight")
                    {
                    }
                    column(MWABNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."MWAB No.")
                    {
                    }
                    column(FWLDocketNo_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."FWL Docket No.")
                    {
                    }
                    column(FAM_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation".FAM)
                    {
                    }
                    column(NoOfBoxes_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation"."No. Of Boxes")
                    {
                    }
                    column(Dimension_LoadingSheetULDAllocation; "Loading Sheet ULD Allocation".Dimension)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ULDString := '';
                    Uldnos := 0;
                    "Loading Sheet Line".CALCFIELDS("Loading Sheet Line"."FWL Docket Weight");
                    LoadingSheetULDs.RESET;
                    LoadingSheetULDs.SETRANGE(LoadingSheetULDs."Loading Sheet No.", "Loading Sheet Line"."Loading Sheet No.");
                    LoadingSheetULDs.SETRANGE(LoadingSheetULDs."MWAB No.", "Loading Sheet Line"."MAWB No.");
                    IF LoadingSheetULDs.FINDSET THEN BEGIN
                        REPEAT
                            Uldnos += 1;
                            ULDString := ULDString + LoadingSheetULDs."ULD Type Code" + ' / ' + LoadingSheetULDs."ULD No." + '(' + FORMAT(LoadingSheetULDs."FWL Docket Weight") + ')Kgs';
                        UNTIL LoadingSheetULDs.NEXT = 0;
                    END;
                    Dim := "Loading Sheet Line".Length * "Loading Sheet Line".Width * "Loading Sheet Line".Height;
                    Flights.RESET;
                    Flights.SETRANGE(Flights."Flight No.", "Loading Sheet Line"."Flight Code");
                    IF Flights.FINDFIRST THEN BEGIN
                        Origin := Flights."Source Airport";
                    END;
                end;
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
        LoadingSheetULDs: Record "Loading Sheet ULD Allocation";
        Uldnos: Integer;
        ULDString: Text[250];
        Dim: Decimal;
        Origin: Code[10];
        Flights: Record Flight;
}

