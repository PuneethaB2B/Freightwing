report 50053 "Annual Airline Weight"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AnnualAirlineWeight.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000044; Table50060)
        {
            RequestFilterHeading = 'Airline Filter';
            column(No_LoadingSheetHeader; "Loading Sheet Header"."No.")
            {
            }
            column(LoadingDate_LoadingSheetHeader; "Loading Sheet Header"."Loading Date")
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
            column(Year_; Year)
            {
            }
            column(Monthly_; MonthlyBreakDown)
            {
            }
            dataitem(DataItem1000000000; Table50061)
            {
                DataItemLink = Loading Sheet No.=FIELD(No.);
                DataItemTableView = SORTING(Loading Sheet No., MAWB No., Division/Farm Code, Destination Code, Line No., Consignee Code)
                                    ORDER(Ascending);
                column(AirlineName; Airlines.Name)
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
                column(HippedQuantity_LoadingSheetLine; "Loading Sheet Line"."Hipped Quantity")
                {
                }
                column(GRNNo_LoadingSheetLine; "Loading Sheet Line"."GRN No.")
                {
                }
                column(Dimension_LoadingSheetLine; "Loading Sheet Line".Dimension)
                {
                }
                column(ConsigneeName_LoadingSheetLine; "Loading Sheet Line"."Consignee Name")
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
                column(InStock_LoadingSheetLine; "Loading Sheet Line"."In Stock")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Loading Sheet Line"."Airline Code" <> '' THEN
                        Airlines.GET("Loading Sheet Line"."Airline Code");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                "Loading Sheet Header".SETRANGE("Loading Sheet Header"."Loading Date", From, "To");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Year Filter")
                {
                    field(Year; Year)
                    {
                        ApplicationArea = All;
                    }
                    field(Month; Month)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Detailed/Summary")
                {
                    field("Hide Monthly Breakdown"; MonthlyBreakDown)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            IF Year = 0 THEN
                Year := DATE2DWY(TODAY, 3);
            //ERROR('Please Provide a Year');
            IF Month = Month::"<All>" THEN BEGIN
                From := DMY2DATE(1, 1, Year);
                "To" := DMY2DATE(31, 12, Year);
            END
            ELSE BEGIN
                CASE Month OF
                    Month::Jan:
                        BEGIN
                            From := DMY2DATE(1, 1, Year);
                            "To" := DMY2DATE(31, 1, Year);
                        END;
                    Month::Feb:
                        BEGIN
                            IF Year MOD 4 > 0 THEN BEGIN
                                From := DMY2DATE(1, 2, Year);
                                "To" := DMY2DATE(28, 2, Year);
                            END ELSE BEGIN
                                From := DMY2DATE(1, 2, Year);
                                "To" := DMY2DATE(29, 2, Year);
                            END;
                        END;
                    Month::Mar:
                        BEGIN
                            From := DMY2DATE(1, 3, Year);
                            "To" := DMY2DATE(31, 3, Year);
                        END;
                    Month::Apr:
                        BEGIN
                            From := DMY2DATE(1, 4, Year);
                            "To" := DMY2DATE(30, 4, Year);
                        END;
                    Month::May:
                        BEGIN
                            From := DMY2DATE(1, 5, Year);
                            "To" := DMY2DATE(31, 5, Year);
                        END;
                    Month::Jun:
                        BEGIN
                            From := DMY2DATE(1, 6, Year);
                            "To" := DMY2DATE(30, 6, Year);
                        END;
                    Month::Jul:
                        BEGIN
                            From := DMY2DATE(1, 7, Year);
                            "To" := DMY2DATE(31, 7, Year);
                        END;
                    Month::Aug:
                        BEGIN
                            From := DMY2DATE(1, 8, Year);
                            "To" := DMY2DATE(31, 8, Year);
                        END;
                    Month::Sep:
                        BEGIN
                            From := DMY2DATE(1, 9, Year);
                            "To" := DMY2DATE(30, 9, Year);
                        END;
                    Month::Oct:
                        BEGIN
                            From := DMY2DATE(1, 10, Year);
                            "To" := DMY2DATE(31, 10, Year);
                        END;
                    Month::Nov:
                        BEGIN
                            From := DMY2DATE(1, 11, Year);
                            "To" := DMY2DATE(30, 11, Year);
                        END
                    ELSE BEGIN
                        From := DMY2DATE(1, 12, Year);
                        "To" := DMY2DATE(31, 12, Year);
                    END;
                END;
            END;
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "79";
        Airlines: Record "50021";
        Year: Integer;
        From: Date;
        "To": Date;
        MonthlyBreakDown: Boolean;
        Month: Option "<All>",Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec;
}

