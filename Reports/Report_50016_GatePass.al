report 50016 "Gate Pass"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/GatePass.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gate Pass Header"; "Gate Pass Header")
        {
            RequestFilterFields = "No.";
            column(No_GatePassHeader; "Gate Pass Header"."No.")
            {
            }
            column(GatePassDate_GatePassHeader; "Gate Pass Header"."Gate-Pass Date")
            {
            }
            column(MAWBNo_GatePassHeader; "Gate Pass Header"."MAWB No.")
            {
            }
            column(AirlineCode_GatePassHeader; "Gate Pass Header"."Airline Code")
            {
            }
            column(FlightCode_GatePassHeader; "Gate Pass Header"."Flight Code")
            {
            }
            column(LoadingSheetNo_GatePassHeader; "Gate Pass Header"."Loading Sheet No.")
            {
            }
            column(LoadingSheetDate_GatePassHeader; "Gate Pass Header"."Loading Sheet Date")
            {
            }
            column(ShipperCode_GatePassHeader; "Gate Pass Header"."Shipper Code")
            {
            }
            column(ConsigneeCode_GatePassHeader; "Gate Pass Header"."Consignee Code")
            {
            }
            column(PreparedBy_GatePassHeader; "Gate Pass Header"."Prepared By")
            {
            }
            column(NoSeries_GatePassHeader; "Gate Pass Header"."No. Series")
            {
            }
            column(ShipperName_GatePassHeader; "Gate Pass Header"."Shipper Name")
            {
            }
            column(ConsigneeName_GatePassHeader; "Gate Pass Header"."Consignee Name")
            {
            }
            column(VehicleNo_GatePassHeader; "Gate Pass Header"."Vehicle No.")
            {
            }
            column(DriverName_GatePassHeader; "Gate Pass Header"."Driver Name")
            {
            }
            column(EscortVehicleNo_GatePassHeader; "Gate Pass Header"."Escort Vehicle No.")
            {
            }
            column(SupervisorName_GatePassHeader; "Gate Pass Header"."Supervisor Name")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPicture; CompInfo.Picture)
            {
            }
            column(MAWBNo; "Gate Pass Header"."MAWB No.")
            {
            }
            column(Shade_GatePassHeader; "Gate Pass Header".Shade)
            {
            }
            column(ActualDepartureTime_GatePassHeader; "Gate Pass Header"."Actual Departure Time")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            dataitem("Gate Pass Line"; "Gate Pass Line")
            {
                DataItemLink = "Gate-Pass No."=FIELD("No.");
                column(GatePassNo_GatePassLine; "Gate Pass Line"."Gate-Pass No.")
                {
                }
                column(ItemNo_GatePassLine; "Gate Pass Line"."Item No.")
                {
                }
                column(UnitofMeasureCode_GatePassLine; "Gate Pass Line"."Unit of Measure Code")
                {
                }
                column(Quantity_GatePassLine; "Gate Pass Line".Quantity)
                {
                }
                column(VehicleNo_GatePassLine; "Gate Pass Line"."Vehicle No.")
                {
                }
                column(DriverName_GatePassLine; "Gate Pass Line"."Driver Name")
                {
                }
                column(EscortVehicleNo_GatePassLine; "Gate Pass Line"."Escort Vehicle No.")
                {
                }
                column(SupervisorName_GatePassLine; "Gate Pass Line"."Supervisor Name")
                {
                }
                column(Description_GatePassLine; "Gate Pass Line".Description)
                {
                }
                column(ULDType_GatePassLine; "Gate Pass Line"."ULD Type")
                {
                }
                column(ULDNo_GatePassLine; "Gate Pass Line"."ULD No.")
                {
                }
                column(LineNo_GatePassLine; "Gate Pass Line"."Line No.")
                {
                }
                column(Type_GatePassLine; "Gate Pass Line".Type)
                {
                }
                column(LocationCode_GatePassLine; "Gate Pass Line"."Location Code")
                {
                }
                column(MAWBNo_GatePassLine; "Gate Pass Line"."MAWB No.")
                {
                }
                column(AirlineCode_GatePassLine; "Gate Pass Line"."Airline Code")
                {
                }
                column(FlightCode_GatePassLine; "Gate Pass Line"."Flight Code")
                {
                }
                column(ConsigneeCode_GatePassLine; "Gate Pass Line"."Consignee Code")
                {
                }
                column(ShipperCode_GatePassLine; "Gate Pass Line"."Shipper Code")
                {
                }
                column(LoadingSheetNo_GatePassLine; "Gate Pass Line"."Loading Sheet No.")
                {
                }
                column(HAWBNo_GatePassLine; "Gate Pass Line"."HAWB No")
                {
                }
                column(CustomEntryNo_GatePassLine; "Gate Pass Line"."Custom Entry No")
                {
                }
                column(PhytoCertificate_GatePassLine; "Gate Pass Line"."Phyto Certificate")
                {
                }
                column(NoOfBoxes; NumberOfBoxes)
                {
                }
                column(UldWeight; ULDWeight)
                {
                }
                column(LoadingSheet; "Gate Pass Line"."Loading Sheet No.")
                {
                }
                column(Product; Product)
                {
                }
                column(Shade; Shade)
                {
                }
                dataitem("Offloaded Gatepass Header"; "Offloaded Gatepass Header")
                {
                    DataItemLink = "Gate Pass No"=FIELD("Gate-Pass No.");
                    column(ULDType_OffloadedULDs; "Offloaded Gatepass Header"."ULD Type")
                    {
                    }
                    column(ULDNo_OffloadedULDs; "Offloaded Gatepass Header"."ULD No")
                    {
                    }
                    column(GatePassNo_OffloadedULDs; "Offloaded Gatepass Header"."Gate Pass No")
                    {
                    }
                    column(MAWBNo_OffloadedULDs; "Offloaded Gatepass Header"."MAWB No")
                    {
                    }
                    column(LoadingSheetNo_OffloadedULDs; "Offloaded Gatepass Header"."Loading Sheet No")
                    {
                    }
                    column(No_OffloadedULDs; "Offloaded Gatepass Header".No)
                    {
                    }
                    column(CreatedBy_OffloadedULDs; "Offloaded Gatepass Header"."Created By")
                    {
                    }
                    column(CreatedOn_OffloadedULDs; "Offloaded Gatepass Header"."Created On")
                    {
                    }
                    column(NoOfBoxes_OffloadedULDs; "Offloaded Gatepass Header"."No Of Boxes")
                    {
                    }
                    column(ConsigneeCode_OffloadedULDs; "Offloaded Gatepass Header"."Consignee Code")
                    {
                    }
                    column(ShipperCode_OffloadedULDs; "Offloaded Gatepass Header"."Shipper Code")
                    {
                    }
                    column(ShipperName_OffloadedULDs; "Offloaded Gatepass Header"."Shipper Name")
                    {
                    }
                    column(ConsigneeName_OffloadedULDs; "Offloaded Gatepass Header"."Consignee Name")
                    {
                    }
                    column(Airline_OffloadedULDs; "Offloaded Gatepass Header".Airline)
                    {
                    }
                    column(AirlineShade_OffloadedULDs; "Offloaded Gatepass Header"."Airline Shade")
                    {
                    }
                    column(FWLDocketWeight_OffloadedULDs; "Offloaded Gatepass Header"."FWL Docket Weight")
                    {
                    }
                    column(Processed_OffloadedULDs; "Offloaded Gatepass Header".Processed)
                    {
                    }
                    column(ItemCode_OffloadedULDs; "Offloaded Gatepass Header"."Item Code")
                    {
                    }
                    column(ItemName_OffloadedULDs; "Offloaded Gatepass Header"."Item Name")
                    {
                    }
                    column(DivisionCode_OffloadedULDs; "Offloaded Gatepass Header"."Division Code")
                    {
                    }
                    column(DivisionName_OffloadedULDs; "Offloaded Gatepass Header"."Division Name")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    NumberOfBoxes := 0.0;
                    LoadingUld.RESET;
                    //LoadingUld.SETRANGE(LoadingUld."Loading Sheet No.","Gate Pass Line"."Loading Sheet No.");
                    LoadingUld.SETRANGE(LoadingUld."MWAB No.", "Gate Pass Line"."MAWB No.");
                    LoadingUld.SETRANGE(LoadingUld."ULD No.", "Gate Pass Line"."ULD No.");
                    IF LoadingUld.FINDFIRST THEN BEGIN
                        NumberOfBoxes := LoadingUld."No. Of Boxes";
                        ULDWeight := LoadingUld."FWL Docket Weight";
                        Items.GET(LoadingUld."Item No.");
                        Product := Items.Description;
                        Airlines.GET(LoadingUld."Airline Code");
                        Shade := Airlines.Shade;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PreparedBy := USERID;
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

    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Phyto: Text[50];
        EURO: Text[50];
        COMESA: Text[50];
        EACC: Text[50];
        HAWBHeader: Record "HAWB Header";
        LoadingUld: Record "Loading Sheet ULD Allocation";
        NumberOfBoxes: Decimal;
        ULDWeight: Decimal;
        PreparedBy: Code[50];
        Items: Record Item;
        Product: Text[50];
        Shade: Text[50];
        Airlines: Record Airline;
}

