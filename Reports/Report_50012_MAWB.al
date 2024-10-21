report 50012 MAWB
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/MAWB.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("HAWB Header"; "HAWB Header")
        {
            RequestFilterFields = "No.", "Airline Code";
            column(No_MAWBHeader; "HAWB Header"."No.")
            {
            }
            column(ShipperCode_MAWBHeader; "HAWB Header"."Shipper Code")
            {
            }
            column(ShipperAddress_MAWBHeader; "HAWB Header"."Shipper Address")
            {
            }
            column(ShipperName_MAWBHeader; "HAWB Header"."Shipper Name")
            {
            }
            column(ConsigneeCode_MAWBHeader; "HAWB Header"."Consignee Code")
            {
            }
            column(ConsigneeName_MAWBHeader; "HAWB Header"."Consignee Name")
            {
            }
            column(AgentsIATACode_MAWBHeader; "HAWB Header"."Agent's IATA Code")
            {
            }
            column(CarrierAgentCode_MAWBHeader; "HAWB Header"."Carrier Agent Code")
            {
            }
            column(SourceAirport_MAWBHeader; "HAWB Header"."Source Airport")
            {
            }
            column(AirlineCode_MAWBHeader; "HAWB Header"."Airline Code")
            {
            }
            column(DestinationAirport_MAWBHeader; "HAWB Header"."Destination Airport")
            {
            }
            column(FlightCode_MAWBHeader; "HAWB Header"."Destination Code")
            {
            }
            column(DestinationCode_MAWBHeader; "HAWB Header"."Flight Date")
            {
            }
            column(PreparationDate_MAWBHeader; "HAWB Header"."MAWB No.")
            {
            }
            column(Consolidated_MAWBHeader; "HAWB Header".Invoiced)
            {
            }
            column(AgentCode_MAWBHeader; "HAWB Header"."Euro Form No.")
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
            dataitem("MAWB Line"; "MAWB Line")
            {
                DataItemLink = "MAWB No." = FIELD("No.");
                column(MAWBNo_MAWBLine; "MAWB Line"."MAWB No.")
                {
                }
                column(ItemNo_MAWBLine; "MAWB Line"."Item No.")
                {
                }
                column(Description_MAWBLine; "MAWB Line".Description)
                {
                }
                column(SplitWeight_MAWBLine; "MAWB Line"."Split Weight")
                {
                }
                column(UnitofMeasure_MAWBLine; "MAWB Line"."Unit of Measure")
                {
                }
                column(RateCharge_MAWBLine; "MAWB Line"."Rate/Charge")
                {
                }
                column(ChargeableWeight_MAWBLine; "MAWB Line"."Chargeable Weight")
                {
                }
                column(HAWBNo_MAWBLine; "MAWB Line"."HAWB No.")
                {
                }
                column(LineAmount_MAWBLine; "MAWB Line"."Line Amount")
                {
                }
                column(Quantity_MAWBLine; "MAWB Line".Quantity)
                {
                }
                column(LineNo_MAWBLine; "MAWB Line"."Line No.")
                {
                }
                column(DivisionCode_MAWBLine; "MAWB Line"."Division Code")
                {
                }
                column(GrossWeight_MAWBLine; "MAWB Line"."Gross Weight")
                {
                }
                column(AirlineCode_MAWBLine; "MAWB Line"."Airline Code")
                {
                }
                column(ConsigneeCode_MAWBLine; "MAWB Line"."Consignee Code")
                {
                }
                column(FlightCode_MAWBLine; "MAWB Line"."Flight Code")
                {
                }
                column(DestinationCode_MAWBLine; "MAWB Line"."Destination Code")
                {
                }
                column(FlightDate_MAWBLine; "MAWB Line"."Flight Date")
                {
                }
                column(UnitofMeasureCode_MAWBLine; "MAWB Line"."Unit of Measure Code")
                {
                }
                column(Type_MAWBLine; "MAWB Line".Type)
                {
                }
                column(ShipperCode_MAWBLine; "MAWB Line"."Shipper Code")
                {
                }
                column(InvoiceNo_MAWBLine; "MAWB Line"."Invoice No.")
                {
                }
                column(DivisionFarmCode_MAWBLine; "MAWB Line"."Division/Farm Code")
                {
                }
                column(SplitFactor_MAWBLine; "MAWB Line"."Split Factor")
                {
                }
                column(LocationCode_MAWBLine; "MAWB Line"."Location Code")
                {
                }
            }
            dataitem("HAWB Header2"; "HAWB Header")
            {
                DataItemLink = "MAWB No." = FIELD("No.");
                column(No_HAWBHeader; "HAWB Header2"."No.")
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

