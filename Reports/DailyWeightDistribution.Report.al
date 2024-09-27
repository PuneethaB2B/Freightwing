report 50020 "Daily Weight Distribution"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DailyWeightDistribution.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem45; Table50040)
        {
            RequestFilterFields = "Distribution Date";
            RequestFilterHeading = 'Date Filter';
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(DistributionDate_DlWeightDistHeader; "Dl. Weight Dist. Header"."Distribution Date")
            {
            }
            column(No_DlWeightDistHeader; "Dl. Weight Dist. Header"."No.")
            {
            }
            column(NoSeries_DlWeightDistHeader; "Dl. Weight Dist. Header"."No. Series")
            {
            }
            column(DayofWeek_DlWeightDistHeader; "Dl. Weight Dist. Header"."Day of Week")
            {
            }
            column(Description_DlWeightDistHeader; "Dl. Weight Dist. Header".Description)
            {
            }
            column(DailyFilter; DailyFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            dataitem(DataItem1; Table50041)
            {
                DataItemLink = Distribution Date=FIELD(Distribution Date),
                               Daily No.=FIELD(No.);
                RequestFilterHeading = 'Airline Filter';
                column(DailyNo_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Daily No.")
                {
                }
                column(AirlineCode_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Airline Code")
                {
                }
                column(AirlineName_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Airline Name")
                {
                }
                column(TotalCapacityPlanned_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Total Capacity Planned")
                {
                }
                column(ActualWeightBooked_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Actual Weight Booked")
                {
                }
                column(CutoffTime_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Cut-off Time")
                {
                }
                column(CapacityAvailable_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Capacity Available")
                {
                }
                column(Difference_DlWeightDistByAirline;"Dl. Weight Dist. By Airline".Difference)
                {
                }
                column(TotalWeightAllocated_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Total Weight Allocated")
                {
                }
                column(DayofWeek_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Day of Week")
                {
                }
                column(DestinationCode_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Destination Code")
                {
                }
                column(ActualDepartureTime_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Actual Departure Time")
                {
                }
                column(FlightCode_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Flight Code")
                {
                }
                column(DistributionDate_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Distribution Date")
                {
                }
                column(ScheduledDepartureTime_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Scheduled Departure Time")
                {
                }
                column(ETD;ETD)
                {
                }
                column(ULDString;ULDString)
                {
                }
                column(Remarks;Remarks)
                {
                }
                column(AirlineFilter;AirlineFilter)
                {
                }
                column(DestinationAirport_DlWeightDistByAirline;"Dl. Weight Dist. By Airline"."Destination Airport")
                {
                }
                dataitem(DataItem17;Table50042)
                {
                    DataItemLink = Daily No.=FIELD(Daily No.),
                                   Airline Code=FIELD(Airline Code),
                                   Destination Code=FIELD(Destination Code),
                                   Destination Airport=FIELD(Destination Airport),
                                   Flight Code=FIELD(Flight Code),
                                   Distribution Date=FIELD(Distribution Date);
                    RequestFilterHeading = 'Customer Filter';
                    column(DailyNo_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Daily No.")
                    {
                    }
                    column(AirlineCode_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Airline Code")
                    {
                    }
                    column(CustomerNo_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Customer No.")
                    {
                    }
                    column(CustomerName_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Customer Name")
                    {
                    }
                    column(GrossWeight_DlSWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Gross Weight")
                    {
                    }
                    column(DestinationCode_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Destination Code")
                    {
                    }
                    column(DayofWeek_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Day of Week")
                    {
                    }
                    column(FlightCode_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Flight Code")
                    {
                    }
                    column(DistributionDate_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Distribution Date")
                    {
                    }
                    column(CustomerFilter;CustomerFilter)
                    {
                    }
                    dataitem(DataItem27;Table50043)
                    {
                        DataItemLink = Daily No.=FIELD(Daily No.),
                                       Airline Code=FIELD(Airline Code),
                                       Customer No.=FIELD(Customer No.),
                                       Distribution Date=FIELD(Distribution Date),
                                       Destination Code=FIELD(Destination Code),
                                       Flight Code=FIELD(Flight Code),
                                       Destination Airport=FIELD(Destination Airport);
                        RequestFilterHeading = 'Item Filter';
                        column(DailyNo_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Daily No.")
                        {
                        }
                        column(AirlineCode_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Airline Code")
                        {
                        }
                        column(CustomerNo_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Customer No.")
                        {
                        }
                        column(ItemNo_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Item No.")
                        {
                        }
                        column(Description_DlWeightDistByItem;"Dl. Weight Dist. By Item".Description)
                        {
                        }
                        column(GrossWeight_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Gross Weight")
                        {
                        }
                        column(DistributionDate_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Distribution Date")
                        {
                        }
                        column(BookingSheetNo_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Booking Sheet No.")
                        {
                        }
                        column(UnitofMeasure_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Unit of Measure")
                        {
                        }
                        column(DestinationCode_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Destination Code")
                        {
                        }
                        column(DayofWeek_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Day of Week")
                        {
                        }
                        column(FlightCode_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(ShippedWeight_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Shipped Weight")
                        {
                        }
                        column(DailyNo_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(AirlineCode_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(ULDType_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(Quantity_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(Remarks_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(Flight_DlULDAllocationByAirline;"Dl. Weight Dist. By Item"."Flight Code")
                        {
                        }
                        column(DestinationAirport_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Destination Airport")
                        {
                        }
                        column(Location;Airport.Location)
                        {
                        }
                        column(BookingSheetULD;gTxtBookingSheetULD)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                             ItemFilter:="Dl. Weight Dist. By Item".GETFILTERS;
                             //MESSAGE(ItemFilter);
                            IF Airport.GET("Dl. Weight Dist. By Item"."Destination Code","Dl. Weight Dist. By Item"."Destination Airport") THEN;
                            //FetchULD
                            gTxtBookingSheetULD := '';
                            gRecBookingSheetLine.RESET;
                            gRecBookingSheetLine.SETRANGE("Booking Date","Dl. Weight Dist. Header"."Distribution Date");
                            gRecBookingSheetLine.SETRANGE("Destination Code","Dl. Weight Dist. By Item"."Destination Code");
                            gRecBookingSheetLine.SETRANGE("Airline Code","Dl. Weight Dist. By Item"."Airline Code");
                            gRecBookingSheetLine.SETRANGE("Item No.","Dl. Weight Dist. By Item"."Item No.");
                            IF gRecBookingSheetLine.FINDSET THEN
                              REPEAT
                                gRecBookingSheetLineULD.RESET;
                                gRecBookingSheetLineULD.SETRANGE("Booking Sheet No.",gRecBookingSheetLine."Booking Sheet No.");
                                gRecBookingSheetLineULD.SETRANGE("Airline Code",gRecBookingSheetLine."Airline Code");
                                gRecBookingSheetLineULD.SETRANGE("Shipper Code",gRecBookingSheetLine."Shipper Code");
                                //gRecBookingSheetLineULD.SETRANGE("Item No.","Dl. Weight Dist. By Item"."Item No.");
                                gRecBookingSheetLineULD.SETRANGE("Destination Airport",gRecBookingSheetLine."Destination Airport");
                                IF gRecBookingSheetLineULD.FINDFIRST THEN
                                  gTxtBookingSheetULD := gRecBookingSheetLineULD."ULD Type Code"

                            UNTIL gRecBookingSheetLine.NEXT = 0;
                        end;
                    }

                    trigger OnPostDataItem()
                    begin
                        CustomerFilter:="Dl. Weight Dist. By Customer".GETFILTERS;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    FlightSchedule.RESET;
                    FlightSchedule.SETRANGE(FlightSchedule."Airline Code","Dl. Weight Dist. By Airline"."Airline Code");
                    FlightSchedule.SETRANGE(FlightSchedule."Flight Code","Dl. Weight Dist. By Airline"."Flight Code");
                    FlightSchedule.SETRANGE(FlightSchedule."Destination Code","Dl. Weight Dist. By Airline"."Destination Code");
                    IF FlightSchedule.FIND('-') THEN
                     ETD:=FlightSchedule."Departure Time";

                    WITH "Dl. Weight Dist. By Airline" DO BEGIN
                    ULDString:= '';
                    Remarks:='';
                    ULDS.RESET;
                    ULDS.SETRANGE(ULDS."Daily No.","Dl. Weight Dist. By Airline"."Daily No.");
                    ULDS.SETRANGE(ULDS."Airline Code","Dl. Weight Dist. By Airline"."Airline Code");
                    ULDS.SETRANGE(ULDS.Flight,"Dl. Weight Dist. By Airline"."Flight Code");
                    ULDS.SETRANGE(ULDS."Destination Airport","Dl. Weight Dist. By Airline"."Destination Airport");
                    IF ULDS.FINDSET THEN
                    BEGIN
                      REPEAT
                      //ULDString :=ULDString+ FORMAT(ULDS.Quantity)+' '+ULDS."ULD Type"+'<br>';
                      Remarks:=Remarks+ULDS.Remarks+'<br>';
                      UNTIL ULDS.NEXT = 0;
                    END;


                    END;
                end;

                trigger OnPostDataItem()
                begin
                    AirlineFilter:="Dl. Weight Dist. By Airline".GETFILTERS;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
            end;

            trigger OnPostDataItem()
            begin
                DailyFilter:="Dl. Weight Dist. Header".GETFILTERS;
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
        CompanyInfo: Record "79";
        FlightSchedule: Record "50022";
        ETD: Time;
        ULDS: Record "50044";
        ULDString: Text[250];
        DailyFilter: Text[250];
        AirlineFilter: Text[250];
        ItemFilter: Text[250];
        CustomerFilter: Text[250];
        Remarks: Text[250];
        Airport: Record "50019";
        gRecBookingSheetLineULD: Record "50055";
        gRecBookingSheetLine: Record "50054";
        gTxtBookingSheetULD: Code[50];
}

