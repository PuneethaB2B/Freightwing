report 50070 "Posted MAWB Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/PostedMAWBInvoice.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = "QR Code";
            RequestFilterFields = "No.";
            column(DocumentDate_SalesInvoiceHeader; "Sales Invoice Header"."Document Date")
            {
            }
            column(BillToAddress; BillToAddress)
            {
            }
            column(BenfAccountName_; BenfAccountName)
            {
            }
            column(HideBeneficiary; HideBenf)
            {
            }
            column(BenfAcc; BenfAccount)
            {
            }
            column(BenfBranch; BenfBranch)
            {
            }
            column(BenfBankName; BenfBankname)
            {
            }
            column(BeneficiaryName; BenfName)
            {
            }
            column(PostCode; CompInfo."Post Code")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(RegNo; CompInfo."Registration No.")
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(VAT; CompInfo."VAT Registration No.")
            {
            }
            column(KRA; ImportExportSetup."KRA Pin")
            {
            }
            column(MAWBNo_SalesHeader; "Sales Invoice Header"."MAWB No.")
            {
            }
            column(HAWBNo_SalesHeader; "Sales Invoice Header"."HAWB No.")
            {
            }
            column(Posted_SalesHeader; "Sales Invoice Header".Posted)
            {
            }
            column(DocumentType_SalesHeader; "Sales Invoice Header"."Transaction Type")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(CompPicture; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(Shipper_; ShipperName)
            {
            }
            column(Consignee_; ConsigneeName)
            {
            }
            column(Phyto_; Phyto)
            {
            }
            column(Euro_; Euro)
            {
            }
            column(CurrencyCode_SalesHeader; "Sales Invoice Header"."Currency Code")
            {
            }
            column(custom_; Custom)
            {
            }
            column(Branch_; Branch)
            {
            }
            column(Account_; Account)
            {
            }
            column(Houses_; Houses)
            {
            }
            column(Name_; name)
            {
            }
            column(ExchangeRate_; Exchange)
            {
            }
            column(BillTo_; BillTo)
            {
            }
            column(FlightNo_; FlightNo)
            {
            }
            column(Boxes_; NoOfBoxes)
            {
            }
            column(Destination_; Dest)
            {
            }
            column(AmntInWords; AmountInWords)
            {
            }
            column(TotalWeight_; TotalWeight)
            {
            }
            column(TotBoxes_; TotBoxes)
            {
            }
            column(PrepBy_; PrepBy)
            {
            }
            column(Commodity_SalesInvoiceHeader; "Sales Invoice Header".Commodity)
            {
            }
            column(QRCode_SalesHeader; "Sales Invoice Header"."QR Code")
            {
            }
            column(InvoiceNumber_SalesInvoiceHeader; "Sales Invoice Header"."Invoice Number")
            {
            }
            column(DeiviceCode_SalesInvoiceHeader; "Sales Invoice Header"."Deivice Code")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(VAT_SalesLine; "Sales Invoice Line"."VAT %")
                {
                }
                column(Division_; Division)
                {
                }
                column(DivWeight_; DivWeight)
                {
                }
                column(DivEuro_; DivEuro)
                {
                }
                column(DivCustom_; DivCustom)
                {
                }
                column(DivNoOfBoxes_; DivNoOfBoxes)
                {
                }
                column(GrossWeight_SalesLine; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(MAWBNo_SalesLine; "Sales Invoice Line"."MAWB No.")
                {
                }
                column(Description_SalesLine; "Sales Invoice Line".Description)
                {
                }
                column(HAWBNo_SalesLine; "Sales Invoice Line"."HAWB No.")
                {
                }
                column(DivisionCode_SalesLine; "Sales Invoice Line"."Division Code")
                {
                }
                column(SplitWeight_SalesLine; "Sales Invoice Line"."Split Weight")
                {
                }
                column(AirlineCode_SalesLine; "Sales Invoice Line"."Airline Code")
                {
                }
                column(ConsigneeCode_SalesLine; "Sales Invoice Line"."Consignee Code")
                {
                }
                column(FlightCode_SalesLine; "Sales Invoice Line"."Flight Code")
                {
                }
                column(DestinationCode_SalesLine; "Sales Invoice Line"."Destination Code")
                {
                }
                column(FlightDate_SalesLine; "Sales Invoice Line"."Flight Date")
                {
                }
                column(VATAmount_SalesLine; "Sales Invoice Line"."VAT Amount")
                {
                }
                column(CostAmount_SalesLine; "Sales Invoice Line"."Cost Amount")
                {
                }
                column(FreightChargeCode_SalesLine; "Sales Invoice Line"."Freight Charge Code")
                {
                }
                column(SplitFactor_SalesLine; "Sales Invoice Line"."Split Factor")
                {
                }
                column(DocumentType_SalesLine; "Sales Invoice Line"."Transaction Type")
                {
                }
                column(SelltoCustomerNo_SalesLine; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Invoice Line"."Line No.")
                {
                }
                column(Type_SalesLine; "Sales Invoice Line".Type)
                {
                }
                column(No_SalesLine; "Sales Invoice Line"."No.")
                {
                }
                column(Amount_SalesLine; "Sales Invoice Line".Amount)
                {
                }
                column(LineAmount_SalesLine; "Sales Invoice Line"."Line Amount")
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(TBLTotalAmountVAT; TBLTotalAmountVAT)
                {
                }
                column(HSCode; "Sales Invoice Line".GetHSCode)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Division := '';
                    DivWeight := 0;
                    DivCustom := '';
                    DivEuro := '';
                    DivNoOfBoxes := 0;
                    MAWBLine.RESET;
                    MAWBLine.SETRANGE(MAWBLine."Shipper Code", "Sales Invoice Line"."Sell-to Customer No.");
                    MAWBLine.SETRANGE(MAWBLine."MAWB No.", "Sales Invoice Line"."MAWB No.");
                    MAWBLine.SETRANGE(MAWBLine."HAWB No.", "Sales Invoice Line"."HAWB No.");
                    IF MAWBLine.FINDFIRST THEN BEGIN
                        Division := MAWBLine."Division/Farm Code";
                        DivWeight := MAWBLine."Chargeable Weight";
                        DivCustom := MAWBLine."Custom Enrty No";
                        DivEuro := MAWBLine."Certificate of Origin";
                        DivNoOfBoxes := MAWBLine.Quantity;
                    END;
                    MAWBLine.RESET;
                    //MAWBLine.SETRANGE(MAWBLine."Shipper Code","Sales Invoice Line"."Sell-to Customer No.");
                    MAWBLine.SETRANGE(MAWBLine."MAWB No.", "Sales Invoice Line"."MAWB No.");
                    IF MAWBLine.FINDSET THEN BEGIN
                        //TotalWeight := 0;
                        //TotBoxes:=0;
                        REPEAT
                        //TotalWeight += MAWBLine."Chargeable Weight";
                        //TotBoxes+=MAWBLine.Quantity;
                        UNTIL MAWBLine.NEXT = 0;
                    END;
                    //MESSAGE('%1',TotalWeight);

                    // ************ TBL VAT CALCULATION ************
                    TBLVATAmountLine.INIT;
                    TBLVATAmountLine."VAT Identifier" := "VAT Identifier";
                    TBLVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                    TBLVATAmountLine."Tax Group Code" := "Tax Group Code";
                    TBLVATAmountLine."VAT %" := "VAT %";
                    TBLVATAmountLine."VAT Base" := Amount;
                    TBLVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                    TBLVATAmountLine."Line Amount" := "Line Amount";
                    IF "Allow Invoice Disc." THEN
                        TBLVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                    TBLVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                    TBLVATAmountLine.InsertLine;

                    TBLTotalSubTotal += "Line Amount";
                    TBLTotalInvDiscAmount -= "Inv. Discount Amount";
                    TBLTotalAmount += Amount;
                    TBLTotalAmountVAT += "Amount Including VAT" - Amount;
                    TBLTotalAmountInclVAT += "Amount Including VAT";
                    TBLTotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                    //message('%1',TBLTotalAmountVAT);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Cust.GET("Sales Invoice Header"."Bill-to Customer No.");
                BillToAddress := Cust.Address + ', ' + Cust."Post Code" + ',' + Cust.City + '-' + Cust."Country/Region Code";
                BookingSheetMAWB.RESET;
                BookingSheetMAWB.SETRANGE(BookingSheetMAWB."MAWB No", "Sales Invoice Header"."MAWB No.");
                IF BookingSheetMAWB.FINDFIRST THEN BEGIN
                    ConsigneeName := BookingSheetMAWB."Consignee Name";
                    Airports.RESET;
                    Airports.SETRANGE(Airports.Code, BookingSheetMAWB."Destination Airport");
                    IF Airports.FINDFIRST THEN BEGIN
                        Dest := Airports."Country Code" + '{ ' + Airports.Name + ' }';
                    END;
                END;
                PrepBy := USERID;
                MawbHeader.RESET;
                MawbHeader.SETRANGE(MawbHeader."No.", "Sales Invoice Header"."MAWB No.");
                IF MawbHeader.FINDFIRST THEN BEGIN
                    Phyto := MawbHeader."Phyto Certificate";
                    Euro := MawbHeader."Euro Form No";
                    Custom := MawbHeader."Custom Entry No";
                    IF MawbHeader."Has Houses" THEN BEGIN
                        Houses := TRUE;
                    END ELSE BEGIN
                        Houses := FALSE;
                    END;
                END;
                Cust.GET("Sales Invoice Header"."Sell-to Customer No.");
                ShipperName := Cust.Name;
                Cust.GET("Sales Invoice Header"."Bill-to Customer No.");
                BillTo := Cust.Name;
                Banks.RESET;
                Banks.SETRANGE(Banks."Currency Code", "Sales Invoice Header"."Currency Code");
                Banks.SETRANGE(Banks."Customer Payments", TRUE);
                IF Banks.FINDFIRST THEN BEGIN
                    name := Banks.Name;
                    Branch := Banks."Bank Branch No." + ' Branch';
                    Account := Banks."Bank Account No.";
                    BenF.RESET;
                    BenF.SETRANGE(BenF."Account Number", Account);
                    IF BenF.FINDFIRST THEN BEGIN
                        BenfAccountName := BenF."Bank Name" + ' ' + BenF.Branch + ' Branch Account Number ' + BenF."Account Number";
                        IF Banks1.GET(BenF."Intermediary Bank") THEN BEGIN
                            BenfName := BenF."Beneficiary Name";
                            BenfAccount := Banks1."Bank Account No.";
                            BenfBranch := Banks1."Bank Branch No.";
                            BenfBankname := Banks1.Name;
                        END;
                    END;
                END;

                Currex.RESET;
                Currex.SETCURRENTKEY("Currency Code", "Starting Date");
                Currex.SETFILTER(Currex."Starting Date", '<=%1', "Sales Invoice Header"."Posting Date");
                Currex.SETRANGE(Currex."Currency Code", "Sales Invoice Header"."Currency Code");
                IF Currex.FINDLAST THEN BEGIN
                    Exchange := Currex."Relational Exch. Rate Amount";
                    //MESSAGE('%1',Currex."Starting Date");
                END;
                LoadingSheetLine.RESET;
                LoadingSheetLine.SETRANGE(LoadingSheetLine."MAWB No.", "Sales Invoice Header"."MAWB No.");
                IF LoadingSheetLine.FINDSET THEN BEGIN
                    LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);
                    FlightNo := LoadingSheetLine."Flight Code";
                    NoOfBoxes := LoadingSheetLine.Quantity;
                END;
                SalesLine.RESET;
                SalesLine.SETRANGE(SalesLine."Document No.", "Sales Invoice Header"."No.");
                IF SalesLine.FINDSET THEN BEGIN
                    TotalAmount := 0;
                    REPEAT
                        //Message('%1',SalesLine."Amount Including VAT");
                        TotalAmount += SalesLine."Amount Including VAT";
                    UNTIL SalesLine.NEXT = 0;
                END;
                //MESSAGE(ConvertToText(FORMAT(TotalAmount),"Sales Invoice Header"."Currency Code")+'%1',"Sales Invoice Header"."No.");
                AmountInWords := ConvertToText(FORMAT(TotalAmount), "Sales Invoice Header"."Currency Code");

                CalculateTotalWeight;
                //  ************* TBL VAT Initialization ******************
                TBLTotalSubTotal := 0;
                TBLTotalInvDiscAmount := 0;
                TBLTotalAmount := 0;
                TBLTotalAmountVAT := 0;
                TBLTotalAmountInclVAT := 0;
                TBLTotalPaymentDiscOnVAT := 0;
            end;

            trigger OnPreDataItem()
            begin
                ImportExportSetup.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Hide Beneficiary Details"; HideBenf)
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
    end;

    var
        ImportExportSetup: Record "Import/Export Setup";
        BillToAddress: Text[250];
        BenfAccountName: Text[250];
        HideBenf: Boolean;
        Banks1: Record "Bank Account";
        BenfAccount: Code[50];
        BenfBranch: Text[50];
        BenfBankname: Text[50];
        BenF: Record "Beneficiary Details";
        BenfName: Text[250];
        PrepBy: Code[50];
        TotBoxes: Decimal;
        DivNoOfBoxes: Decimal;
        TotalWeight: Decimal;
        Houses: Boolean;
        DivCustom: Text[50];
        DivWeight: Decimal;
        DivEuro: Text[50];
        Division: Text[50];
        CompInfo: Record "Company Information";
        Consignees: Record Consignee;
        Shippers: Record "Shipper Agent";
        ShipperName: Text[50];
        ConsigneeName: Text[50];
        MawbHeader: Record "MAWB Header 2";
        Phyto: Text[50];
        Euro: Text[50];
        Custom: Text[50];
        Banks: Record "Bank Account";
        Account: Code[50];
        Branch: Text[50];
        name: Text[50];
        Cust: Record Customer;
        Currex: Record 330;
        Exchange: Decimal;
        BillTo: Text[250];
        BookingSheetMAWB: Record "Booking Sheet MAWB Allocation";
        FlightNo: Code[50];
        NoOfBoxes: Decimal;
        LoadingSheetLine: Record "Loading Sheet Line";
        Airports: Record Airport;
        Dest: Text[50];
        txt: Text[30];
        CommaPosition: Integer;
        StartPosition: Integer;
        boolPrintDecimal: Boolean;
        AmountInWords: Text[250];
        TotalAmount: Decimal;
        SalesLine: Record "Sales Line";
        SalesLine1: Record "Sales Line";
        MAWBLine: Record "MAWB Line";
        TBLVATAmountLine: Record "VAT Amount Line";
        TBLTotalSubTotal: Decimal;
        TBLTotalInvDiscAmount: Decimal;
        TBLTotalAmount: Decimal;
        TBLTotalAmountVAT: Decimal;
        TBLTotalAmountInclVAT: Decimal;
        TBLTotalPaymentDiscOnVAT: Decimal;


    procedure ConvertToText(MyAmount: Text[30]; CurrencyCode: Code[10]) txtConvertedAmount: Text[250]
    var
        txtMyAmount: Text[30];
        txtIntegerPart: Text[30];
        txtDecimalPart: Text[30];
        intDecimalPlace: Integer;
        intCount: Integer;
        txtTemp: Text[250];
        txtFinalInteger: Text[250];
        txtFinalDecimal: Text[250];
        arrPlace: array[9] of Text[20];
        recCurrency: Record Currency;
        txtCurrencyNumericPos: Text[30];
        txtCurrencyDecimalPos: Text[30];
        txtTemp2: Text[2];
    begin

        IF STRPOS(MyAmount, ',') > 0 THEN BEGIN
            StartPosition := 1;
            REPEAT
                CommaPosition := STRPOS(MyAmount, ',');
                txt := txt + COPYSTR(MyAmount, StartPosition, CommaPosition - 1);
                MyAmount := COPYSTR(MyAmount, CommaPosition + 1);
            UNTIL STRPOS(MyAmount, ',') = 0;
            txt := txt + COPYSTR(MyAmount, StartPosition);
            MyAmount := txt;
        END;
        arrPlace[2] := ' THOUSAND ';
        arrPlace[3] := ' MILLION ';
        arrPlace[4] := ' BILLION ';
        arrPlace[5] := ' TRILLION ';
        /*IF (CurrencyCode = '') OR (CurrencyCode='') THEN
           boolPrintDecimal:=FALSE;
        */
        boolPrintDecimal := TRUE;
        recCurrency.RESET;
        recCurrency.SETRANGE(Code, CurrencyCode);
        IF recCurrency.FIND('-') THEN BEGIN
            txtCurrencyNumericPos := recCurrency."Currency Numeric Description";
            txtCurrencyDecimalPos := recCurrency."Currency Decimal Description";
        END
        ELSE BEGIN
            txtCurrencyNumericPos := '';
            txtCurrencyDecimalPos := 'CENT';
        END;



        //txtMyAmount := FORMAT(MyAmount);
        txtMyAmount := MyAmount;
        // Position of decimal place 0 if none.
        intDecimalPlace := STRPOS(txtMyAmount, '.');
        // Convert cents and set txtMyAmount to dollar amount.
        IF intDecimalPlace > 0 THEN BEGIN
            txtDecimalPart := COPYSTR(txtMyAmount, intDecimalPlace + 1, 2);
            txtDecimalPart := fnGetTens(txtDecimalPart);
            txtIntegerPart := COPYSTR(txtMyAmount, 1, intDecimalPlace - 1);
        END
        ELSE BEGIN
            txtIntegerPart := COPYSTR(txtMyAmount, 1);
        END;

        intCount := 1;
        REPEAT
            IF STRLEN(txtIntegerPart) >= 3 THEN
                txtTemp := COPYSTR(txtIntegerPart, STRLEN(txtIntegerPart) - 2, 3)
            ELSE
                txtTemp := txtIntegerPart;

            txtTemp := fnGetHundreds(txtTemp);
            IF txtTemp <> '' THEN
                txtFinalInteger := txtTemp + arrPlace[intCount] + txtFinalInteger;
            IF STRLEN(txtIntegerPart) > 3 THEN
                txtIntegerPart := COPYSTR(txtIntegerPart, 1, STRLEN(txtIntegerPart) - 3)
            ELSE
                txtIntegerPart := '';

            intCount := intCount + 1;
        UNTIL txtIntegerPart = '';

        IF txtFinalInteger = '' THEN
            txtFinalInteger := txtCurrencyNumericPos + ' ZERO'
        ELSE BEGIN
            IF txtFinalInteger = 'ONE' THEN
                txtFinalInteger := txtCurrencyNumericPos + ' ONE'
            ELSE
                txtFinalInteger := txtCurrencyNumericPos + ' ' + txtFinalInteger;
            //      txtFinalInteger := txtCurrencyNumericPos + 'S ' + txtFinalInteger ;
        END;
        IF boolPrintDecimal THEN BEGIN
            IF txtDecimalPart = '' THEN
                txtDecimalPart := ' AND ZERO ' + txtCurrencyDecimalPos + 'S'
            ELSE BEGIN
                IF txtDecimalPart = 'ONE' THEN
                    txtDecimalPart := ' AND ONE ' + txtCurrencyDecimalPos
                ELSE
                    txtDecimalPart := ' AND ' + txtDecimalPart + ' ' + txtCurrencyDecimalPos + 'S';
            END;
        END
        ELSE
            txtDecimalPart := ' AND ' + txtDecimalPart;
        IF boolPrintDecimal THEN
            txtConvertedAmount := txtFinalInteger + txtDecimalPart + ' ONLY'
        ELSE
            txtConvertedAmount := txtFinalInteger + ' ONLY';

    end;


    procedure fnGetTens(txtTens_in: Text[2]) txtTens_out: Text[100]
    var
        txtTemp: Text[50];
    begin
        // If value between 10-19...
        txtTemp := COPYSTR(txtTens_in, 1, 1);
        IF txtTemp = '1' THEN BEGIN
            IF txtTens_in = '10' THEN
                txtTens_out := 'TEN'
            ELSE
                IF txtTens_in = '11' THEN
                    txtTens_out := 'ELEVEN'
                ELSE
                    IF txtTens_in = '12' THEN
                        txtTens_out := 'TWELVE'
                    ELSE
                        IF txtTens_in = '13' THEN
                            txtTens_out := 'THIRTEEN'
                        ELSE
                            IF txtTens_in = '14' THEN
                                txtTens_out := 'FOURTEEN'
                            ELSE
                                IF txtTens_in = '15' THEN
                                    txtTens_out := 'FIFTEEN'
                                ELSE
                                    IF txtTens_in = '16' THEN
                                        txtTens_out := 'SIXTEEN'
                                    ELSE
                                        IF txtTens_in = '17' THEN
                                            txtTens_out := 'SEVENTEEN'
                                        ELSE
                                            IF txtTens_in = '18' THEN
                                                txtTens_out := 'EIGHTEEN'
                                            ELSE
                                                IF txtTens_in = '19' THEN
                                                    txtTens_out := 'NINETEEN'
        END
        ELSE BEGIN
            //If value between 20-99...
            IF txtTemp = '2' THEN
                txtTens_out := 'TWENTY '
            ELSE
                IF txtTemp = '3' THEN
                    txtTens_out := 'THIRTY '
                ELSE
                    IF txtTemp = '4' THEN
                        txtTens_out := 'FORTY '
                    ELSE
                        IF txtTemp = '5' THEN
                            txtTens_out := 'FIFTY '
                        ELSE
                            IF txtTemp = '6' THEN
                                txtTens_out := 'SIXTY '
                            ELSE
                                IF txtTemp = '7' THEN
                                    txtTens_out := 'SEVENTY '
                                ELSE
                                    IF txtTemp = '8' THEN
                                        txtTens_out := 'EIGHTY '
                                    ELSE
                                        IF txtTemp = '9' THEN
                                            txtTens_out := 'NINETY ';
            txtTens_out := txtTens_out + fnGetDigits(COPYSTR(txtTens_in, 2, 1));
        END;
    end;


    procedure fnGetDigits(txtDigits_in: Text[1]) txtDigits_out: Text[100]
    begin
        IF txtDigits_in = '1' THEN
            txtDigits_out := 'ONE';
        IF txtDigits_in = '2' THEN
            txtDigits_out := 'TWO';
        IF txtDigits_in = '3' THEN
            txtDigits_out := 'THREE';
        IF txtDigits_in = '4' THEN
            txtDigits_out := 'FOUR';
        IF txtDigits_in = '5' THEN
            txtDigits_out := 'FIVE';
        IF txtDigits_in = '6' THEN
            txtDigits_out := 'SIX';
        IF txtDigits_in = '7' THEN
            txtDigits_out := 'SEVEN';
        IF txtDigits_in = '8' THEN
            txtDigits_out := 'EIGHT';
        IF txtDigits_in = '9' THEN
            txtDigits_out := 'NINE';
    end;


    procedure fnGetHundreds(txtHundreds_in: Text[50]) txtHundreds_out: Text[100]
    var
        txtMyNumber: Text[100];
        txtResult: Text[250];
        txtTemp: Text[50];
    begin
        IF txtHundreds_in = '000' THEN EXIT;
        txtHundreds_in := '000' + txtHundreds_in;
        txtMyNumber := COPYSTR(txtHundreds_in, STRLEN(txtHundreds_in) - 2, 3);
        //Convert the hundreds place.
        txtTemp := COPYSTR(txtMyNumber, 1, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 1, 1);
            txtResult := fnGetDigits(txtTemp) + ' HUNDRED ';
        END;

        //Convert the tens and ones place.
        txtTemp := COPYSTR(txtMyNumber, 2, 1);
        IF txtTemp <> '0' THEN BEGIN
            txtTemp := COPYSTR(txtMyNumber, 2, 2);
            txtResult := txtResult + fnGetTens(txtTemp);
        END
        ELSE BEGIN
            txtTemp := COPYSTR(txtMyNumber, 3, 1);
            txtResult := txtResult + fnGetDigits(txtTemp);
        END;
        txtHundreds_out := txtResult;
    end;

    local procedure CalculateTotalWeight()
    var
        lRecPstdSalesInvLine: Record "Sales Invoice Line";
        lCodeTempHAWBNo: Code[50];
        lRecMAWBLine: Record "MAWB Line";
    begin
        lCodeTempHAWBNo := '';
        TotalWeight := 0;
        TotBoxes := 0;
        lRecPstdSalesInvLine.RESET;
        lRecPstdSalesInvLine.SETCURRENTKEY(lRecPstdSalesInvLine."HAWB No.");
        lRecPstdSalesInvLine.SETRANGE(lRecPstdSalesInvLine."Document No.", "Sales Invoice Header"."No.");
        IF lRecPstdSalesInvLine.FINDSET THEN
            REPEAT
                IF lCodeTempHAWBNo <> lRecPstdSalesInvLine."HAWB No." THEN BEGIN
                    TotalWeight += lRecPstdSalesInvLine."Split Weight";
                    lRecMAWBLine.RESET;
                    lRecMAWBLine.SETRANGE("MAWB No.", lRecPstdSalesInvLine."MAWB No.");
                    lRecMAWBLine.SETRANGE("HAWB No.", lRecPstdSalesInvLine."HAWB No.");
                    IF lRecMAWBLine.FINDFIRST THEN
                        TotBoxes += lRecMAWBLine.Quantity;
                    lCodeTempHAWBNo := lRecPstdSalesInvLine."HAWB No.";
                END;
            UNTIL lRecPstdSalesInvLine.NEXT = 0;
    end;
}

