report 50108 "Validate Dim Correction"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table81)
        {

            trigger OnAfterGetRecord()
            begin
                SalesInvoiceHeader.GET("Gen. Journal Line"."Document No.");
                Window.UPDATE(1, "Gen. Journal Line"."Document No.");
                Window.UPDATE(2, SalesInvoiceHeader."Sell-to Customer No.");
                LoadingSheet.RESET;
                LoadingSheet.SETRANGE(LoadingSheet."MAWB No.", SalesInvoiceHeader."External Document No.");
                LoadingSheet.SETRANGE(LoadingSheet."Shipper Code", SalesInvoiceHeader."Sell-to Customer No.");
                IF LoadingSheet.FINDFIRST THEN BEGIN
                    IF LoadingSheet."Airline Code" = '' THEN BEGIN
                        LSLine.RESET;
                        LSLine.SETRANGE(LSLine."Loading Sheet No.", LoadingSheet."No.");
                        IF LSLine.FINDFIRST THEN BEGIN
                            DimVal.GET('AIRLINES', LSLine."Airline Code");
                            TempDimensionSetEntry.INIT;
                            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Code", DimVal."Dimension Code");
                            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Value Code", DimVal.Code);
                            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                            TempDimensionSetEntry.INSERT;
                        END;
                    END ELSE BEGIN
                        DimVal.GET('AIRLINES', LoadingSheet."Airline Code");
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Code", DimVal."Dimension Code");
                        TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Value Code", DimVal.Code);
                        TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimensionSetEntry.INSERT;
                    END;
                    Cust.GET(SalesInvoiceHeader."Sell-to Customer No.");
                    DimVal.GET('CUSTOMERGROUP', Cust."Customer Type");
                    TempDimensionSetEntry.INIT;
                    TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
                    TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
                    TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                    TempDimensionSetEntry.INSERT;

                    LSLine.RESET;
                    LSLine.SETRANGE(LSLine."Loading Sheet No.", LoadingSheet."No.");
                    IF LSLine.FINDFIRST THEN BEGIN
                        Items.GET(LSLine."Item No.");
                        DimVal.GET('PRODUCTGROUP', Items."Item Category Code");
                        TempDimensionSetEntry.INIT;
                        TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
                        TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
                        TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                        TempDimensionSetEntry.INSERT;
                    END;

                    "Gen. Journal Line"."Dimension Set ID" := DimMng.GetDimensionSetID(TempDimensionSetEntry);
                    DimMng.UpdateGlobalDimFromDimSetID("Gen. Journal Line"."Dimension Set ID", "Gen. Journal Line"."Shortcut Dimension 1 Code", "Gen. Journal Line"."Shortcut Dimension 2 Code");
                    "Gen. Journal Line".MODIFY;
                END;
                TempDimensionSetEntry.DELETEALL;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Gen. Journal Line"."Journal Batch Name", 'VAT');
                Window.OPEN('Validating Dimensions \Invoice No. #1## \Customer #2###');
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
        Window: Dialog;
        SalesHeader: Record "112";
        LoadingSheet: Record "50060";
        LSLine: Record "50061";
        DimVal: Record "349";
        TempDimensionSetEntry: Record "480" temporary;
        DimMng: Codeunit "408";
        MAWBAlloc: Record "50070";
        LoadingSheetLine: Record "50061";
        Cust: Record "18";
        Items: Record "27";
        Table11: Record "112";
        SalesInvoiceHeader: Record "112";
}

