codeunit 50028 "Invoicing Set Dimensions"
{

    trigger OnRun()
    begin
    end;

    var
        DimVal: Record "Dimension Value";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimMng: Codeunit DimensionManagement;
        MAWBAlloc: Record "Booking Sheet MAWB Allocation";
        LoadingSheetLine: Record "Loading Sheet Line";
        Cust: Record Customer;
        Items: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        PurchaseHeader: Record "Purchase Header";
        Ok: Boolean;


    procedure SetDimensions(MAWBNo: Code[50]; ShipperCode: Code[50])
    var
        LoadingSheet: Record "Loading Sheet Header";
        LSLine: Record "Loading Sheet Line";
        LSLine1: Record "Loading Sheet Line";
    begin
        MAWBAlloc.RESET;
        MAWBAlloc.SETRANGE(MAWBAlloc."MAWB No", MAWBNo);
        IF MAWBAlloc.FINDFIRST THEN BEGIN
            //++++Get Airlines Dimension
            Ok := DimVal.GET('AIRLINES', MAWBAlloc."Airline Code");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;
            //+++++Get Product Group Dimension
            Items.GET(MAWBAlloc."Item No");
            Ok := DimVal.GET('PRODUCTGROUP', Items."Item Category Code");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;
        END;
        //+++++Get Customer Dimension
        Ok := Cust.GET(ShipperCode);
        DimVal.GET('CUSTOMERGROUP', Cust."Customer Type");
        TempDimensionSetEntry.INIT;
        TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
        TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
        TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
        TempDimensionSetEntry.INSERT;

        //+++++Get Sales header
        SalesHeader.RESET;
        SalesHeader.SETRANGE(SalesHeader."MAWB No.", MAWBNo);
        SalesHeader.SETRANGE(SalesHeader."Sell-to Customer No.", ShipperCode);
        IF SalesHeader.FINDFIRST THEN BEGIN
            SalesLine.RESET;
            SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
            IF SalesLine.FINDSET THEN BEGIN
                REPEAT
                    SalesLine."Dimension Set ID" := DimMng.GetDimensionSetID(TempDimensionSetEntry);
                    DimMng.UpdateGlobalDimFromDimSetID(SalesLine."Dimension Set ID", SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code");
                    SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
            END ELSE BEGIN
                MESSAGE('The MAWB Has an Existing Invoice No. %1. Please Delete It and Re Do the Action', SalesHeader."No.");
            END;
        END;
        TempDimensionSetEntry.DELETEALL;
    end;


    procedure SetDimensionsPurch(MAWBNo: Code[50]; PurchLine: Record "Purchase Line")
    var
        ls: Record "Loading Sheet Header";
    begin
        MAWBAlloc.RESET;
        MAWBAlloc.SETRANGE(MAWBAlloc."MAWB No", MAWBNo);
        IF MAWBAlloc.FINDFIRST THEN BEGIN
            //+++++Get Customer Group Dimension
            Ok := Cust.GET(MAWBAlloc."Shipper Code");
            IF Ok THEN BEGIN
                Ok := DimVal.GET('CUSTOMERGROUP', Cust."Customer Type");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
                TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
                TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                TempDimensionSetEntry.INSERT;
            END;
            //+++++

            //+++++Get Product Group Dimension
            Ok := Items.GET(MAWBAlloc."Item No");
            IF Ok THEN BEGIN
                DimVal.GET('PRODUCTGROUP', Items."Item Category Code");
                TempDimensionSetEntry.INIT;
                TempDimensionSetEntry.VALIDATE("Dimension Code", DimVal."Dimension Code");
                TempDimensionSetEntry.VALIDATE("Dimension Value Code", DimVal.Code);
                TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                TempDimensionSetEntry.INSERT;
            END;
            //+++++

            //+++++Get Airline Dimension
            Ok := DimVal.GET('AIRLINES', MAWBAlloc."Airline Code");
            TempDimensionSetEntry.INIT;
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Code", DimVal."Dimension Code");
            TempDimensionSetEntry.VALIDATE(TempDimensionSetEntry."Dimension Value Code", DimVal.Code);
            TempDimensionSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
            TempDimensionSetEntry.INSERT;
            //+++++

        END ELSE BEGIN
            MESSAGE('The MAWB %1 has not been assigned to a Booking Sheet', MAWBNo);
        END;
        PurchLine."Dimension Set ID" := DimMng.GetDimensionSetID(TempDimensionSetEntry);
        DimMng.UpdateGlobalDimFromDimSetID(PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
        PurchLine.MODIFY;
        TempDimensionSetEntry.DELETEALL;
    end;
}

