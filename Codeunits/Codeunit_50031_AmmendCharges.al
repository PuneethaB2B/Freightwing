codeunit 50031 "Ammend Charges"
{

    trigger OnRun()
    begin
    end;

    var
        TotalWt1: Decimal;
        ExchangeRates: Record "Currency Exchange Rate";
        ExchangeRates1: Record "Currency Exchange Rate";
        Tot: Decimal;
        ChargeBle: Decimal;
        ExportSetup: Record "Import/Export Setup";
        LoadingSheetHeader: Record "Loading Sheet Header";
        HasHouses: Boolean;
        LineNo: Integer;
        MAWBs: Record "MAWB Header 2";
        BookingSheetMAWBAlloc: Record "Booking Sheet MAWB Allocation";
        MAWBLine4: Record "MAWB Line";
        MAWBInCharges1: Record "MAWB Invoice Charge";
        MAWBLine2: Record "MAWB Line";
        BookingSheetLine: Record "Booking Sheet Line";
        MAWBLine: Record "MAWB Line";
        BookingSheetLine2: Record "Booking Sheet Line";
        ShipperCount: Integer;
        Shipper: Record Customer;
        BookingSheetHAWBAllocation: Record "Booking Sheet HAWB Allocation";
        Consignee: Record Consignee;
        HAWBLine: Record "HAWB Line";
        HAWBLine2: Record "HAWB Line";
        TotalQuantity: Decimal;
        SplitFactor: Decimal;
        MAWBReceipt: Record "MAWB Receipt";
        MAWBHeader: Record "MAWB Header 2";
        FreightChargeByAirline: Record "Freight Charge By Airline";
        FreightChargeByFlight: Record "Freight Charge By Flight";
        FreightChargeByItem: Record "Freight Charge By Item";
        FreightItemCharge: Record "Freight Item Charge";
        FreightItemChargeMatrix: Record "Freight Item Charge Matrix";
        FreightItemChargeMatrix1: Record "Freight Item Charge Matrix";
        MAWBInvoiceCharge: Record "MAWB Invoice Charge";
        CostAmount: Decimal;
        SalesAmount: Decimal;
        VATAmount: Decimal;
        MarginAmount: Decimal;
        SplitCostAmount: Decimal;
        SplitSalesAmountExVAT: Decimal;
        SplitVATAmount: Decimal;
        SplitMarginAmount: Decimal;
        SplitSalesAmountIncVAT: Decimal;
        MAWBInvoiceNotifyParty: Record "MAWB Invoice Notify Party";
        NotifyParty: Record "Notify Party";
        GenJnlLine: Record "Gen. Journal Line";
        VATPostingSetup: Record "VAT Posting Setup";
        Currency: Record Currency;
        TotalWeight: Decimal;
        MAWBLineCharge: Record "MAWB Line Charge";
        UnrecoveredCharge: Record "Unrecovered Charge";
        TotalAmount: Decimal;
        PreviousT0weight: Decimal;
        PreviousT0weight2: Decimal;
        FreightCharge: Record "Freight Charge";
        VATPostingSetup2: Record "VAT Posting Setup";
        ImportExportSetup: Record "Import/Export Setup";
        GeneralLedgerSetup: Record "General Ledger Setup";
        MAWBReceipt2: Record "MAWB Receipt";
        MAWBReceiptdate: Date;
        InvoiceCurrency: Code[10];
        ImpExpSetup: Record "Import/Export Setup";
        BookingSheetMawbAllocation: Record "Booking Sheet MAWB Allocation";
        LoadingSheetLine: Record "Loading Sheet Line";
        MAWB: Record "MAWB Header 2";
        Text50000: Label '-VAT';
        Text50001: Label '%1 %2 does not have any lines';
        Text50002: Label 'Do you want to calculate total charges for %1 %2?';
        Text50003: Label 'Do you want to split %1 %2?';
        Text50004: Label 'The booking date is not within the allowed flight charge effective dates';
        OffloadLine: Record "Offloaded Gatepass Line";
        Text001: Label 'The Booking Sheet Line %1 From %2 To %3 Does Not Exist';
        Text002: Label 'The Charges for Airline %1 Have not been Setup';
        Text003: Label 'The Charges for Flight %1 for %2 on  Route %3 - %4 Have not been setup';
        Text004: Label 'The Charges for %1 on Flight %2 route %3 - %4 Have not been set up';
        Item: Record Item;
        Text005: Label 'The Freight Charges for Airline %1 have not been set up';
        WorkingWeight: Decimal;
        Ok: Boolean;
        BookingSheetHeader: Record "Booking Sheet Header";


    procedure AmmendCharges("mawb no": Code[50]; Weight: Decimal)
    begin
    end;


    procedure CalculateMAWBCharges("No.": Code[50])
    var
        BookingSheetLine: Record "Booking Sheet Line";
        Customer: Record Customer;
        FreightCharge: Record "Freight Charge";
        HandlingSlab: Record "Handling Slab Matrix";
        TotalSales: Decimal;
        Items: Record Item;
        FreightCost: Decimal;
        FreightCharge3: Record "Freight Charge";
        MAWBInvoiceCharge3: Record "MAWB Invoice Charge";
        Text002: Label 'Freight charge  has already been calculated';
    begin
        ClearCalculatedCharges("No.");
        MAWBLine4.RESET;
        MAWBLine4.SETRANGE(MAWBLine4."MAWB No.", "No.");
        IF MAWBLine4.FINDSET THEN BEGIN
            TotalWeight := 0;
            REPEAT
                TotalWeight += MAWBLine4."Chargeable Weight";
            UNTIL MAWBLine4.NEXT = 0;
        END;
        OffloadLine.RESET;
        OffloadLine.SETRANGE(OffloadLine."MAWB No.", "No.");
        IF OffloadLine.FINDSET THEN BEGIN
            Tot := 0;
            REPEAT
                Tot += OffloadLine.Diffrence;
            UNTIL OffloadLine.NEXT = 0;
        END;
        TotalWt1 := TotalWeight;
        BookingSheetMAWBAlloc.RESET;
        BookingSheetMAWBAlloc.SETRANGE(BookingSheetMAWBAlloc."MAWB No", "No.");
        IF BookingSheetMAWBAlloc.FINDFIRST THEN BEGIN
            IF BookingSheetMAWBAlloc.BSA THEN BEGIN
                TotalWeight := BSA("No.");
            END;
            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", BookingSheetMAWBAlloc."Booking Sheet No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code", BookingSheetMAWBAlloc."Airline Code");
            BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code", BookingSheetMAWBAlloc."Flight No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Source Airport", BookingSheetMAWBAlloc."Source Airport");
            BookingSheetLine.SETRANGE(BookingSheetLine."Destination Airport", BookingSheetMAWBAlloc."Destination Airport");
            IF BookingSheetLine.FINDFIRST THEN BEGIN
                IF BookingSheetHeader.GET(BookingSheetLine."Booking Sheet No.") THEN BEGIN
                    BookingSheetLine."Booking Date" := BookingSheetHeader."Booking Date";
                    BookingSheetLine.MODIFY;
                    COMMIT;
                END ELSE BEGIN
                    LoadingSheetHeader.RESET;
                    LoadingSheetHeader.SETRANGE(LoadingSheetHeader."MAWB No.", "No.");
                    IF LoadingSheetHeader.FINDFIRST THEN
                        BookingSheetHeader.INIT;
                    BookingSheetHeader."No." := BookingSheetLine."Booking Sheet No.";
                    BookingSheetHeader."Booking Date" := LoadingSheetHeader."Loading Date";
                    BookingSheetHeader."Shipper Code" := LoadingSheetHeader."Shipper Code";
                    BookingSheetHeader.VALIDATE(BookingSheetHeader."Shipper Code");
                    BookingSheetHeader.Received := TRUE;
                    BookingSheetHeader.Status := BookingSheetHeader.Status::Received;
                    BookingSheetHeader.INSERT;
                    BookingSheetLine."Booking Date" := LoadingSheetHeader."Loading Date";
                    BookingSheetLine.MODIFY;
                    COMMIT;
                END;
                FreightChargeByAirline.RESET;
                FreightChargeByAirline.SETRANGE("Airline Code", BookingSheetLine."Airline Code");
                FreightChargeByAirline.SETFILTER(FreightChargeByAirline."Effective Start Date", '<=%1', BookingSheetLine."Booking Date");
                FreightChargeByAirline.SETFILTER(FreightChargeByAirline."Effective End Date", '>=%1', BookingSheetLine."Booking Date");
                IF FreightChargeByAirline.FINDFIRST THEN BEGIN
                    IF (BookingSheetLine."Booking Date" < FreightChargeByAirline."Effective Start Date") OR
                       (BookingSheetLine."Booking Date" > FreightChargeByAirline."Effective End Date") THEN BEGIN
                        ERROR(Text50004, BookingSheetLine.FIELDCAPTION("Booking Date"))
                    END ELSE BEGIN
                        FreightChargeByFlight.RESET;
                        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Airline Code", BookingSheetLine."Airline Code");
                        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Flight Code", BookingSheetLine."Flight Code");
                        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Source Airport", BookingSheetLine."Source Airport");
                        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Destination Airport", BookingSheetLine."Destination Airport");
                        FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Destination Code", BookingSheetLine."Destination Code");
                        FreightChargeByFlight.SETFILTER(FreightChargeByFlight."Effective Start Date", '<=%1', BookingSheetLine."Booking Date");
                        FreightChargeByFlight.SETFILTER(FreightChargeByFlight."Effective End Date", '>=%1', BookingSheetLine."Booking Date");
                        IF FreightChargeByFlight.FINDFIRST THEN BEGIN
                            FreightChargeByItem.RESET;
                            FreightChargeByItem.SETRANGE(FreightChargeByItem."Airline Code", FreightChargeByFlight."Airline Code");
                            FreightChargeByItem.SETRANGE(FreightChargeByItem."Flight Code", FreightChargeByFlight."Flight Code");
                            FreightChargeByItem.SETRANGE(FreightChargeByItem."No.", BookingSheetLine."Item No.");
                            FreightChargeByItem.SETRANGE(FreightChargeByItem."Source Airport", FreightChargeByFlight."Source Airport");
                            FreightChargeByItem.SETRANGE(FreightChargeByItem."Destination Airport", FreightChargeByFlight."Destination Airport");
                            FreightChargeByItem.SETFILTER(FreightChargeByItem."Effective Start Date", '<=%1', BookingSheetLine."Booking Date");
                            FreightChargeByItem.SETFILTER(FreightChargeByItem."Effective End Date", '>=%1', BookingSheetLine."Booking Date");
                            IF FreightChargeByItem.FINDSET THEN BEGIN
                                REPEAT
                                    FreightItemCharge.RESET;
                                    FreightItemCharge.SETFILTER(FreightItemCharge."Effective Start Date", '<>%1', 0D);
                                    FreightItemCharge.SETFILTER(FreightItemCharge."Effective End Date", '<>%1', 0D);
                                    FreightItemCharge.SETFILTER(FreightItemCharge."Effective Start Date", '<=%1', BookingSheetLine."Booking Date");
                                    FreightItemCharge.SETFILTER(FreightItemCharge."Effective End Date", '>=%1', BookingSheetLine."Booking Date");
                                    FreightItemCharge.SETRANGE(FreightItemCharge."Airline Code", FreightChargeByItem."Airline Code");
                                    FreightItemCharge.SETRANGE(FreightItemCharge."Flight Code", FreightChargeByItem."Flight Code");
                                    FreightItemCharge.SETRANGE(FreightItemCharge."Item No.", FreightChargeByItem."No.");
                                    FreightItemCharge.SETRANGE(FreightItemCharge."Source Airport", FreightChargeByItem."Source Airport");
                                    FreightItemCharge.SETRANGE(FreightItemCharge."Destination Airport", FreightChargeByItem."Destination Airport");
                                    FreightItemCharge.SETRANGE(FreightItemCharge.Source, FreightItemCharge.Source::System);
                                    IF FreightItemCharge.FINDSET THEN BEGIN
                                        REPEAT           /* message('%1 start date %2 End Date %3 Booking Sheet Date',FreightItemCharge."Effective Start Date"
                        ,FreightItemCharge."Effective End Date",BookingSheetLine."Booking Date");*/
                                            WorkingWeight := TotalWeight;
                                            MAWBInvoiceCharge.INIT;
                                            MAWBInvoiceCharge."Transaction Date" := TODAY;
                                            MAWBInvoiceCharge."MAWB No." := "No.";
                                            MAWBInvoiceCharge."Item No." := BookingSheetLine."Item No.";
                                            MAWBInvoiceCharge."Freight Charge Code" := FreightItemCharge.Code;
                                            MAWBInvoiceCharge."Line No." := MAWBInvoiceCharge."Line No." + 10000;
                                            MAWBInvoiceCharge.Description := FreightItemCharge.Description;
                                            MAWBInvoiceCharge."Item No." := BookingSheetLine."Item No.";
                                            CostAmount := 0;
                                            SalesAmount := 0;
                                            VATAmount := 0;
                                            MarginAmount := 0;
                                            FreightItemChargeMatrix.RESET;
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Airline Code", FreightItemCharge."Airline Code");
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Flight Code", FreightItemCharge."Flight Code");
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Item No.", FreightItemCharge."Item No.");
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Freight Charge Code", FreightItemCharge.Code);
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Source airport", FreightItemCharge."Source Airport");
                                            FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Destination Airport", FreightItemCharge."Destination Airport");
                                            FreightItemChargeMatrix.SETFILTER(FreightItemChargeMatrix."Effective Start Date", '<=%1', BookingSheetLine."Booking Date");
                                            FreightItemChargeMatrix.SETFILTER(FreightItemChargeMatrix."Effective End Date", '>=%1', BookingSheetLine."Booking Date");
                                            IF FreightItemChargeMatrix.FINDSET THEN BEGIN
                                                REPEAT
                                                    CASE FreightItemChargeMatrix.Calculation OF
                                                        FreightItemChargeMatrix.Calculation::"Flat Rate":
                                                            BEGIN
                                                                //MESSAGE('fLAT Rate for %1',TotalWeight);
                                                                IF (FreightItemChargeMatrix."From Weight" <= WorkingWeight) OR (FreightItemChargeMatrix."To Weight" <= WorkingWeight) THEN BEGIN
                                                                    CostAmount += FreightItemChargeMatrix."Rate Amount";
                                                                    WorkingWeight := WorkingWeight - FreightItemChargeMatrix.Difference;
                                                                END;
                                                            END;
                                                        FreightItemChargeMatrix.Calculation::"Kilo Rate":
                                                            BEGIN   //MESSAGE('');
                                                                IF WorkingWeight <= 0 THEN BEGIN
                                                                    //MESSAGE('Kilo Rate %1',TotalWeight);
                                                                END;
                                                                IF (WorkingWeight >= FreightItemChargeMatrix."From Weight") AND (WorkingWeight <= FreightItemChargeMatrix."To Weight") THEN BEGIN
                                                                    //MESSAGE('%1 Rate',FreightItemChargeMatrix."Rate Amount");
                                                                    //MESSAGE('çOST aMOUNT %1',CostAmount);
                                                                    CostAmount += (FreightItemChargeMatrix."Rate Amount" * WorkingWeight);
                                                                    WorkingWeight := 0;//TotalWeight-FreightItemChargeMatrix.Difference;
                                                                                       //MESSAGE('çOST aMOUNT %1',CostAmount);
                                                                END;
                                                            END;
                                                    END;
                                                UNTIL FreightItemChargeMatrix.NEXT = 0;
                                            END;
                                            MAWBInvoiceCharge."Currency Code" := FreightItemChargeMatrix."Currency Code";
                                            GeneralLedgerSetup.GET();
                                            IF MAWBInvoiceCharge."Currency Code" = '' THEN
                                                MAWBInvoiceCharge."Currency Code" := GeneralLedgerSetup."LCY Code";
                                            ImportExportSetup.GET();
                                            Ok := FreightCharge.GET(FreightItemCharge.Code);
                                            IF NOT BookingSheetMAWBAlloc.BSA THEN BEGIN
                                                MAWBInvoiceCharge."Base Unit Price" := CostAmount;
                                                MAWBInvoiceCharge."Cost Amount" := CostAmount;
                                                IF FreightCharge."Freight Cost" THEN BEGIN
                                                    MAWBInvoiceCharge."Chargeable Weight" := TotalWt1;
                                                    MAWBInvoiceCharge."Contract Rate" := CostAmount / TotalWt1;
                                                    MAWBInvoiceCharge."Agreed Rate" := CostAmount / TotalWt1;
                                                END;
                                            END ELSE BEGIN
                                                MAWBInvoiceCharge."Base Unit Price" := GetBSAFraction("No.") * CostAmount;
                                                MAWBInvoiceCharge."Cost Amount" := GetBSAFraction("No.") * CostAmount;
                                                IF FreightCharge."Freight Cost" THEN BEGIN
                                                    MAWBInvoiceCharge."Chargeable Weight" := TotalWt1;
                                                    MAWBInvoiceCharge."Contract Rate" := CostAmount / BSA("No.");
                                                    MAWBInvoiceCharge."Agreed Rate" := CostAmount / BSA("No.");
                                                END;
                                            END;//Check BSA
                                            MAWBInvoiceCharge."Sales Amount Ex. VAT" := MAWBInvoiceCharge."Invoice Unit Price" + MarginAmount;
                                            VATAmount := (VATPostingSetup."VAT %" * (MAWBInvoiceCharge."Invoice Unit Price" + MarginAmount)) / 100;
                                            MAWBInvoiceCharge."VAT Amount" := VATAmount;
                                            MAWBInvoiceCharge."Sales Amount Inc. VAT" := (MAWBInvoiceCharge."Invoice Unit Price" + MarginAmount + VATAmount);
                                            MAWBInvoiceCharge."Margin %" := FreightCharge."Margin %";
                                            MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");
                                            VATPostingSetup2.RESET;
                                            VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Bus. Posting Group", FreightCharge."VAT Bus. Posting Group");
                                            VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Prod. Posting Group", FreightCharge."VAT Prod. Posting Group");
                                            IF VATPostingSetup2.FIND('-') THEN BEGIN
                                                MAWBInvoiceCharge."VAT %" := VATPostingSetup2."VAT %";
                                                MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."VAT %");
                                            END;
                                            MAWBInvoiceCharge."Prepared By" := USERID;
                                            MAWBInvoiceCharge."Prepared On" := TODAY;
                                            MAWBInvoiceCharge.INSERT;
                                            MESSAGE('%1 Calculated Successfully', FreightCharge.Description);
                                        UNTIL FreightItemCharge.NEXT = 0;
                                    END;//FreightItemCharge.
                                UNTIL FreightChargeByItem.NEXT = 0;
                            END ELSE BEGIN
                                Item.GET(BookingSheetMAWBAlloc."Item No");
                                MESSAGE(Text004, Item.Description, BookingSheetMAWBAlloc."Flight No", BookingSheetMAWBAlloc."Source Airport", BookingSheetMAWBAlloc."Destination Airport");
                            END;//FreightChargeByItem.
                        END ELSE BEGIN
                            Ok := Item.GET(BookingSheetMAWBAlloc."Item No");
                            MESSAGE(Text003, BookingSheetMAWBAlloc."Flight No", Item.Description, BookingSheetMAWBAlloc."Source Airport", BookingSheetMAWBAlloc."Destination Airport");
                        END;//FreightChargeByFlight.
                    END;
                END ELSE BEGIN
                    MESSAGE(Text005, BookingSheetMAWBAlloc."Airline Code");
                    //MESSAGE(Text002,);
                END;//FreightChargeByAirline
            END ELSE BEGIN
                BookingSheetLine.INIT;
                BookingSheetLine."Booking Sheet No." := BookingSheetMAWBAlloc."Booking Sheet No";
                BookingSheetLine."Airline Code" := BookingSheetMAWBAlloc."Airline Code";
                BookingSheetLine."Flight Code" := BookingSheetMAWBAlloc."Flight No";
                BookingSheetLine."Source Airport" := BookingSheetMAWBAlloc."Source Airport";
                BookingSheetLine."Destination Airport" := BookingSheetMAWBAlloc."Destination Airport";
                BookingSheetLine."Line No." := 1000;
                BookingSheetLine.INSERT;
                MESSAGE('The Booking Sheet Line Has been Created. Please recalculate charges');
            END;//BookingSheetLine
        END;//BookingSheetMAWBAlloc
        //Freight Charges
        //KAA Fees
        BookingSheetMAWBAlloc.RESET;
        BookingSheetMAWBAlloc.SETRANGE(BookingSheetMAWBAlloc."MAWB No", "No.");
        IF BookingSheetMAWBAlloc.FINDFIRST THEN BEGIN
            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", BookingSheetMAWBAlloc."Booking Sheet No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code", BookingSheetMAWBAlloc."Airline Code");
            BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code", BookingSheetMAWBAlloc."Flight No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Source Airport", BookingSheetMAWBAlloc."Source Airport");
            BookingSheetLine.SETRANGE(BookingSheetLine."Destination Airport", BookingSheetMAWBAlloc."Destination Airport");
            IF BookingSheetLine.FINDFIRST THEN BEGIN
                MAWBLineCharge.RESET;
                IF MAWBLineCharge.FINDSET THEN BEGIN
                    REPEAT
                        MAWBInvoiceCharge.INIT;
                        IF MAWBInvoiceCharge.FINDLAST THEN BEGIN
                            MAWBInvoiceCharge."Line No." := MAWBInvoiceCharge."Line No." + 1000;
                        END;
                        MAWBInvoiceCharge."Transaction Date" := TODAY;
                        MAWBInvoiceCharge."MAWB No." := "No.";
                        MAWBInvoiceCharge."Freight Charge Code" := MAWBLineCharge.Code;
                        MAWBInvoiceCharge.Description := MAWBLineCharge.Description;
                        MAWBInvoiceCharge."Currency Code" := MAWBLineCharge."Currency Code";
                        MAWBReceipt2.RESET;
                        MAWBReceipt2.SETRANGE(MAWBReceipt2."MAWB No.", "No.");
                        IF MAWBReceipt2.FIND('-') THEN BEGIN
                            MAWBReceiptdate := MAWBReceipt2."Receipt Date";
                        END;
                        BookingSheetMawbAllocation.RESET;
                        BookingSheetMawbAllocation.SETRANGE(BookingSheetMawbAllocation."MAWB No", "No.");
                        IF BookingSheetMawbAllocation.FINDFIRST THEN BEGIN
                            MAWBInvoiceCharge."Item No." := BookingSheetMAWBAlloc."Item No";
                        END;
                        ImportExportSetup.GET();
                        IF MAWBLineCharge."Currency Code" <> ImportExportSetup."Invoicing Currency Code" THEN BEGIN
                            ExchangeRates.RESET;
                            ExchangeRates.SETRANGE(ExchangeRates."Currency Code", ImportExportSetup."Invoicing Currency Code");
                            ExchangeRates.SETRANGE(ExchangeRates."Relational Currency Code", MAWBLineCharge."Currency Code");
                            ExchangeRates.SETFILTER(ExchangeRates."Starting Date", '<=%1', TODAY);
                            IF ExchangeRates.FINDFIRST THEN BEGIN
                                MAWBInvoiceCharge."Base Unit Price" := ((MAWBLineCharge.Amount * ExchangeRates."Exchange Rate Amount") / (ExchangeRates."Relational Exch. Rate Amount"));
                                MAWBInvoiceCharge."Cost Amount" := ((MAWBLineCharge.Amount * ExchangeRates."Exchange Rate Amount") / (ExchangeRates."Relational Exch. Rate Amount"));
                                MAWBInvoiceCharge."Currency Code" := ImportExportSetup."Invoicing Currency Code";
                            END ELSE BEGIN
                                ExchangeRates.RESET;
                                ExchangeRates.SETRANGE(ExchangeRates."Currency Code", MAWBLineCharge."Currency Code");
                                ExchangeRates.SETRANGE(ExchangeRates."Relational Currency Code", '');
                                IF ExchangeRates.FINDFIRST THEN BEGIN
                                    ExchangeRates1.RESET;
                                    ExchangeRates1.SETRANGE(ExchangeRates1."Currency Code", ImportExportSetup."Invoicing Currency Code");
                                    ExchangeRates1.SETRANGE(ExchangeRates1."Relational Currency Code", '');
                                    IF ExchangeRates1.FINDFIRST THEN BEGIN
                                        MAWBInvoiceCharge."Base Unit Price" := (((MAWBLineCharge.Amount * ExchangeRates."Exchange Rate Amount") / (ExchangeRates."Relational Exch. Rate Amount")) * (ExchangeRates1."Relational Exch. Rate Amount")) / ExchangeRates1."Exchange Rate Amount";
                                        MAWBInvoiceCharge."Cost Amount" := (((MAWBLineCharge.Amount * ExchangeRates."Exchange Rate Amount") / (ExchangeRates."Relational Exch. Rate Amount")) * (ExchangeRates1."Relational Exch. Rate Amount")) / ExchangeRates1."Exchange Rate Amount";
                                        MAWBInvoiceCharge."Currency Code" := ImportExportSetup."Invoicing Currency Code";
                                    END;
                                END;
                            END;
                        END;
                        Ok := FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");
                        MAWBInvoiceCharge."Margin %" := FreightCharge."Margin %";
                        MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");
                        MAWBInvoiceCharge."Sales Amount Ex. VAT" := MAWBInvoiceCharge."Invoice Unit Price";
                        MAWBInvoiceCharge."Sales Amount Inc. VAT" := MAWBInvoiceCharge."Invoice Unit Price";
                        MAWBInvoiceCharge."Prepared By" := USERID;
                        MAWBInvoiceCharge."Prepared On" := TODAY;
                        MAWBInvoiceCharge."Chargeable Weight" := 0;
                        MAWBInvoiceCharge."Agreed Rate" := 0;
                        MAWBInvoiceCharge."Contract Rate" := 0;
                        MAWBInvoiceCharge.INSERT;
                        MESSAGE('KAA Fee for %1 Successfuly Inserted', BookingSheetMAWBAlloc."MAWB No");
                    UNTIL MAWBLineCharge.NEXT = 0;
                END;
            END;
        END;
        //KAA

    end;


    procedure CalculateHandlingFees("No.": Code[50])
    var
        BookingSheetLine: Record "Booking Sheet Line";
        Customer: Record Customer;
        FreightCharge: Record "Freight Charge";
        HandlingSlab: Record "Handling Slab Matrix";
        TotalSales: Decimal;
        Items: Record Item;
        FreightCost: Decimal;
        MAWBInvoiceCharge: Record "MAWB Invoice Charge";
        HandlingSlabMatrix: Record "Handling Slab Matrix";
        FreightItemCharge: Record "Freight Item Charge";
        FreightCharge2: Record "Freight Charge";
        Text001: Label 'Are you sure that you want to calculate the Handling fees?';
        FreightCharge3: Record "Freight Charge";
        MAWBInvoiceCharge3: Record "MAWB Invoice Charge";
        Text002: Label 'Handling Fee has already been calculated';
    begin
        FreightCharge3.RESET;
        FreightCharge3.SETRANGE(FreightCharge3."Handling Charge", TRUE);
        IF FreightCharge3.FIND('-') THEN BEGIN
            //  MESSAGE('HERE');
            MAWBInvoiceCharge3.RESET;
            MAWBInvoiceCharge3.SETRANGE(MAWBInvoiceCharge3."Freight Charge Code", FreightCharge3.Code);
            MAWBInvoiceCharge3.SETRANGE(MAWBInvoiceCharge3."MAWB No.", "No.");
            IF MAWBInvoiceCharge3.FIND('-') THEN
                MAWBInvoiceCharge3.DELETEALL;
        END;//END MAWBInvoiceCharge3.
        MAWBInvoiceCharge.RESET;

        MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.", "No.");
        IF MAWBInvoiceCharge.FIND('-') THEN BEGIN
            REPEAT
                TotalSales := TotalSales + MAWBInvoiceCharge."Base Unit Price";
            UNTIL MAWBInvoiceCharge.NEXT = 0;

            HandlingSlabMatrix.RESET;
            HandlingSlabMatrix.SETFILTER(HandlingSlabMatrix."From Weight", '<=%1', TotalSales);
            HandlingSlabMatrix.SETFILTER(HandlingSlabMatrix."To Weight", '>=%1', TotalSales);
            BookingSheetMawbAllocation.RESET;
            BookingSheetMawbAllocation.SETRANGE(BookingSheetMawbAllocation."MAWB No", "No.");
            IF BookingSheetMawbAllocation.FIND('-') THEN BEGIN
                BookingSheetLine.RESET;
                BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", BookingSheetMawbAllocation."Booking Sheet No");
                BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code", BookingSheetMawbAllocation."Airline Code");
                BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code", BookingSheetMawbAllocation."Flight No");
                BookingSheetLine.SETRANGE(BookingSheetLine."Source Airport", BookingSheetMawbAllocation."Source Airport");
                BookingSheetLine.SETRANGE(BookingSheetLine."Destination Airport", BookingSheetMawbAllocation."Destination Airport");
                IF BookingSheetLine.FINDFIRST THEN BEGIN
                    FreightChargeByFlight.RESET;
                    FreightChargeByFlight.SETRANGE("Airline Code", BookingSheetLine."Airline Code");
                    FreightChargeByFlight.SETRANGE("Flight Code", BookingSheetLine."Flight Code");
                    FreightChargeByFlight.SETRANGE("Destination Code", BookingSheetLine."Destination Code");
                    IF FreightChargeByFlight.FINDFIRST THEN BEGIN

                        FreightChargeByItem.RESET;
                        FreightChargeByItem.SETRANGE("Airline Code", BookingSheetLine."Airline Code");
                        FreightChargeByItem.SETRANGE("Flight Code", BookingSheetLine."Flight Code");
                        FreightChargeByItem.SETRANGE("No.", BookingSheetLine."Item No.");
                        IF FreightChargeByItem.FINDFIRST THEN BEGIN
                            FreightItemCharge.RESET;
                            FreightItemCharge.SETRANGE("Airline Code", BookingSheetLine."Airline Code");
                            FreightItemCharge.SETRANGE("Flight Code", BookingSheetLine."Flight Code");
                            FreightItemCharge.SETRANGE("Item No.", BookingSheetLine."Item No.");
                            IF FreightItemCharge.FINDSET THEN BEGIN

                                IF HandlingSlabMatrix.FIND('-') THEN BEGIN
                                    //MESSAGE('Total %1',TotalSales);
                                    MAWBInvoiceCharge.INIT;
                                    MAWBInvoiceCharge."Transaction Date" := TODAY;
                                    MAWBInvoiceCharge."MAWB No." := "No.";
                                    MAWBInvoiceCharge."Item No." := BookingSheetLine."Item No.";
                                    FreightCharge2.RESET;
                                    FreightCharge2.SETRANGE(FreightCharge2."Handling Charge", TRUE);
                                    IF FreightCharge2.FIND('-') THEN BEGIN
                                        MAWBInvoiceCharge."Freight Charge Code" := FreightCharge2.Code;
                                        MAWBInvoiceCharge.Description := FreightCharge2.Description;
                                        MAWBInvoiceCharge."Margin %" := FreightCharge2."Margin %";
                                        MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");
                                    END;  //END Freight Charge 2
                                    MAWBInvoiceCharge."Line No." := MAWBInvoiceCharge."Line No." + 10000;
                                    MAWBInvoiceCharge."Item No." := BookingSheetLine."Item No.";
                                    MAWBInvoiceCharge."Base Unit Price" := HandlingSlabMatrix."Rate Amount";
                                    MAWBInvoiceCharge."Cost Amount" := HandlingSlabMatrix."Rate Amount";
                                    MAWBInvoiceCharge."Currency Code" := HandlingSlabMatrix."Currency Code";
                                    GeneralLedgerSetup.GET();
                                    IF MAWBInvoiceCharge."Currency Code" = '' THEN
                                        InvoiceCurrency := GeneralLedgerSetup."LCY Code"
                                    ELSE
                                        InvoiceCurrency := MAWBInvoiceCharge."Currency Code";
                                    ImportExportSetup.GET();
                                    Ok := FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");
                                    MAWBInvoiceCharge."Margin %" := FreightCharge."Margin %";
                                    MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");

                                    MAWBInvoiceCharge."Sales Amount Ex. VAT" := MAWBInvoiceCharge."Invoice Unit Price";
                                    VATPostingSetup2.RESET;
                                    VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Bus. Posting Group", FreightCharge2."VAT Bus. Posting Group");
                                    VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Prod. Posting Group", FreightCharge2."VAT Prod. Posting Group");
                                    IF VATPostingSetup2.FIND('-') THEN BEGIN
                                        MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."VAT %", VATPostingSetup2."VAT %");
                                    END;//END VATPosting setup2
                                    MAWBInvoiceCharge."Prepared By" := USERID;
                                    MAWBInvoiceCharge."Prepared On" := TODAY;
                                    MAWBInvoiceCharge."Chargeable Weight" := 0;
                                    MAWBInvoiceCharge.INSERT;
                                END; //END HandlingSlabMatrix
                            END; //END FreightItemCharge
                        END; //END FreightChargeByItem.
                    END; //END FreightChargeByFlight
                END; //END BookingSheetLine.
            END;
        END;  //END MAWBInvoiceCharge
    end;


    procedure ClearCalculatedCharges("MAWB No": Code[50])
    var
        CalculatedCharges: Record "MAWB Invoice Charge";
    begin
        CalculatedCharges.RESET;
        CalculatedCharges.SETRANGE(CalculatedCharges."MAWB No.", "MAWB No");
        IF CalculatedCharges.FIND('-') THEN BEGIN
            CalculatedCharges.DELETEALL;
        END;
    end;


    procedure CheckAllCharges("MAWB No": Code[50]; "Invoice No.": Code[50])
    var
        BookingMAWB: Record "Booking Sheet MAWB Allocation";
        BookingLine: Record "Booking Sheet Line";
        Charges: Record "Freight Charge";
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
    begin
        BookingMAWB.RESET;
        BookingMAWB.SETRANGE(BookingMAWB."MAWB No", "MAWB No");
        IF BookingMAWB.FINDFIRST THEN BEGIN
            BookingLine.RESET;
            BookingLine.SETRANGE(BookingLine."Booking Sheet No.", BookingMAWB."Booking Sheet No");
            BookingLine.SETRANGE(BookingLine."Type of Delivery", 'FTD');
            IF BookingLine.FINDFIRST THEN BEGIN
                Charges.RESET;
                Charges.SETRANGE(Charges."Delivery Type", 'FTD');
                IF Charges.FINDSET THEN BEGIN
                    REPEAT
                        SalesLine.RESET;
                        SalesLine.SETRANGE(SalesLine."Document No.", "Invoice No.");
                        SalesLine.SETRANGE(SalesLine."Freight Charge Code", Charges.Code);
                        IF SalesLine.FINDFIRST THEN BEGIN
                        END ELSE BEGIN
                            ERROR('The Charge %1 for Delivery Type FTD is not Captured in the Invoice.', Charges.Description);
                        END;
                    UNTIL Charges.NEXT = 0;
                END;//Charges
            END;//BookingSHeetLine
        END;//Booking Sheet MAWB Alloc
    end;


    procedure ChackAWBStatus(MAWB: Code[50])
    var
        BSmawb: Record "Booking Sheet MAWB Allocation";
        BSlin: Record "Booking Sheet Line";
        GRLine: Record "Good Receipt Line";
        GrHeader: Record "Good Receipt Header";
        LSHeader: Record "Loading Sheet Header";
    begin
        IF MAWBs.GET(MAWB) THEN BEGIN
            MAWBReceipt.RESET;
            MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", MAWB);
            IF MAWBReceipt.FINDFIRST THEN BEGIN
                IF MAWBReceipt.Invoiced THEN BEGIN
                    MESSAGE('MAWB Invoiced');
                END ELSE BEGIN
                    IF MAWBs."Gate Pass Prepared" = FALSE THEN BEGIN
                        MESSAGE('Documentation Cleared. Pending Gate Pass Preparation');
                    END ELSE BEGIN
                        MESSAGE('Documentation Cleared. Gate Pass Prepared');
                    END;
                END
            END;
        END ELSE BEGIN
            LSHeader.RESET;
            LSHeader.SETRANGE(LSHeader."MAWB No.", MAWB);
            IF LSHeader.FINDFIRST THEN BEGIN
                MESSAGE('Loading Sheet Done. Pending Documentation');
            END ELSE BEGIN
                GRLine.RESET;
                GRLine.SETRANGE(GRLine."MAWB No.", MAWB);
                IF GRLine.FINDFIRST THEN BEGIN
                    MESSAGE('Goods Receipt Note Done. Pending Loading Sheet Preparation GRN Numbeer %1', GRLine."Good Receipt No.");
                END ELSE BEGIN
                    MESSAGE('Goods Receipt for AWB Not Done');
                END;
            END;
        END;
    end;


    procedure BSA(MAWb: Code[50]) BSAWeight: Decimal
    var
        MAWBLine: Record "MAWB Line";
        Flight: Record Flight;
        LoadingSheetHeader: Record "Loading Sheet Header";
        LoadingSheetHeader1: Record "Loading Sheet Header";
        LoadingSheetLine: Record "Loading Sheet Line";
        LoadingSheetLine1: Record "Loading Sheet Line";
    begin
        MAWBLine.RESET;
        MAWBLine.SETRANGE(MAWBLine."MAWB No.", MAWb);
        IF MAWBLine.FINDFIRST THEN BEGIN
            BSAWeight := 0;
            REPEAT
                BSAWeight += MAWBLine."Chargeable Weight";
            UNTIL MAWBLine.NEXT = 0;
            MAWBLine4.RESET;
            MAWBLine4.SETFILTER(MAWBLine4."MAWB No.", '<>%1', MAWBLine."MAWB No.");
            MAWBLine4.SETRANGE(MAWBLine4."Flight Code", MAWBLine."Flight Code");
            MAWBLine4.SETRANGE(MAWBLine4."Destination Code", MAWBLine."Destination Code");
            MAWBLine4.SETRANGE(MAWBLine4."Flight Date", MAWBLine."Flight Date");
            IF MAWBLine4.FINDSET THEN BEGIN
                REPEAT
                    BSAWeight += MAWBLine4."Chargeable Weight";
                UNTIL MAWBLine4.NEXT = 0;
            END;
        END;
        EXIT(BSAWeight);
    end;

    local procedure CheckBSA(Flight: Code[50]) ok: Boolean
    var
        MAWBAlloc: Record "Booking Sheet MAWB Allocation";
    begin
        ok := FALSE;
        MAWBAlloc.RESET;
        //Using Flight as master airway bill number
        MAWBAlloc.SETRANGE(MAWBAlloc."MAWB No", Flight);
        MAWBAlloc.SETRANGE(MAWBAlloc.BSA, TRUE);
        IF MAWBAlloc.FIND('-') THEN BEGIN
            ok := TRUE;
        END ELSE BEGIN
            ok := FALSE
        END;
        EXIT(ok);
    end;

    local procedure GetBSAFraction(MAWBNo: Code[50]) Fra: Decimal
    var
        AWBWt: Decimal;
        TotWt: Decimal;
    begin
        MAWBLine.RESET;
        MAWBLine.SETRANGE(MAWBLine."MAWB No.", MAWBNo);
        IF MAWBLine.FINDSET THEN BEGIN
            AWBWt := 0;
            REPEAT
                AWBWt += MAWBLine."Chargeable Weight";
            UNTIL MAWBLine.NEXT = 0;
        END;
        TotWt := BSA(MAWBNo);
        //MESSAGE('BSA Tot Weight%1',TotWt);
        EXIT(AWBWt / TotWt);
    end;

    local procedure ConvertCurrency(FromCurr: Code[10]; ToCurr: Code[10]; Date: Date)
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
    end;
}

