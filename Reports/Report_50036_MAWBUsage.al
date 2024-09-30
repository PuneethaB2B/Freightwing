report 50036 "MAWB Usage"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAWBUsage.rdlc';
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
                    DataItemLink = "MAWB No." = FIELD("No.");
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


                        Mrate := GetMasterRate("MAWB Line"."MAWB No.", "MAWB Line"."Chargeable Weight");

                        SalesInvRate := GetSalesInvoiceRate;

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


                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."External Document No.", "MAWB Line"."MAWB No.");
                        IF SalesInvoiceHeader.FINDSET THEN BEGIN
                            REPEAT
                                gRecSalesInvoiceLine.RESET;
                                gRecSalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                                gRecSalesInvoiceLine.SETRANGE("HAWB No.", "MAWB Line"."HAWB No.");
                                IF gRecSalesInvoiceLine.FINDFIRST THEN BEGIN
                                    Shipper.GET(SalesInvoiceHeader."Bill-to Customer No.");
                                    InvNo := SalesInvoiceHeader."No.";
                                    InvRate := GetInvoicingRate(InvNo, "MAWB Line"."HAWB No.");
                                END;
                            UNTIL SalesInvoiceHeader.NEXT = 0;
                        END ELSE BEGIN
                            SalesHeader.RESET;
                            SalesHeader.SETRANGE(SalesHeader."External Document No.", "MAWB Line"."MAWB No.");
                            IF SalesHeader.FINDFIRST THEN BEGIN
                                InvNo := SalesHeader."No.";
                            END ELSE BEGIN
                                InvNo := 'Un Invoiced';
                            END;
                        END;
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InvNo: Text[50];
        SalesHeader: Record "Sales Header";
        Filters: Text[250];
        Mrate: Decimal;
        InvRate: Decimal;
        gRecPstdSalesInvHr: Record "Sales Invoice Header";
        BillTo: Record "Sales Invoice Header";
        "gRecBookingHAWBAlloc.": Record "Booking Sheet HAWB Allocation";
        gRecSalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvRate: Decimal;

    local procedure GetMasterRate(MAWB: Code[50]; Weight: Decimal) MasterRate: Decimal
    var
        FreightItemChargeMatrix: Record "Freight Item Charge Matrix";
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
    begin
        FreightItemChargeMatrix.RESET;
        FreightItemChargeMatrix.SETFILTER("Freight Charge Code", '%1|%2', '14', '82');
        FreightItemChargeMatrix.SETRANGE("Item No.", "MAWB Line"."Item No.");
        FreightItemChargeMatrix.SETRANGE("Airline Code", "MAWB Header 2"."Airline Code");
        FreightItemChargeMatrix.SETRANGE("Flight Code", "MAWB Header 2"."Flight Code");
        FreightItemChargeMatrix.SETRANGE("Destination Airport", "MAWB Header 2"."Destination Airport");
        FreightItemChargeMatrix.SETFILTER("From Weight", '<=%1', Weight);
        FreightItemChargeMatrix.SETFILTER("To Weight", '>=%1', Weight);
        FreightItemChargeMatrix.SETFILTER("Effective Start Date", '<=%2', "MAWB Line"."Flight Date");
        FreightItemChargeMatrix.SETFILTER("Effective End Date", '>=%2', "MAWB Line"."Flight Date");
        IF FreightItemChargeMatrix.FINDFIRST THEN
            MasterRate := FreightItemChargeMatrix."Rate Amount";
        EXIT(MasterRate);
    end;

    local procedure GetInvoicingRate(InvNo: Code[50]; HawbNo: Code[50]) InvRates: Decimal
    var
        InvCharg: Record "MAWB Invoice Charge";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        InvCharg1: Record "MAWB Invoice Charge";
    begin
        SalesInvoiceLine.RESET;
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", InvNo);
        SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Freight Charge Code", '%1|%2', '14', '82');
        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."HAWB No.", HawbNo);
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            IF SalesInvoiceLine."Split Weight" <> 0 THEN
                InvRates := ((SalesInvoiceLine."Unit Price") - (SalesInvoiceLine."Margin Amount")) / SalesInvoiceLine."Split Weight";
        END;
        EXIT(InvRates);
    end;

    local procedure GetSalesInvoiceRate(): Decimal
    var
        lRecSalesInvoiceLine: Record "Sales Invoice Line";
        lDecTotalWeight: Decimal;
        lDecTotalAmount: Decimal;
        lDecSalesInvRate: Decimal;
        lCodeHAWBNo: Code[50];
    begin
        lDecTotalWeight := 0;
        lDecTotalAmount := 0;
        lCodeHAWBNo := '';
        lRecSalesInvoiceLine.RESET;
        lRecSalesInvoiceLine.SETCURRENTKEY(lRecSalesInvoiceLine."MAWB No.", lRecSalesInvoiceLine."HAWB No.");
        lRecSalesInvoiceLine.SETRANGE("MAWB No.", "MAWB Line"."MAWB No.");
        //lRecSalesInvoiceLine.SETRANGE("HAWB No.","MAWB Line"."HAWB No.");
        IF lRecSalesInvoiceLine.FINDSET THEN BEGIN
            REPEAT
                IF lRecSalesInvoiceLine."HAWB No." = '' THEN
                    lDecTotalWeight := lRecSalesInvoiceLine."Split Weight"
                ELSE BEGIN
                    IF lCodeHAWBNo <> lRecSalesInvoiceLine."HAWB No." THEN
                        lDecTotalWeight += lRecSalesInvoiceLine."Split Weight";
                END;
                lDecTotalAmount += lRecSalesInvoiceLine."Amount Including VAT";
                lCodeHAWBNo := lRecSalesInvoiceLine."HAWB No.";
            UNTIL lRecSalesInvoiceLine.NEXT = 0;
            IF lDecTotalWeight <> 0 THEN
                lDecSalesInvRate := lDecTotalAmount / lDecTotalWeight;
        END;
        EXIT(lDecSalesInvRate);
    end;
}

