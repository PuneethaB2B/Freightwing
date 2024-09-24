table 50076 "MAWB Line"
{

    fields
    {
        field(1; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Header 2"."No.";
        }
        field(2; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                Description := Item.Description;

                IF gRecMAWBHr.GET("MAWB No.") THEN BEGIN
                    gRecMAWBHr."Item Description" := Description;
                    gRecMAWBHr.MODIFY;
                END;
            end;
        }
        field(3; Description; Text[50])
        {
            Editable = false;
        }
        field(4; "Split Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5; "Unit of Measure"; Code[20])
        {
        }
        field(6; "Rate/Charge"; Decimal)
        {
        }
        field(7; "Chargeable Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            FieldClass = Normal;
        }
        field(8; "HAWB No."; Code[20])
        {
            Editable = false;
        }
        field(9; "Line Amount"; Decimal)
        {
        }
        field(10; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(11; "Line No."; Integer)
        {
        }
        field(12; "Division Code"; Code[20])
        {
            TableRelation = "Division/Farm".Code;
        }
        field(13; "Gross Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(14; "Airline Code"; Code[20])
        {
            TableRelation = Airline;
        }
        field(15; "Consignee Code"; Code[20])
        {
            TableRelation = Consignee;
        }
        field(16; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No." WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(17; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(18; "Flight Date"; Date)
        {
        }
        field(19; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(20; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(21; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(22; "Invoice No."; Code[20])
        {
        }
        field(23; "Division/Farm Code"; Code[20])
        {
            TableRelation = "Division/Farm";
        }
        field(24; "Split Factor"; Decimal)
        {
            Editable = false;
        }
        field(25; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(32; Comments; Text[250])
        {
        }
        field(33; "Custom Enrty No"; Code[50])
        {
        }
        field(34; Phyto; Code[50])
        {
        }
        field(35; Lendth; Decimal)
        {
        }
        field(36; Width; Decimal)
        {
        }
        field(37; Height; Decimal)
        {
        }
        field(38; "Certificate of Origin"; Code[70])
        {
        }
        field(39; "Destination Airport"; Code[50])
        {
        }
        field(40; "Shipper Name"; Text[250])
        {
        }
        field(41; "Shipment Date"; Date)
        {
        }
        field(50000; "FWL Docket Weight"; Decimal)
        {
        }
        field(50001; "FWL Gross Weight"; Decimal)
        {
        }
        field(50002; "Volume Metric Weight"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "MAWB No.", "Line No.", "Shipper Code", "HAWB No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        HAWBLine.RESET;
        HAWBLine.SETRANGE("MAWB No.", "MAWB No.");
        HAWBLine.SETRANGE("HAWB No.", "HAWB No.");
        HAWBLine.SETRANGE("Item No.", "Item No.");
        IF HAWBLine.FINDFIRST THEN BEGIN
            HAWBLine."MAWB Prepared" := FALSE;
            HAWBLine.MODIFY;
        END;
    end;

    var
        Item: Record 27;
        HAWBLine: Record 50074;
        FreightChargeByAirline: Record 50025;
        FreightChargeByFlight: Record 50026;
        FreightChargeByItem: Record 50027;
        FreightItemCharge: Record 50028;
        FreightItemChargeMatrix: Record 50029;
        Day: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        WeekDay: Text;
        i: Integer;
        RateAmount: Decimal;
        EndCalc: Boolean;
        CummWeight: Decimal;
        TotalRateAmount: Decimal;
        RemainingWeight: Decimal;
        ChargeableWeight: Decimal;
        FreightCharge: Record 50018;
        SalesChargesAmount: Decimal;
        VATPostingSetup: Record 325;
        VATAmount: Decimal;
        WeightAgreementByAirline: Record 50033;
        WeightAgreementDestination: Record 50034;
        WeightAgreementByDay: Record 50035;
        WeightAgreementByItem: Record 50036;
        SalesWeightAmount: Decimal;
        Text001: Label '%1 is not within the Airline Charges Effective Date';
        MAWBReceipt: Record 50039;
        SplitFactor: Decimal;
        SpitWeight: Decimal;
        TotalQuantity: Decimal;
        MAWBInvoiceCharge: Record 50073;
        SalesHeader: Record 36;
        MAWBInvoiceNotifyParty: Record 50072;
        BookingSheetHAWBAllocation: Record 50056;
        NotifyParty: Record 50017;
        Text002: Label 'Freight Charge Code %1 , %2 does not have a Purchase Invoice attached to it.';
        Text003: Label 'Freight Charge Code %1 , %2 has not been calculated.';
        BookingSheetLine: Record 50054;
        BookedWeight: Decimal;
        TotalWeight: Decimal;
        MAWBLine: Record 50076;
        AmntLcy: Decimal;
        AmntInv: Decimal;
        ImportSetup: Record 50010;
        TBLPurchInvHeader: Record 122;
        gRecMAWBHr: Record 50077;


    procedure InsertSalesInvoiceFromMAWBLine(var SalesLine: Record 37)
    var
        SalesHeader: Record 36;
        SalesAllocationHeader: Record 36;
        SalesAllocationLine: Record 37;
        TempSalesLine: Record 37;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        BookingSheetLine: Record 50054;
        ItemCount: Integer;
        MAWBLine2: Record 50076;
        MAWBLine: Record 50076;
        Customer: Record 18;
        GLAccount: Record 15;
    begin
        SETRANGE("Shipper Code", "Shipper Code");
        SETRANGE("MAWB No.", "MAWB No.");
        SETRANGE("HAWB No.", "HAWB No.");
        SETRANGE("Item No.", "Item No.");
        TempSalesLine := SalesLine;
        IF SalesLine.FINDLAST THEN BEGIN
            NextLineNo := SalesLine."Line No." + 1000;
        END ELSE BEGIN
            NextLineNo := 1000;
        END;

        MAWBInvoiceCharge.RESET;
        MAWBInvoiceCharge.SETRANGE("MAWB No.", "MAWB No.");
        IF MAWBInvoiceCharge.FINDSET THEN BEGIN
            REPEAT
                SalesLine.INIT;
                SalesLine."Document Type" := TempSalesLine."Document Type";
                SalesLine."Document No." := TempSalesLine."Document No.";
                SalesLine."Document Type" := TempSalesLine."Document Type";
                SalesLine."Document No." := TempSalesLine."Document No.";
                SalesLine."Line No." := NextLineNo;
                NextLineNo += 1000;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine."Sell-to Customer No." := "Shipper Code";
                SalesLine."Split Weight" := "Chargeable Weight";
                SalesLine."Gross Weight" := "Gross Weight";
                SalesLine."MAWB No." := "MAWB No.";
                SalesLine."HAWB No." := "HAWB No.";
                SalesLine."Airline Code" := "Airline Code";
                SalesLine."Consignee Code" := "Consignee Code";
                SalesLine.Description := Description;
                SalesLine."Unit of Measure Code" := "Unit of Measure Code";
                SalesLine."Flight Code" := "Flight Code";
                SalesLine."Destination Code" := "Destination Code";
                SalesLine."Flight Date" := "Flight Date";
                "Invoice No." := TempSalesLine."Document No.";
                MODIFY;
                SalesLine."Division Code" := "Division Code";
                SalesHeader.GET(TempSalesLine."Document Type", TempSalesLine."Document No.");
                SalesHeader."HAWB No." := "HAWB No.";
                SalesHeader.MODIFY;
                FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");
                SalesLine."No." := FreightCharge."G/L Account";
                SalesLine."Freight Charge Code" := FreightCharge.Code;
                SalesLine.Description := FreightCharge.Description;
                Customer.GET("Shipper Code");
                SalesLine.VALIDATE("Gen. Bus. Posting Group", Customer."Gen. Bus. Posting Group");
                SalesLine.VALIDATE("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                SalesLine.VALIDATE("VAT Prod. Posting Group", FreightCharge."VAT Prod. Posting Group");
                GLAccount.GET(FreightCharge."G/L Account");
                SalesLine.VALIDATE("Gen. Prod. Posting Group", GLAccount."Gen. Prod. Posting Group");
                VATPostingSetup.GET(FreightCharge."VAT Bus. Posting Group", FreightCharge."VAT Prod. Posting Group");
                SalesLine.VALIDATE("VAT Prod. Posting Group", FreightCharge."VAT Prod. Posting Group");
                SalesLine.VALIDATE("VAT %", VATPostingSetup."VAT %");
                SalesLine.INSERT;
            UNTIL MAWBInvoiceCharge.NEXT = 0;
            GetPurchaseInvoiceLines("MAWB No.", TempSalesLine."Document No.");
            GetAWBFee("MAWB No.", TempSalesLine."Document No.");
        END ELSE BEGIN //MESSAGE('No');
        END;
    end;


    procedure MAWBLinesExist(): Boolean
    begin
        RESET;
        SETRANGE("MAWB No.", "MAWB No.");
        EXIT(FINDFIRST);
    end;


    procedure InsertMAWBInvoiceFromMAWBLine(var SalesLine: Record 37)
    var
        SalesHeader: Record 36;
        SalesAllocationHeader: Record 36;
        SalesAllocationLine: Record 37;
        TempSalesLine: Record 37;
        TransferOldExtLines: Codeunit "Transfer Old Ext. Text Lines";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        BookingSheetLine: Record 50054;
        ItemCount: Integer;
        MAWBLine2: Record 50076;
        MAWBLine: Record 50076;
    begin
    end;

    local procedure GetPurchaseInvoiceLines("MAWB No": Code[50]; "Invoice No": Code[50])
    var
        PurchaseInvoice: Record 122;
        PurchaseInvoiceLine: Record 123;
        SalesInvoiceLine: Record 37;
        NextLine: Integer;
        SalesInvoiceHeader: Record 36;
        ExchangeRate: Decimal;
    begin
        ImportSetup.GET;
        PurchaseInvoiceLine.RESET;
        PurchaseInvoiceLine.SETRANGE(PurchaseInvoiceLine."Payment Voucher No.", "MAWB No");
        IF PurchaseInvoiceLine.FINDSET THEN BEGIN
            SalesInvoiceLine.RESET;
            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", "Shipper Code");
            SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.", "MAWB No.");
            IF SalesInvoiceLine.FINDLAST THEN BEGIN
                NextLine := SalesInvoiceLine."Line No." + 10000;
            END ELSE BEGIN
                NextLine := 10000;
            END;
            REPEAT
                IF FreightCharge.GET(PurchaseInvoiceLine."Charge Code") THEN BEGIN
                    IF FreightCharge."Freight Cost" THEN BEGIN
                    END ELSE BEGIN
                        PurchaseInvoice.GET(PurchaseInvoiceLine."Document No.");
                        SalesInvoiceLine.INIT;
                        SalesInvoiceLine."Document Type" := SalesInvoiceLine."Document Type"::Invoice;
                        SalesInvoiceLine."Document No." := "Invoice No";
                        SalesInvoiceLine."Line No." := NextLine;
                        NextLine += 1000;
                        SalesInvoiceLine.Type := SalesInvoiceLine.Type::"G/L Account";
                        IF FreightCharge.GET(PurchaseInvoiceLine."Charge Code") THEN BEGIN
                            SalesInvoiceLine."No." := FreightCharge."G/L Account";
                        END ELSE BEGIN
                            SalesInvoiceLine."No." := '';
                        END;
                        SalesInvoiceLine."Sell-to Customer No." := "Shipper Code";
                        SalesInvoiceLine."Split Weight" := "Chargeable Weight";
                        SalesInvoiceLine."Gross Weight" := "Gross Weight";
                        SalesInvoiceLine."MAWB No." := "MAWB No.";
                        SalesInvoiceLine."HAWB No." := "HAWB No.";
                        SalesInvoiceLine."Airline Code" := "Airline Code";
                        SalesInvoiceLine."Consignee Code" := "Consignee Code";
                        SalesInvoiceLine.Description := PurchaseInvoiceLine.Description;
                        SalesInvoiceLine."Unit of Measure Code" := "Unit of Measure Code";
                        SalesInvoiceLine."Flight Code" := "Flight Code";
                        SalesInvoiceLine."Destination Code" := "Destination Code";
                        SalesInvoiceLine."Flight Date" := "Flight Date";
                        SalesInvoiceLine.VALIDATE(SalesInvoiceLine."Currency Code", SalesInvoiceHeader."Currency Code");
                        SalesInvoiceLine."Gen. Prod. Posting Group" := PurchaseInvoiceLine."Gen. Prod. Posting Group";
                        SalesInvoiceLine."Gen. Bus. Posting Group" := PurchaseInvoiceLine."Gen. Bus. Posting Group";
                        SalesInvoiceLine."VAT Bus. Posting Group" := PurchaseInvoiceLine."VAT Bus. Posting Group";
                        //SalesInvoiceLine."VAT Prod. Posting Group":='VAT0';
                        IF FreightCharge.GET(PurchaseInvoiceLine."Charge Code") THEN
                            SalesInvoiceLine."VAT Prod. Posting Group" := FreightCharge."VAT Prod. Posting Group";
                        SalesInvoiceLine."Freight Charge Code" := PurchaseInvoiceLine."Charge Code";
                        SalesInvoiceLine.VALIDATE(SalesInvoiceLine."VAT Prod. Posting Group");
                        SalesInvoiceLine."Cost Amount" := PurchaseInvoiceLine.Amount;
                        //(PurchaseInvoiceLine."Unit Cost (LCY)"*PurchaseInvoiceLine.Quantity);//*GetExchangeRate(ImportSetup."Invoicing Currency Code",PurchaseInvoice."Posting Date");
                        SalesInvoiceLine.Amount := SalesInvoiceLine."Cost Amount";
                        SalesInvoiceLine.VALIDATE(SalesInvoiceLine."Unit Cost (LCY)", PurchaseInvoiceLine."Unit Cost (LCY)");
                        SalesInvoiceLine."Freight Charge Code" := PurchaseInvoiceLine."Charge Code";
                        // ******************* TBL Inserting currency ***********
                        TBLPurchInvHeader.GET(PurchaseInvoiceLine."Document No.");
                        SalesInvoiceLine.TBLCurrency := TBLPurchInvHeader."Currency Code";
                        // ******************** end of inserting  ***************

                        SalesInvoiceLine.INSERT;
                    END;
                END;
            UNTIL PurchaseInvoiceLine.NEXT = 0;
        END;
    end;

    local procedure GetExchangeRate(From: Code[10]; Dates: Date) Rate: Decimal
    var
        ExchangeRates: Record 330;
    begin
        ExchangeRates.RESET;
        //MESSAGE(From);
        ExchangeRates.SETRANGE(ExchangeRates."Currency Code", From);
        ExchangeRates.SETFILTER(ExchangeRates."Starting Date", '<=%1', Dates);
        IF ExchangeRates.FINDFIRST THEN BEGIN
            Rate := ExchangeRates."Relational Exch. Rate Amount";
            //MESSAGE('EX %1 curr %2',Rate,ExchangeRates."Currency Code");
        END ELSE BEGIN
            ERROR('No Exchange Rate Defined for %1 For Cur  %2', Dates, From);
        END;
        EXIT(Rate);
    end;

    local procedure GetAWBFee(MAWB: Code[50]; "Invoice No": Code[50])
    var
        FreightCharge: Record 50018;
        SalesLine: Record 37;
        SalesHeader: Record 36;
        MAWBReceipt: Record 50039;
        NextLine: Integer;
        Customer: Record 18;
        BookingSheetMAWBAllocation: Record 50070;
        GLAccount: Record 15;
    begin
        MAWBReceipt.RESET;
        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", MAWB);
        IF MAWBReceipt.FINDFIRST THEN BEGIN
            IF MAWBReceipt."MAWB Fees" <> 0 THEN BEGIN
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", MAWB);
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    Customer.GET(BookingSheetMAWBAllocation."Shipper Code");
                END;

                SalesLine.INIT;
                SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                SalesLine."Document No." := "Invoice No";
                SalesLine."Line No." := NextLine;
                NextLine += 1000;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine."Freight Charge Code" := '4';
                IF FreightCharge.GET('4') THEN BEGIN
                    SalesLine."No." := FreightCharge."G/L Account";
                END ELSE BEGIN
                    SalesLine."No." := '';
                END;
                SalesLine."Sell-to Customer No." := BookingSheetMAWBAllocation."Shipper Code";
                SalesLine."Split Weight" := "Chargeable Weight";
                SalesLine."Gross Weight" := "Gross Weight";
                SalesLine."MAWB No." := MAWB;
                SalesLine."HAWB No." := "HAWB No.";
                SalesLine."Airline Code" := BookingSheetMAWBAllocation."Airline Code";
                SalesLine."Consignee Code" := "Consignee Code";
                SalesLine.Description := FreightCharge.Description;
                SalesLine."Unit of Measure Code" := "Unit of Measure Code";
                SalesLine."Flight Code" := "Flight Code";
                SalesLine."Destination Code" := "Destination Code";
                SalesLine."Flight Date" := "Flight Date";
                SalesLine.VALIDATE(SalesLine."Currency Code", SalesHeader."Currency Code");
                SalesLine."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                SalesLine."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
                SalesLine."VAT Prod. Posting Group" := FreightCharge."VAT Prod. Posting Group";
                GLAccount.GET(FreightCharge."G/L Account");
                SalesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                VATPostingSetup.GET(FreightCharge."VAT Bus. Posting Group", FreightCharge."VAT Prod. Posting Group");
                SalesLine."VAT %" := VATPostingSetup."VAT %";
                SalesLine.VALIDATE(SalesLine."VAT Prod. Posting Group");
                SalesLine."Cost Amount" := MAWBReceipt."MAWB Fees";
                SalesLine.Amount := SalesLine."Cost Amount";
                SalesLine.Amount := SalesLine."Cost Amount";
                SalesLine."Line Amount" := SalesLine."Cost Amount";
                SalesLine."Unit Price" := SalesLine."Cost Amount";

                SalesLine.INSERT;
            END;
        END;
    end;
}

