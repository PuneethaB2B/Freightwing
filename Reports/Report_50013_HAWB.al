report 50013 HAWB
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/HAWB.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("HAWB Header"; "HAWB Header")
        {
            RequestFilterFields = "No.";
            column(No_HAWBHeader; "HAWB Header"."No.")
            {
            }
            column(ShipperCode_HAWBHeader; "HAWB Header"."Shipper Code")
            {
            }
            column(ShipperAddress_HAWBHeader; "HAWB Header"."Shipper Address")
            {
            }
            column(ShipperName_HAWBHeader; "HAWB Header"."Shipper Name")
            {
            }
            column(ConsigneeCode_HAWBHeader; "HAWB Header"."Consignee Code")
            {
            }
            column(ConsigneeName_HAWBHeader; "HAWB Header"."Consignee Name")
            {
            }
            column(AgentsIATACode_HAWBHeader; "HAWB Header"."Agent's IATA Code")
            {
            }
            column(CarrierAgentCode_HAWBHeader; "HAWB Header"."Carrier Agent Code")
            {
            }
            column(SourceAirport_HAWBHeader; "HAWB Header"."Source Airport")
            {
            }
            column(AirlineCode_HAWBHeader; "HAWB Header"."Airline Code")
            {
            }
            column(DestinationAirport_HAWBHeader; "HAWB Header"."Destination Airport")
            {
            }
            column(FlightCode_HAWBHeader; "HAWB Header"."Flight Code")
            {
            }
            column(DestinationCode_HAWBHeader; "HAWB Header"."Destination Code")
            {
            }
            column(FlightDate_HAWBHeader; "HAWB Header"."Flight Date")
            {
            }
            column(MAWBNo_HAWBHeader; "HAWB Header"."MAWB No.")
            {
            }
            column(Invoiced_HAWBHeader; "HAWB Header".Invoiced)
            {
            }
            column(EuroFormNo_HAWBHeader; "HAWB Header"."Euro Form No.")
            {
            }
            column(CustomerEntryNo_HAWBHeader; "HAWB Header"."Customer Entry No.")
            {
            }
            column(PhytoCertificateNo_HAWBHeader; "HAWB Header"."Phyto Certificate No.")
            {
            }
            column(BookingSheetNo_HAWBHeader; "HAWB Header"."Booking Sheet No.")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            dataitem("HAWB Line"; "HAWB Line")
            {
                DataItemLink = "HAWB No." = FIELD("No.");
                column(HAWBNo_HAWBLine; "HAWB Line"."HAWB No.")
                {
                }
                column(ItemNo_HAWBLine; "HAWB Line"."Item No.")
                {
                }
                column(Description_HAWBLine; "HAWB Line".Description)
                {
                }
                column(GrossWeight_HAWBLine; "HAWB Line"."Gross Weight")
                {
                }
                column(UnitofMeasure_HAWBLine; "HAWB Line"."Unit of Measure")
                {
                }
                column(RateCharge_HAWBLine; "HAWB Line"."Rate/Charge")
                {
                }
                column(ChargeableWeight_HAWBLine; "HAWB Line"."Chargeable Weight")
                {
                }
                column(InvoiceNo_HAWBLine; "HAWB Line"."Invoice No.")
                {
                }
                column(LineAmount_HAWBLine; "HAWB Line"."Line Amount")
                {
                }
                column(Quantity_HAWBLine; "HAWB Line".Quantity)
                {
                }
                column(LineNo_HAWBLine; "HAWB Line"."Line No.")
                {
                }
                column(DivisionFarmCode_HAWBLine; "HAWB Line"."Division/Farm Code")
                {
                }
                column(AirlineCode_HAWBLine; "HAWB Line"."Airline Code")
                {
                }
                column(ConsigneeCode_HAWBLine; "HAWB Line"."Consignee Code")
                {
                }
                column(FlightCode_HAWBLine; "HAWB Line"."Flight Code")
                {
                }
                column(DestinationCode_HAWBLine; "HAWB Line"."Destination Code")
                {
                }
                column(FlightDate_HAWBLine; "HAWB Line"."Flight Date")
                {
                }
                column(UnitofMeasureCode_HAWBLine; "HAWB Line"."Unit of Measure Code")
                {
                }
                column(Type_HAWBLine; "HAWB Line".Type)
                {
                }
                column(ShipperCode_HAWBLine; "HAWB Line"."Shipper Code")
                {
                }
                column(MAWBNo_HAWBLine; "HAWB Line"."MAWB No.")
                {
                }
                column(MAWBPrepared_HAWBLine; "HAWB Line"."MAWB Prepared")
                {
                }
                column(ActualWeight_HAWBLine; "HAWB Line"."Actual Weight")
                {
                }
                column(TotalQuantity_HAWBLine; "HAWB Line"."Total Quantity")
                {
                }
                column(SplitFactor_HAWBLine; "HAWB Line"."Split Factor")
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

    var
        CompanyInfo: Record "Company Information";
}

