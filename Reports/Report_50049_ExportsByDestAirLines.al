report 50049 "Exports By Dest. AirLines"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/ExportsByDestAirLines.rdl';
    ApplicationArea = All;
    UsageCategory=ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = WHERE("Bill-to Name" = FILTER(<> ''),
                                      "MAWB No." = FILTER(<> ''));
            RequestFilterFields = "Airline Code";
            column(Company_Address; gRecCompanyInfo.Address)
            {
            }
            column(Company_City; gRecCompanyInfo.City)
            {
            }
            column(Company_Postcode; gRecCompanyInfo."Post Code")
            {
            }
            column(Company_Picture; gRecCompanyInfo.Picture)
            {
            }
            column(BillToName; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(IncludeDetailed; gBoolInludeDetailed)
            {
            }
            dataitem("MAWB Header 2"; "MAWB Header 2")
            {
                CalcFields = "Total Quantity";
                DataItemLink = "No." = FIELD("MAWB No.");
                column(Destination_Ariport; "MAWB Header 2"."Destination Airport")
                {
                }
                column(Item_Name; "MAWB Header 2"."Item Description")
                {
                }
                column(Total_Weight; "MAWB Header 2"."Total Weight")
                {
                }
                column(Total_Quantity; "MAWB Header 2"."Total Quantity")
                {
                }
                column(MAWBNo; "MAWB Header 2"."No.")
                {
                }
                column(AirlineCode; "MAWB Header 2"."Airline Code")
                {
                }
                column(AirLineName; gRecAirLine.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF gRecAirLine.GET("MAWB Header 2"."Airline Code") THEN;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Include Detailed"; gBoolInludeDetailed)
                {
                    ApplicationArea = All;
                }
            }
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
        gRecCompanyInfo.GET;
        gRecCompanyInfo.CALCFIELDS(gRecCompanyInfo.Picture);
    end;

    var
        gRecCompanyInfo: Record "Company Information";
        gBoolInludeDetailed: Boolean;
        gRecAirLine: Record Airline;
}

