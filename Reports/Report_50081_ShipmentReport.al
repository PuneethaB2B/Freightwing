report 50081 "Shipment Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/ShipmentReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {
            DataItemTableView = WHERE("MAWB No." = FILTER(<> ''));
            dataitem("MAWB Header 2"; "MAWB Header 2")
            {
                DataItemLink = "No." = FIELD("MAWB No.");
                DataItemTableView = SORTING("No.")
                                    ORDER(Ascending);
                column(Filters; Filters)
                {
                }
                column(CompanyLogo; CompanyInfo.Picture)
                {
                }
                column(No_MAWBHeader; "MAWB Header 2"."No.")
                {
                }
                column(ShipperCode_MAWBHeader; "MAWB Header 2"."Shipper Code")
                {
                }
                column(ShipperAddress_MAWBHeader; "MAWB Header 2"."Shipper Address")
                {
                }
                column(ShipperName_MAWBHeader; "MAWB Header 2"."Shipper Name")
                {
                }
                column(ConsigneeCode_MAWBHeader; "MAWB Header 2"."Consignee Code")
                {
                }
                column(ConsigneeName_MAWBHeader; "MAWB Header 2"."Consignee Name")
                {
                }
                column(AgentsIATACode_MAWBHeader; "MAWB Header 2"."Agent's IATA Code")
                {
                }
                column(CarrierAgentCode_MAWBHeader; "MAWB Header 2"."Carrier Agent Code")
                {
                }
                column(SourceAirport_MAWBHeader; "MAWB Header 2"."Source Airport")
                {
                }
                column(AirlineCode_MAWBHeader; "MAWB Header 2"."Airline Code")
                {
                }
                column(DestinationAirport_MAWBHeader; "MAWB Header 2"."Destination Airport")
                {
                }
                column(FlightCode_MAWBHeader; "MAWB Header 2"."Flight Code")
                {
                }
                column(DestinationCode_MAWBHeader; "MAWB Header 2"."Destination Code")
                {
                }
                column(PreparationDate_MAWBHeader; "MAWB Header 2"."Preparation Date")
                {
                }
                column(Consolidated_MAWBHeader; "MAWB Header 2".Consolidated)
                {
                }
                column(AgentCode_MAWBHeader; "MAWB Header 2"."Agent Code")
                {
                }
                column(HasHouses_MAWBHeader2; "MAWB Header 2"."Has Houses")
                {
                }
                column(CustomEntryNo_MAWBHeader2; "MAWB Header 2"."Custom Entry No")
                {
                }
                column(EuroFormNo_MAWBHeader2; "MAWB Header 2"."Euro Form No")
                {
                }
                column(CommercialInvoiceNo_MAWBHeader2; "MAWB Header 2"."Commercial Invoice No")
                {
                }
                column(PhytoCertificate_MAWBHeader2; "MAWB Header 2"."Phyto Certificate")
                {
                }
                dataitem("MAWB Line"; "MAWB Line")
                {
                    DataItemLink = "MAWB No."=FIELD("No.");
                    DataItemTableView = SORTING("MAWB No.", "Line No.")
                                        ORDER(Ascending);
                    column(InvoiceRate; InvRate)
                    {
                    }
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
                    column(InvoiceNo_MAWBLine; InvNo)
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
                    column(CustomEnrtyNo_MAWBLine; "MAWB Line"."Custom Enrty No")
                    {
                    }
                    column(ConsigneeName; Consignee.Name)
                    {
                    }
                    column(ShipperName; Shipper.Name)
                    {
                    }
                    column(AirlineName; Airline.Name)
                    {
                    }
                    column(MasterDataRate; Mrate)
                    {
                    }
                    column(SalesInvoiceRate; SalesInvRate)
                    {
                    }
                    column(Phyto_MAWBLine; "MAWB Line".Phyto)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        InvNo := '';
                        Mrate := 0;
                        InvRate := 0;
                        CLEAR(Consignee);
                        CLEAR(Shipper);
                        IF "MAWB Line"."Item No." <> '' THEN BEGIN
                            "MAWB Line".VALIDATE("Item No.", "MAWB Line"."Item No.");
                            "MAWB Line".MODIFY;
                        END;


                        IF "MAWB Line"."Airline Code" <> '' THEN
                            Airline.GET("MAWB Line"."Airline Code");

                        //Consignee Name
                        //"gRecBookingHAWBAlloc.".RESET;
                        //"gRecBookingHAWBAlloc.".SETRANGE("MAWB No.","MAWB Line"."MAWB No.");
                        //"gRecBookingHAWBAlloc.".SETRANGE("Shipper Code","MAWB Line"."Shipper Code");
                        //"gRecBookingHAWBAlloc.".SETFILTER("Consignee Code",'<>%1','');
                        //IF "gRecBookingHAWBAlloc.".FINDFIRST THEN BEGIN
                        //   Consignee.GET("gRecBookingHAWBAlloc."."Consignee Code");
                        //END;

                        //New Change proposed on APril 18th 2018. Consignee name should be pick from Archive MAWB Lines.
                        IF "MAWB Line"."Consignee Code" <> '' THEN
                            Consignee.GET("MAWB Line"."Consignee Code");

                        //Shipper Name
                        "gRecBookingHAWBAlloc.".RESET;
                        "gRecBookingHAWBAlloc.".SETRANGE("MAWB No.", "MAWB Line"."MAWB No.");
                        IF "gRecBookingHAWBAlloc.".FINDFIRST THEN
                            Shipper.GET("gRecBookingHAWBAlloc."."Shipper Code");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CompanyInfo.CALCFIELDS(Picture);
                    "MAWB Header 2".CALCFIELDS("MAWB Header 2"."Chargeable Weight");
                end;

                trigger OnPreDataItem()
                begin

                    CompanyInfo.GET();
                end;
            }

            trigger OnPreDataItem()
            begin
                Filters := "MAWB Receipt".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
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
        Shipper: Record Customer;
        Consignee: Record Consignee;
        Airline: Record Airline;
        InvNo: Text[50];
        SalesHeader: Record "Sales Header";
        Filters: Text[250];
        Mrate: Decimal;
        InvRate: Decimal;
        "gRecBookingHAWBAlloc.": Record "Booking Sheet HAWB Allocation";
        SalesInvRate: Decimal;
}

