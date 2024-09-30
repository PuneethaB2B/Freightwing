report 50121 "Operational Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/OperationalReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000017; Integer)
        {
            MaxIteration = 1;
            column(ShowBookingSheet; gBoolBookingSheet)
            {
            }
            column(ShowgGoodsReciept; gBoolGoodsReceipt)
            {
            }
            column(ShowLoadingSheet; gBoolLoadingSheet)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF gBoolBookingSheet THEN BEGIN
                    gRecBookingSheetHr.RESET;
                    IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                        gRecBookingSheetHr.SETRANGE("Booking Date", gDateStartDate, gDateEndDate);
                    //  gRecBookingSheetHr.SETRANGE(Status,gRecBookingSheetHr.Status::Submitted);
                    IF gRecBookingSheetHr.FINDSET THEN
                        REPEAT
                            gRecBookingSheetLine.RESET;
                            gRecBookingSheetLine.SETRANGE("Booking Sheet No.", gRecBookingSheetHr."No.");
                            IF gRecBookingSheetLine.FINDSET THEN
                                REPEAT
                                    gRecBookingSheetMAWBAlloc.RESET;
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Booking Sheet No", gRecBookingSheetLine."Booking Sheet No.");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Line No.", gRecBookingSheetLine."Line No.");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Item No", gRecBookingSheetLine."Item No.");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Airline Code", gRecBookingSheetLine."Airline Code");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Flight No", gRecBookingSheetLine."Flight Code");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Source Airport", gRecBookingSheetLine."Source Airport");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Destination Airport", gRecBookingSheetLine."Destination Airport");
                                    gRecBookingSheetMAWBAlloc.SETRANGE("Shipper Code", gRecBookingSheetLine."Shipper Code");
                                    IF gCodeMAWBNo <> '' THEN
                                        gRecBookingSheetMAWBAlloc.SETRANGE("MAWB No", gCodeMAWBNo);
                                    IF gRecBookingSheetMAWBAlloc.FINDSET THEN
                                        REPEAT
                                            gRecBookingSheetHAWBAlloc.RESET;
                                            gRecBookingSheetHAWBAlloc.SETRANGE("Booking Sheet No.", gRecBookingSheetMAWBAlloc."Booking Sheet No");
                                            gRecBookingSheetHAWBAlloc.SETRANGE("Airline Code", gRecBookingSheetMAWBAlloc."Airline Code");
                                            gRecBookingSheetHAWBAlloc.SETRANGE("Shipper Code", gRecBookingSheetMAWBAlloc."Shipper Code");
                                            gRecBookingSheetHAWBAlloc.SETRANGE("Source Airport", gRecBookingSheetMAWBAlloc."Source Airport");
                                            gRecBookingSheetHAWBAlloc.SETRANGE("Destination Airport", gRecBookingSheetMAWBAlloc."Destination Airport");
                                            gRecBookingSheetHAWBAlloc.SETRANGE("MAWB No.", gRecBookingSheetMAWBAlloc."MAWB No");
                                            IF gRecBookingSheetHAWBAlloc.FINDSET THEN BEGIN
                                                REPEAT
                                                    gRecBookingSheetULDAlloc.RESET;
                                                    gRecBookingSheetULDAlloc.SETRANGE("Booking Sheet No.", gRecBookingSheetHAWBAlloc."Booking Sheet No.");
                                                    gRecBookingSheetULDAlloc.SETRANGE("Airline Code", gRecBookingSheetHAWBAlloc."Airline Code");
                                                    gRecBookingSheetULDAlloc.SETRANGE("Flight Code", gRecBookingSheetHAWBAlloc."Flight Code");
                                                    gRecBookingSheetULDAlloc.SETRANGE("Shipper Code", gRecBookingSheetHAWBAlloc."Shipper Code");
                                                    gRecBookingSheetULDAlloc.SETRANGE(Consignee, gRecBookingSheetHAWBAlloc."Consignee Code");
                                                    gRecBookingSheetULDAlloc.SETRANGE("Destination Airport", gRecBookingSheetHAWBAlloc."Destination Airport");
                                                    gRecBookingSheetULDAlloc.SETRANGE("Source Airport", gRecBookingSheetHAWBAlloc."Source Airport");
                                                    gRecBookingSheetULDAlloc.SETRANGE("MAVB No.", gRecBookingSheetHAWBAlloc."MAWB No.");
                                                    IF gRecBookingSheetULDAlloc.FINDSET THEN BEGIN
                                                        REPEAT
                                                            gRecBookingOperationalReport.INIT;
                                                            gRecBookingOperationalReport.SNo := gIntSno + 1;
                                                            gRecBookingOperationalReport."Booking Date" := gRecBookingSheetHr."Booking Date";
                                                            gRecBookingOperationalReport."Mawb No" := gRecBookingSheetMAWBAlloc."MAWB No";
                                                            gRecBookingOperationalReport."Shipper Code" := gRecBookingSheetULDAlloc."Shipper Code";
                                                            gRecBookingOperationalReport."HAWB No" := gRecBookingSheetHAWBAlloc."HAWB No.";
                                                            gRecBookingOperationalReport."Booked Weight" := gRecBookingSheetHAWBAlloc."Gross Weight";
                                                            gRecBookingOperationalReport."Flight No" := gRecBookingSheetMAWBAlloc."Flight No";
                                                            gRecBookingOperationalReport."Destination Airport" := gRecBookingSheetHAWBAlloc."Destination Airport";
                                                            gRecBookingOperationalReport."Departure Time" := gRecBookingSheetLine."Departure Time";
                                                            gRecBookingOperationalReport."Cut off Time" := gRecBookingSheetLine."Cut-off Time";
                                                            gRecBookingOperationalReport."ULD Allocation" := gRecBookingSheetULDAlloc."ULD Type Code";
                                                            gRecBookingOperationalReport."Consignee Code" := gRecBookingSheetULDAlloc.Consignee;
                                                            gRecBookingOperationalReport."Type of Delivery" := gRecBookingSheetLine."Type of Delivery";
                                                            gRecBookingOperationalReport.INSERT;
                                                            gIntSno += 1;
                                                        UNTIL gRecBookingSheetULDAlloc.NEXT = 0;
                                                    END ELSE BEGIN
                                                        gRecBookingOperationalReport.INIT;
                                                        gRecBookingOperationalReport.SNo := gIntSno + 1;
                                                        gRecBookingOperationalReport."Booking Date" := gRecBookingSheetHr."Booking Date";
                                                        gRecBookingOperationalReport."Mawb No" := gRecBookingSheetMAWBAlloc."MAWB No";
                                                        gRecBookingOperationalReport."Shipper Code" := gRecBookingSheetMAWBAlloc."Shipper Code";
                                                        gRecBookingOperationalReport."HAWB No" := gRecBookingSheetHAWBAlloc."HAWB No.";
                                                        gRecBookingOperationalReport."Booked Weight" := gRecBookingSheetHAWBAlloc."Gross Weight";
                                                        gRecBookingOperationalReport."Flight No" := gRecBookingSheetMAWBAlloc."Flight No";
                                                        gRecBookingOperationalReport."Destination Airport" := gRecBookingSheetMAWBAlloc."Destination Airport";
                                                        gRecBookingOperationalReport."Departure Time" := gRecBookingSheetLine."Departure Time";
                                                        gRecBookingOperationalReport."Cut off Time" := gRecBookingSheetLine."Cut-off Time";
                                                        gRecBookingOperationalReport."Consignee Code" := gRecBookingSheetMAWBAlloc."Consignee Code";
                                                        gRecBookingOperationalReport."Type of Delivery" := gRecBookingSheetLine."Type of Delivery";
                                                        gRecBookingOperationalReport.INSERT;
                                                        gIntSno += 1;
                                                    END;
                                                UNTIL gRecBookingSheetHAWBAlloc.NEXT = 0;
                                            END ELSE BEGIN
                                                gRecBookingOperationalReport.INIT;
                                                gRecBookingOperationalReport.SNo := gIntSno + 1;
                                                gRecBookingOperationalReport."Booking Date" := gRecBookingSheetHr."Booking Date";
                                                gRecBookingOperationalReport."Mawb No" := gRecBookingSheetMAWBAlloc."MAWB No";
                                                gRecBookingOperationalReport."Shipper Code" := gRecBookingSheetMAWBAlloc."Shipper Code";
                                                gRecBookingOperationalReport."Booked Weight" := gRecBookingSheetLine."Booked Weight";
                                                gRecBookingOperationalReport."Flight No" := gRecBookingSheetMAWBAlloc."Flight No";
                                                gRecBookingOperationalReport."Destination Airport" := gRecBookingSheetMAWBAlloc."Destination Airport";
                                                gRecBookingOperationalReport."Departure Time" := gRecBookingSheetLine."Departure Time";
                                                gRecBookingOperationalReport."Cut off Time" := gRecBookingSheetLine."Cut-off Time";
                                                gRecBookingOperationalReport."Consignee Code" := gRecBookingSheetMAWBAlloc."Consignee Code";
                                                gRecBookingOperationalReport."Type of Delivery" := gRecBookingSheetLine."Type of Delivery";
                                                gRecBookingOperationalReport.INSERT;
                                                gIntSno += 1;
                                            END;
                                        UNTIL gRecBookingSheetMAWBAlloc.NEXT = 0;
                                UNTIL gRecBookingSheetLine.NEXT = 0;
                        UNTIL gRecBookingSheetHr.NEXT = 0;
                END;
            end;
        }
        dataitem("Booking Sheet Opr Report Temp"; "Booking Sheet Opr Report Temp")
        {
            column(BookingDate_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Booking Date")
            {
            }
            column(MawbNo_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Mawb No")
            {
            }
            column(ShipperName_BookingSheetOprReportTemp; gRecShipper."Search Name")
            {
            }
            column(HAWBNo_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."HAWB No")
            {
            }
            column(BookedWeight_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Booked Weight")
            {
            }
            column(FlightNo_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Flight No")
            {
            }
            column(DestinationAirport_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Destination Airport")
            {
            }
            column(DepartureTime_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Departure Time")
            {
            }
            column(CutoffTime_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Cut off Time")
            {
            }
            column(ULDAllocation_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."ULD Allocation")
            {
            }
            column(ConsigneeName_BookingSheetOprReportTemp; gRecConsignee.Name)
            {
            }
            column(TypeofDelivery_BookingSheetOprReportTemp; "Booking Sheet Opr Report Temp"."Type of Delivery")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF gRecConsignee.GET("Booking Sheet Opr Report Temp"."Consignee Code") THEN;
                IF gRecShipper.GET("Booking Sheet Opr Report Temp"."Shipper Code") THEN;
            end;
        }
        dataitem("Good Receipt Header"; "Good Receipt Header")
        {
            dataitem("Good Receipt Line"; "Good Receipt Line")
            {
                DataItemLink = "Good Receipt No." = FIELD("No.");
                column(GoodReceiptNo_GoodReceiptLine; "Good Receipt Line"."Good Receipt No.")
                {
                }
                column(MAWBNo_GoodReceiptLine; "Good Receipt Line"."MAWB No.")
                {
                }
                column(RecieptDate_GoodReceiptLine; gDateReceiptDate)
                {
                }
                column(DeliveryNo_GoodReceiptLine; gCodeDeliveryNo)
                {
                }
                column(DeliveryDate_GoodReceiptLine; gDateDeliveryDate)
                {
                }
                column(SealNo_GoodReceiptLine; gCodeSealNo)
                {
                }
                column(VehicleNo_GoodReceiptLine; gCodeVehicleNo)
                {
                }
                column(VehicleArrivalTime_GoodReceiptLine; gTimeVehicleArrivalTime)
                {
                }
                column(AcceptanceSerialNo_GoodReceiptLine; gCodeSerialNo)
                {
                }
                column(ArrivalTemperature_GoodReceiptLine; "Good Receipt Line"."Arrival Temperature")
                {
                }
                column(Description_GoodReceiptLine; "Good Receipt Line".Description)
                {
                }
                column(DivisionFarmCode_GoodReceiptLine; "Good Receipt Line"."Division/Farm Code")
                {
                }
                column(Quantity_GoodReceiptLine; "Good Receipt Line".Quantity)
                {
                }
                column(ActualWeight_GoodReceiptLine; "Good Receipt Line"."Actual Weight")
                {
                }
                column(Volume_GoodReceiptLine; gDecVolume)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF "gRecGoodReceiptHr.".GET("Good Receipt Line"."Good Receipt No.") THEN BEGIN
                        gDateReceiptDate := "Good Receipt Header"."Receipt Date";
                        gCodeDeliveryNo := "Good Receipt Header"."Delivery No.";
                        gDateDeliveryDate := "Good Receipt Header"."Delivery Date";
                        gCodeSealNo := "Good Receipt Header"."Seal No.";
                        gCodeVehicleNo := "Good Receipt Header"."Vehicle No.";
                        gTimeVehicleArrivalTime := "Good Receipt Header"."Vehicle Arrival Time";
                        gCodeSerialNo := "Good Receipt Header"."External Doc No.";
                        gDecVolume := "Good Receipt Line".Length * "Good Receipt Line".Width * "Good Receipt Line".Height;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF gCodeMAWBNo <> '' THEN
                        "Good Receipt Line".SETRANGE("MAWB No.", gCodeMAWBNo);
                end;
            }

            trigger OnPreDataItem()
            begin
                IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Good Receipt Header".SETRANGE("Receipt Date", gDateStartDate, gDateEndDate);
                IF NOT gBoolGoodsReceipt THEN
                    "Good Receipt Header".SETRANGE("Receipt Date", 0D);
            end;
        }
        dataitem("Loading Sheet Header"; "Loading Sheet Header")
        {
            column(No_LoadingSheetHeader; "Loading Sheet Header"."No.")
            {
            }
            column(LoadingDate_LoadingSheetHeader; "Loading Sheet Header"."Loading Date")
            {
            }
            dataitem("Loading Sheet Line"; "Loading Sheet Line")
            {
                DataItemLink = "Loading Sheet No." = FIELD("No.");
                column(ULDWeight_LoadingSheetLine; gRecLoadingSheetULDAlloc."FWL Docket Weight")
                {
                }
                column(NoofBoxes_LoadingSheetLine; "Loading Sheet Line".Quantity)
                {
                }
                column(ULDTypeCode_LoadingSheetLine; FORMAT(gRecLoadingSheetULDAlloc."ULD Type Code" + '-' + gRecLoadingSheetULDAlloc."ULD No."))
                {
                }
                column(SkidPer_LoadingSheetLine; "Loading Sheet Line"."Skid Per")
                {
                }
                column(ConsigneeName_LoadingSheetLine; gRecConsignee2.Name)
                {
                }
                column(MAWBNo_LoadingSheetLine; "Loading Sheet Line"."MAWB No.")
                {
                }
                column(Dimension_LoadingSheetLine; "Loading Sheet Line".Dimension)
                {
                }
                column(DepartureTemperature_LoadingSheetLine; "Loading Sheet Line"."Departure Temperature")
                {
                }
                column(VolumeWeight_LoadingSheetLine; gDecLoadingSheetVolume)
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
                column(VaccumTemperature_LoadingSheetLine; "Loading Sheet Line"."Vaccum Temperature")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF gRecConsignee2.GET("Loading Sheet Line"."Consignee Code") THEN;

                    //ULD Allocations
                    gRecLoadingSheetULDAlloc.RESET;
                    gRecLoadingSheetULDAlloc.SETRANGE("Loading Sheet No.", "Loading Sheet Line"."Loading Sheet No.");
                    gRecLoadingSheetULDAlloc.SETRANGE("Airline Code", "Loading Sheet Line"."Airline Code");
                    gRecLoadingSheetULDAlloc.SETRANGE("Item No.", "Loading Sheet Line"."Item No.");
                    gRecLoadingSheetULDAlloc.SETRANGE("MWAB No.", "Loading Sheet Line"."MAWB No.");
                    gRecLoadingSheetULDAlloc.SETRANGE(FAM, "Loading Sheet Line"."Division/Farm Code");
                    gRecLoadingSheetULDAlloc.SETRANGE(Consignee, "Loading Sheet Line"."Consignee Code");
                    IF gRecLoadingSheetULDAlloc.FINDFIRST THEN;

                    //Calculate Weight
                    gDecLoadingSheetVolume := "Loading Sheet Line".Length * "Loading Sheet Line".Width * "Loading Sheet Line".Height;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Loading Sheet Header".SETRANGE("Loading Date", gDateStartDate, gDateEndDate);
                IF NOT gBoolLoadingSheet THEN
                    "Loading Sheet Header".SETRANGE("Loading Date", 0D);
                IF gCodeMAWBNo <> '' THEN
                    "Loading Sheet Header".SETRANGE("MAWB No.", gCodeMAWBNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show Booking Sheet"; gBoolBookingSheet)
                {
                    ApplicationArea = All;
                }
                field("Show Goods Receipt"; gBoolGoodsReceipt)
                {
                    ApplicationArea = All;
                }
                field("Show Loading Sheet"; gBoolLoadingSheet)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; gDateStartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; gDateEndDate)
                {
                    ApplicationArea = All;
                }
                field("MAWB No"; gCodeMAWBNo)
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
        gRecBookingOperationalReport.RESET;
        gRecBookingOperationalReport.DELETEALL;
    end;

    var
        gDateStartDate: Date;
        gDateEndDate: Date;
        gCodeMAWBNo: Code[50];
        gBoolBookingSheet: Boolean;
        gBoolGoodsReceipt: Boolean;
        gBoolLoadingSheet: Boolean;
        gRecBookingSheetHr: Record "Booking Sheet Header";
        gRecBookingSheetLine: Record "Booking Sheet Line";
        gRecBookingSheetMAWBAlloc: Record "Booking Sheet MAWB Allocation";
        gRecBookingSheetHAWBAlloc: Record "Booking Sheet HAWB Allocation";
        gRecBookingSheetULDAlloc: Record "Booking Sheet ULD Allocation";
        gRecBookingOperationalReport: Record "Booking Sheet Opr Report Temp";
        gIntSno: Integer;
        gRecShipper: Record Customer;
        gRecConsignee: Record Consignee;
        "gRecGoodReceiptHr.": Record "Good Receipt Header";
        gDateReceiptDate: Date;
        gCodeDeliveryNo: Code[50];
        gDateDeliveryDate: Date;
        gCodeSealNo: Code[20];
        gCodeVehicleNo: Code[100];
        gTimeVehicleArrivalTime: Time;
        gCodeSerialNo: Code[50];
        gDecVolume: Decimal;
        gRecConsignee2: Record Consignee;
        gRecLoadingSheetULDAlloc: Record "Loading Sheet ULD Allocation";
        gDecLoadingSheetVolume: Decimal;
}

