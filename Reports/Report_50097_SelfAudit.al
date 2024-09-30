report 50097 "Self Audit"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Booking Sheet MAWB Allocation"; "Booking Sheet MAWB Allocation")
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Booking Sheet MAWB Allocation"."MAWB No");
                GoodReceiptLine.RESET;
                GoodReceiptLine.SETRANGE(GoodReceiptLine."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF GoodReceiptLine.FINDSET THEN BEGIN
                    REPEAT
                        GoodReceiptLine."Flight Code" := "Booking Sheet MAWB Allocation"."Flight No";
                        GoodReceiptLine."Source Airport" := "Booking Sheet MAWB Allocation"."Source Airport";
                        GoodReceiptLine."Destination Airport" := "Booking Sheet MAWB Allocation"."Destination Airport";
                        GoodReceiptLine.MODIFY;
                    UNTIL GoodReceiptLine.NEXT = 0;
                END;

                LoadingSheetHeader.RESET;
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF LoadingSheetHeader.FINDFIRST THEN BEGIN
                    LoadingSheetHeader."Airline Code" := "Booking Sheet MAWB Allocation"."Airline Code";
                    LoadingSheetHeader."Flight Code" := "Booking Sheet MAWB Allocation"."Flight No";
                    IF Booking.GET("Booking Sheet MAWB Allocation"."Booking Sheet No") THEN BEGIN
                        LoadingSheetHeader."Loading Date" := Booking."Booking Date";
                    END;
                    LoadingSheetHeader.MODIFY;
                END;
                LoadingSheetLine.RESET;
                LoadingSheetLine.SETRANGE(LoadingSheetLine."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF LoadingSheetLine.FINDSET THEN BEGIN
                    REPEAT
                        LoadingSheetLine."Flight Code" := "Booking Sheet MAWB Allocation"."Flight No";
                        LoadingSheetLine."Airline Code" := "Booking Sheet MAWB Allocation"."Airline Code";
                        LoadingSheetLine.VALIDATE(LoadingSheetLine."Item No.", "Booking Sheet MAWB Allocation"."Item No");
                        LoadingSheetLine.MODIFY;

                    UNTIL LoadingSheetLine.NEXT = 0;
                END;
                ImportExportSetup.GET;
                MAWBHeader.RESET;
                MAWBHeader.SETRANGE(MAWBHeader."No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF MAWBHeader.FINDFIRST THEN BEGIN
                    MAWBHeader."Airline Code" := "Booking Sheet MAWB Allocation"."Airline Code";
                    MAWBHeader."Flight Code" := "Booking Sheet MAWB Allocation"."Flight No";
                    MAWBHeader."Destination Airport" := "Booking Sheet MAWB Allocation"."Destination Airport";
                    MAWBHeader."Source Airport" := "Booking Sheet MAWB Allocation"."Source Airport";
                    MAWBHeader.VALIDATE(MAWBHeader."Shipper Code");
                    Airport.RESET;
                    Airport.SETRANGE(Airport.Code, "Booking Sheet MAWB Allocation"."Destination Airport");
                    IF Airport.FINDFIRST THEN BEGIN
                        MAWBHeader."Destination Code" := Airport."Country Code";
                    END;
                    MAWBHeader."Agent's IATA Code" := ImportExportSetup."Agent's IATA Code";
                    MAWBHeader."Agent Code" := ImportExportSetup."Carrier Agent Code";
                    MAWBHeader.MODIFY;
                END;
                IF Booking.GET("Booking Sheet MAWB Allocation"."Booking Sheet No") THEN BEGIN END;
                MAWBLine.RESET;
                MAWBLine.SETRANGE(MAWBLine."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF MAWBLine.FINDSET THEN BEGIN
                    REPEAT
                        MAWBLine."Destination Code" := Booking."Destination Code";
                        MAWBLine."Destination Airport" := "Booking Sheet MAWB Allocation"."Destination Airport";
                        IF Customer.GET("Booking Sheet MAWB Allocation"."Shipper Code") THEN BEGIN
                            MAWBLine."Shipper Name" := Customer.Name;
                        END;
                    UNTIL MAWBLine.NEXT = 0;
                    MAWBLine.MODIFY;
                END;
                HAWBHeader.RESET;
                HAWBHeader.SETRANGE(HAWBHeader."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF HAWBHeader.FINDSET THEN BEGIN
                    REPEAT
                        HAWBHeader."Destination Airport" := "Booking Sheet MAWB Allocation"."Destination Airport";
                        HAWBHeader."Source Airport" := "Booking Sheet MAWB Allocation"."Destination Airport";
                        HAWBHeader."Airline Code" := "Booking Sheet MAWB Allocation"."Airline Code";
                        HAWBHeader.MODIFY;
                    UNTIL HAWBHeader.NEXT = 0;
                END;
                HAWBLine.RESET;
                HAWBLine.SETRANGE(HAWBLine."MAWB No.", "Booking Sheet MAWB Allocation"."MAWB No");
                IF HAWBLine.FINDSET THEN BEGIN
                    REPEAT
                        HAWBLine.VALIDATE(HAWBLine."Item No.", "Booking Sheet MAWB Allocation"."Item No");
                        HAWBLine.MODIFY;
                    UNTIL HAWBLine.NEXT = 0;
                END;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Checking \MAWB #1###');
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
        LoadingSheetHeader: Record 50060;
        LoadingSheetLine: Record 50061;
        MAWBHeader: Record 50077;
        MAWBLine: Record 50076;
        Window: Dialog;
        GoodReceiptHeader: Record 50052;
        GoodReceiptLine: Record 50051;
        ImportExportSetup: Record 50010;
        HAWBHeader: Record 50075;
        HAWBLine: Record 50074;
        Booking: Record 50053;
        Customer: Record 18;
        Airport: Record 50019;
}

