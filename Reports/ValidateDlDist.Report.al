report 50090 "Validate Dl. Dist"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50043)
        {

            trigger OnAfterGetRecord()
            begin
                Shipped := 0;
                Window.UPDATE(1, "Dl. Weight Dist. By Item"."Day of Week");
                Window.UPDATE(2, "Dl. Weight Dist. By Item"."Distribution Date");
                LoadingSheetHeader.RESET;
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Loading Date", "Dl. Weight Dist. By Item"."Distribution Date");
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Shipper Code", "Dl. Weight Dist. By Item"."Customer No.");
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Airline Code", "Dl. Weight Dist. By Item"."Airline Code");
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Flight Code", "Dl. Weight Dist. By Item"."Flight Code");
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Destination Code", "Dl. Weight Dist. By Item"."Destination Code");
                IF LoadingSheetHeader.FINDSET THEN BEGIN
                    REPEAT
                        Window.UPDATE(3, LoadingSheetHeader."Shipper Name");
                        LoadingSheetLine.RESET;
                        LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", LoadingSheetHeader."No.");
                        LoadingSheetLine.SETRANGE(LoadingSheetLine."Item No.", "Dl. Weight Dist. By Item"."Item No.");
                        //  LoadingSheetLine.SETRANGE(
                        IF LoadingSheetLine.FIND('-') THEN BEGIN
                            Window.UPDATE(4, LoadingSheetLine.Description);
                            REPEAT
                                LoadingSheetLine.CALCFIELDS(LoadingSheetLine."FWL Docket Weight");
                                Shipped += LoadingSheetLine."FWL Docket Weight";
                            UNTIL LoadingSheetLine.NEXT = 0;
                        END;
                    UNTIL LoadingSheetHeader.NEXT = 0;
                END;
                "Dl. Weight Dist. By Item"."Shipped Weight" := Shipped;
                "Dl. Weight Dist. By Item".MODIFY;

                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating \Day #1###\Date #2###\Shipper #3### \Item #4###');
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
        LoadingSheetHeader: Record "50060";
        LoadingSheetLine: Record "50061";
        Window: Dialog;
        Shipped: Decimal;
}

