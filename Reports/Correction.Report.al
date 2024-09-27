report 50113 Correction
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table81)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Gen. Journal Line"."Document No.");
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", "Gen. Journal Line"."Document No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                    IF SalesInvoiceLine.FINDFIRST THEN BEGIN

                        "Gen. Journal Line"."Dimension Set ID" := SalesInvoiceLine."Dimension Set ID";
                    END;
                END ELSE BEGIN
                    PurchInvHeader.RESET;
                    PurchInvHeader.SETRANGE(PurchInvHeader."No.", "Gen. Journal Line"."Document No.");
                    IF PurchInvHeader.FINDFIRST THEN BEGIN
                        PurchInvLine.RESET;
                        PurchInvLine.SETRANGE(PurchInvLine."Document No.", PurchInvHeader."No.");
                        IF PurchInvLine.FINDFIRST THEN BEGIN
                            "Gen. Journal Line"."Dimension Set ID" := PurchInvLine."Dimension Set ID";
                        END;
                    END ELSE BEGIN
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETRANGE(SalesCrMemoHeader."No.", "Gen. Journal Line"."Document No.");
                        IF SalesCrMemoHeader.FINDFIRST THEN BEGIN
                            "Gen. Journal Line"."Dimension Set ID" := SteDim(SalesCrMemoHeader."External Document No.");
                            IF SalesInvoiceHeader.GET(SalesCrMemoHeader."Applies-to Doc. No.") THEN BEGIN
                                SalesInvoiceLine.RESET;
                                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                                IF SalesInvoiceLine.FINDFIRST THEN BEGIN

                                END;
                            END;
                        END ELSE BEGIN
                            PurchCrMemoHdr.RESET;
                            PurchCrMemoHdr.SETRANGE(PurchCrMemoHdr."No.", "Gen. Journal Line"."Document No.");
                            IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                                //      "Gen. Journal Line"."Dimension Set ID":=SteDim();
                                IF PurchInvHeader.GET(PurchCrMemoHdr."Applies-to Doc. No.") THEN BEGIN
                                    PurchInvLine.RESET;
                                    PurchInvLine.SETRANGE(PurchInvLine."Document No.", PurchInvHeader."No.");
                                    IF PurchInvLine.FINDFIRST THEN BEGIN

                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
                //"Gen. Journal Line".ShowDimensions;
                "Gen. Journal Line".MODIFY;
                SLEEP(10);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                MESSAGE('Úpdated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Generating Dimensions \Doc No #1#####');
                "Gen. Journal Line".SETFILTER("Gen. Journal Line"."Journal Batch Name", '%1|%2', 'NEW', 'NEW1');
                "Gen. Journal Line".SETFILTER("Gen. Journal Line"."Dimension Set ID", '=%1', 0);
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
        SalesInvoiceHeader: Record "112";
        PurchInvHeader: Record "122";
        IncomingDocumentApprover: Record "132";
        Window: Dialog;
        SalesCrMemoHeader: Record "114";
        SalesCrMemoLine: Record "115";
        PurchCrMemoHdr: Record "124";
        PurchCrMemoLine: Record "125";
        SalesInvoiceLine: Record "113";
        PurchInvLine: Record "123";
        Cust: Record "18";
        Items: Record "27";
        DimMng: Codeunit "408";

    local procedure SteDim(MAWBNo: Code[50]) i: Integer
    var
        TemDimSetEntry: Record "480" temporary;
        mawballoc: Record "50070";
        DimVal: Record "349";
        TempDimensionSetEntry: Record "480" temporary;
    begin
        mawballoc.RESET;
        mawballoc.SETRANGE(mawballoc."MAWB No", MAWBNo);
        IF mawballoc.FINDFIRST THEN BEGIN
            //++++Get Airlines Dimension
            DimVal.GET('AIRLINES', mawballoc."Airline Code");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;
            //+++++Get Product Group Dimension
            Items.GET(mawballoc."Item No");
            DimVal.GET('PRODUCTGROUP', Items."Item Category Code");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;

            //+++++Get Customer Dimension
            Cust.GET(mawballoc."Shipper Code");
            DimVal.GET('CUSTOMERGROUP', Cust."Customer Type");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;
        END ELSE BEGIN
            MESSAGE('MAWB Not found');
        END;
        ;

        EXIT(DimMng.GetDimensionSetID(TempDimensionSetEntry));
        TempDimensionSetEntry.DELETEALL;
    end;
}

