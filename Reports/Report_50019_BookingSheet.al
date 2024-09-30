report 50019 "Booking Sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BookingSheet.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Booking Sheet Header"; "Booking Sheet Header")
        {
            RequestFilterFields = "Booking Date", "Shipper Code";
            column(Total; Total)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(PhoneNO; CompanyInfo."Phone No.")
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
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
            column(Comments_BookingSheetHeader; "Booking Sheet Header".Comments)
            {
            }
            column(PrepBy; "Prepared By")
            {
            }
            dataitem("Booking Sheet Line"; "Booking Sheet Line")
            {
                DataItemLink = "Booking Sheet No." = FIELD("No.");
                column(DestinationString; Destination)
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
                column(ConnectingAirline_BookingSheetLine; "Booking Sheet Line"."Connecting Airline")
                {
                }
                column(ConnectingFlightNo_BookingSheetLine; "Booking Sheet Line"."Connecting Flight No.")
                {
                }
                column(ConnectingFlightDate_BookingSheetLine; "Booking Sheet Line"."Connecting Flight Date")
                {
                }
                column(DepartureTime_BookingSheetLine; "Booking Sheet Line"."Departure Time")
                {
                }
                column(ShipmentDeliveryTime_BookingSheetLine; "Booking Sheet Line"."Shipment Delivery Time")
                {
                }
                dataitem("Booking Sheet MAWB Allocation"; "Booking Sheet MAWB Allocation")
                {
                    DataItemLink = "Booking Sheet No" = FIELD("Booking Sheet No."),
                                  "Item No" = FIELD("Item No."),
                                   "Flight No" = FIELD("Flight Code"),
                                   "Destination Airport" = FIELD("Destination Airport"),
                                   "Shipper Code" = FIELD("Shipper Code"),
                                   "Source Airport" = FIELD("Source Airport"),
                                  "Airline Code" = FIELD("Airline Code");
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
                    column(ConsigneeCode_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Consignee Code")
                    {
                    }
                    column(ConsigneeName_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Consignee Name")
                    {
                    }
                    column(ShipperCode_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."Shipper Code")
                    {
                    }
                    column(BSA_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation".BSA)
                    {
                    }
                    column(Houses_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation".Houses)
                    {
                    }
                    column(Invoiced_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation".Invoiced)
                    {
                    }
                    column(Comment_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation".Comment)
                    {
                    }
                    column(MAWBReceived_BookingSheetMAWBAllocation; "Booking Sheet MAWB Allocation"."MAWB Received")
                    {
                    }
                    column(ULD; ULD)
                    {
                    }
                    column(Remarks; Remarks)
                    {
                    }
                    dataitem("Booking Sheet HAWB Allocation"; "Booking Sheet HAWB Allocation")
                    {
                        DataItemLink = "Booking Sheet No." = FIELD("Booking Sheet No"),
                                      "MAWB No." = FIELD("MAWB No"),
                                       "Shipper Code" = FIELD("Shipper Code"),
                                       "Destination Airport" = FIELD("Destination Airport"),
                                      "Airline Code" = FIELD("Airline Code"),
                                      "Source Airport" = FIELD("Source Airport");
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
                        column(Invoiced_BookingSheetHAWBAllocation; "Booking Sheet HAWB Allocation".Invoiced)
                        {
                        }
                        column(Main; Main)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ULD := '';
                            Remarks := '';
                            BookingSheetUlDALLOC.RESET;
                            BookingSheetUlDALLOC.SETRANGE(BookingSheetUlDALLOC."MAVB No.", "Booking Sheet HAWB Allocation"."MAWB No.");
                            BookingSheetUlDALLOC.SETRANGE(BookingSheetUlDALLOC.Consignee, "Booking Sheet HAWB Allocation"."Consignee Code");
                            BookingSheetUlDALLOC.SETRANGE(BookingSheetUlDALLOC."Source Airport", "Booking Sheet HAWB Allocation"."Source Airport");
                            BookingSheetUlDALLOC.SETRANGE(BookingSheetUlDALLOC."Destination Airport", "Booking Sheet HAWB Allocation"."Destination Airport");
                            BookingSheetUlDALLOC.SETRANGE(BookingSheetUlDALLOC."Shipper Code", "Booking Sheet HAWB Allocation"."Shipper Code");
                            IF BookingSheetUlDALLOC.FINDSET THEN BEGIN
                                REPEAT
                                    ULD := ULD + FORMAT(BookingSheetUlDALLOC.Quantity) + ',' + BookingSheetUlDALLOC."ULD Type Code" + '<BR>';
                                    IF Remarks + BookingSheetUlDALLOC.Remarks <> ' ' THEN
                                        Remarks := Remarks + BookingSheetUlDALLOC.Remarks;
                                UNTIL BookingSheetUlDALLOC.NEXT = 0;
                            END ELSE BEGIN
                                ULD := '';
                            END;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    Destination := '';
                    Airports.RESET;
                    Airports.SETRANGE(Airports.Code, "Booking Sheet Line"."Destination Airport");
                    IF Airports.FINDFIRST THEN BEGIN
                        Destination := Airports.Location + '[' + Airports.Code + ']';
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                BookingSheetHeader.RESET;
                BookingSheetHeader.SETRANGE(BookingSheetHeader."No.", "Booking Sheet Header"."No.");
                IF BookingSheetHeader.FINDSET THEN BEGIN
                    REPEAT
                        //MESSAGE('%1 Wt.',"Booking Sheet Header"."Booked Weight");
                        Total += "Booking Sheet Header"."Booked Weight";
                    UNTIL BookingSheetHeader.NEXT = 0;
                END;
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
        HAWB: Record "Booking Sheet HAWB Allocation";
        HAWBNo: Code[50];
        Airports: Record Airport;
        Destination: Text[250];
        Country: Record "Country/Region";
        "ULD Type": Record "Booking Sheet ULD Allocation";
        ULD: Text[250];
        BKSheetConsignee: Record "Booking Sheet HAWB Allocation";
        Remks: Text[250];
        "Prepared By": Text;
        CompanyInfo: Record "Company Information";
        ULDAllocation: Record 50055;
        MAWBAlloc: Record "Booking Sheet MAWB Allocation";
        MAWBString: Text[250];
        Flights: Record Flight;
        DestinationString: Text[250];
        ViaDest: Record "Via Destination";
        ViaDestinations: Text[250];
        BookingSheetUlDALLOC: Record "Booking Sheet ULD Allocation";
        ConsigneeName: Text;
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        Total: Decimal;
        BookingSheetHeader: Record "Booking Sheet Header";
        Main: Boolean;
        Remarks: Text[259];


    procedure BSLineFilters(BSNo: Code[50]; FlightNo: Code[50])
    begin
        IF FlightNo <> '' THEN BEGIN
            "Booking Sheet Line".SETRANGE("Booking Sheet Line"."Flight Code", FlightNo);
        END;
        IF BSNo <> '' THEN BEGIN
            "Booking Sheet Header".SETRANGE("Booking Sheet Header"."No.", BSNo);
            //MESSAGE(BSNo);
        END;
    end;
}

