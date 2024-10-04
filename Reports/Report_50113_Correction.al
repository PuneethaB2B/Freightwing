report 50113 Correction
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        IncomingDocumentApprover: Record "Incoming Document Approver";
        Window: Dialog;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        PurchInvLine: Record "Purch. Inv. Line";
        Cust: Record Customer;
        Items: Record Item;
        DimMng: Codeunit DimensionManagement;

    local procedure SteDim(MAWBNo: Code[50]) i: Integer
    var
        TemDimSetEntry: Record "Dimension Set Entry" temporary;
        mawballoc: Record "Booking Sheet MAWB Allocation";
        DimVal: Record "Dimension Value";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
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

