codeunit 50028 "Invoicing Set Dimensions"
{

    trigger OnRun()
    begin
    end;

    var
        DimVal: Record "349";
        TempDimensionSetEntry: Record "480" temporary;
        DimMng: Codeunit "408";
        MAWBAlloc: Record "50070";
        LoadingSheetLine: Record "50061";
        Cust: Record "18";
        Items: Record "27";
        SalesHeader: Record "36";
        SalesLine: Record "37";
        PurchaseHeader: Record "38";
        Ok: Boolean;

    [Scope('Internal')]
    procedure SetDimensions(MAWBNo: Code[50]; ShipperCode: Code[50])
    var
        LoadingSheet: Record "50060";
        LSLine: Record "50061";
        LSLine1: Record "50061";
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

    [Scope('Internal')]
    procedure SetDimensionsPurch(MAWBNo: Code[50]; PurchLine: Record "39")
    var
        ls: Record "50060";
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

