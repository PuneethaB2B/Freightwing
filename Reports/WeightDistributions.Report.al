report 50056 "Weight Distributions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WeightDistributions.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50040)
        {
            column(DistributionDate_DlWeightDistHeader; "Dl. Weight Dist. Header"."Distribution Date")
            {
            }
            column(No_DlWeightDistHeader; "Dl. Weight Dist. Header"."No.")
            {
            }
            column(DayofWeek_DlWeightDistHeader; "Dl. Weight Dist. Header"."Day of Week")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            dataitem(DataItem1000000001; Table50041)
            {
                DataItemLink = Daily No.=FIELD(No.);
                column(AirlineCode_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Airline Code")
                {
                }
                column(AirlineName_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Airline Name")
                {
                }
                column(TotalCapacityPlanned_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Total Capacity Planned")
                {
                }
                column(ActualWeightBooked_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Actual Weight Booked")
                {
                }
                column(DestinationCode_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Destination Code")
                {
                }
                column(FlightCode_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Flight Code")
                {
                }
                column(SourceCode_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Source Code")
                {
                }
                column(SourceAirport_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Source Airport")
                {
                }
                column(DestinationAirport_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Destination Airport")
                {
                }
                dataitem(DataItem1000000002; Table50042)
                {
                    DataItemLink = Daily No.=FIELD(Daily No.),
                                   Airline Code=FIELD(Airline Code),
                                   Destination Airport=FIELD(Destination Airport);
                    column(CustomerNo_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Customer No.")
                    {
                    }
                    column(CustomerName_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Customer Name")
                    {
                    }
                    column(GrossWeight_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Gross Weight")
                    {
                    }
                    column(DestinationCode_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Destination Code")
                    {
                    }
                    column(DestinationAirport_DlWeightDistByCustomer;"Dl. Weight Dist. By Customer"."Destination Airport")
                    {
                    }
                    dataitem(DataItem1000000003;Table50043)
                    {
                        DataItemLink = Daily No.=FIELD(Daily No.),
                                       Airline Code=FIELD(Airline Code),
                                       Customer No.=FIELD(Customer No.),
                                       Destination Airport=FIELD(Destination Airport),
                                       Destination Code=FIELD(Destination Code);
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
                        column(DestinationAirport_DlWeightDistByItem;"Dl. Weight Dist. By Item"."Destination Airport")
                        {
                        }
                    }
                }
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
        CompanyInfo: Record "79";
}

