codeunit 50035 "TIMS Manager."
{

    trigger OnRun()
    begin
    end;

    var
        QRCodeURL: Label 'http://209.97.184.149:8080/api/v1/QRcode/convert';
        SalesHeader: Record "Sales Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesLines: Record "Sales Line";
        Base64Mgt: Codeunit "Base64 Convert";
        Url: Text;
        Setup: Record "QR Setup.";
        CompanySet: Record "Company Information";
        RecRef: RecordRef;
        SalesCrHeader: Record "Sales Cr.Memo Header";
        HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        TempBlob: Codeunit "Temp Blob";
        // StringBuilder: DotNet StringBuilder;
        //   StringWriter: DotNet StringWriter; 
        GlobalNULL: Variant;
        //JsonTextWriter: DotNet JsonTextWriter;
        JSonSales: JsonObject;
        JsonSubSales: JsonObject;
        // JSonString: Text;
        /*  JsonFormatting: DotNet Formatting;
         JSonString: DotNet String; */
        Customer: Record Customer;
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        /*   HttpStatusCode: DotNet HttpStatusCode;
          ResponseHeaders: DotNet NameValueCollection;
          StringReader: DotNet StringReader;
          JsonTextReader: DotNet JsonTextReader; */
        LastColumn: Integer;
        InStr: InStream;
        NumRead: Integer;
        GetJSONObj: JsonObject;
        GetJsonSubObj: JsonObject;
        GetJSONArr: JsonArray;
        JsonMsgTxt: Text;
        bitmap: Text;
        MainGetJSONObj: JsonObject;

        /*   QRCodeProvider: DotNet BarcodeWriter;

          Encoder: DotNet EncodingOptions;

          QRCodeFormat: DotNet BarcodeFormat;
          ImageFormat: DotNet ImageFormat;
          //bitmap: DotNet Bitmap;
          bitmap: Text;
          BitMatrix: DotNet BitMatrix; */
        QRCodeInput: Text;
        FileNameTxt: Text;
        BmpFormat: Label '.bmp';
        QRCodeTxt: Text;
        QRCodeGenerator: Codeunit "Swiss QR Code Helper";
        CF: Char;
        LF: Char;
        TempBlob2: Codeunit "Temp Blob";
        FileManager: Codeunit "File Management";
        QRFileName: Text;
        JsonText: Text;
        JsonTxt: Text;
        HttpRequestMessageG: HttpRequestMessage;
        HttpClientG: HttpClient;
        HttpContentG: HttpContent;
        HttpHeadersG: HttpHeaders;
        HeadersG: HttpHeaders;

        HttpResponseMessageG: HttpResponseMessage;
        ResponseG: Text;


    procedure ProcessSalesDocument(SourceDoc: Variant)
    var
        AmountInc: Decimal;
        VATAmount: Decimal;
        txt: Text;
        ResponseJsonText: Text;
        //String: DotNet String;
        TempPostingExchField: Record "Data Exch. Field." temporary;
        i: Integer;
        Colmn: Integer;
        Item: Record Item;
        GLAccount: Record "G/L Account";
        SalesPost: Codeunit "Sales-Post";
        EventsAndSubs: Codeunit "Events And Subscribers";
        UnitPrice: Decimal;
        TaxRate: Integer;
        TestFile: File;
        FileNamex: Text;
        OutStreamObj: OutStream;
        UnitP: Decimal;
        VatAmt: Decimal;
        AmtInc: Decimal;
        TotalAmt: Decimal;
        AllowedChars: Label 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        InsStr: InStream;
        OutStr: OutStream;
        OutStreams: OutStream;
        TempBlob2: Codeunit "Temp Blob";
    begin
        CLEAR(Url);
        Setup.GET();
        CompanySet.GET();
        //CompanySet.TESTFIELD("VAT Registration No.");
        Setup.TESTFIELD("QR Location");
        Setup.TESTFIELD("Invoice Url");
        RecRef.GETTABLE(SourceDoc);
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Header":
                BEGIN
                    RecRef.SETTABLE(SalesHeader);
                END;
            DATABASE::"Sales Invoice Header":
                BEGIN
                    RecRef.SETTABLE(SalesInvHeader);
                    Customer.GET(SalesInvHeader."Sell-to Customer No.");
                    SalesInvHeader.CALCFIELDS("Amount Including VAT", "VAT Amount", Amount);
                    FileNameTxt := SalesInvHeader."No.";
                    FileNamex := Setup."QR Location" + 'Json.TXT';
                    IF NOT (SalesInvHeader."Invoice Number" = '') THEN
                        EXIT;

                    TempBlob.CreateOutStream(OutStreamObj);
                    TempBlob2.CreateOutStream(OutStreams);
                    //OutStreamObj.WriteText(FileNamex);// 
                    /*    IF EXISTS(FileNamex) THEN
                          ERASE(FileNamex);
                       TestFile.CREATE(FileNamex);
                        TestFile.CREATEOUTSTREAM(OutStreamObj); */  // B2BUPG handled above using streams


                    AmountInc := GetTotalSalesLine(SalesInvHeader."No.", FALSE);

                    IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                        VATAmount := ABS((SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount) / SalesInvHeader."Currency Factor")
                    END ELSE BEGIN
                        VATAmount := ABS((SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount));
                    END;
                    VATAmount := GetTotalVATSalesLine(SalesInvHeader."No.");
                    VATAmount := ROUND(((AmountInc * 0.16) / 1.16), 0.01, '=');
                    VatAmt := VATAmount;
                    AmtInc := AmountInc;
                    TotalAmt := GetTotalSalesLine(SalesInvHeader."No.", FALSE) + GetTotalSalesLine(SalesInvHeader."No.", TRUE);
                    // Initialize;
                    /*  JsonTextWriter.WriteStartObject;
                     JsonTextWriter.WritePropertyName('saleType');
                     JsonTextWriter.WriteValue('sales');
                     JsonTextWriter.WritePropertyName('cuin');
                     JsonTextWriter.WriteValue('');
                     JsonTextWriter.WritePropertyName('till');
                     JsonTextWriter.WriteValue(FORMAT(1));
                     JsonTextWriter.WritePropertyName('rctNo');
                     JsonTextWriter.WriteValue(DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars))); */
                    JSonSales.Add('saleType', 'sales');
                    JSonSales.Add('cuin', '');
                    JSonSales.Add('till', FORMAT(1));
                    JSonSales.Add('rctNo', DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars)));
                    /*  OutStreamObj.WRITETEXT('RctNo ' + FORMAT(DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars))));
                     OutStreamObj.WRITETEXT();
  */
                    /* JsonTextWriter.WritePropertyName('total');
                    JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('Paid');
                    JsonTextWriter.WriteValue(TotalAmt); */

                    JSonSales.Add('total', TotalAmt);
                    JSonSales.Add('Paid', TotalAmt);
                    /*  OutStreamObj.WRITETEXT('Total Amount ' + FORMAT(TotalAmt));
                     OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('Payment');
                    JsonTextWriter.WriteValue('Credit');
                    JsonTextWriter.WritePropertyName('CustomerPIN');
                    JsonTextWriter.WriteValue(Customer."VAT Registration No."); */
                    JSonSales.Add('Payment', 'Credit');
                    JSonSales.Add('CustomerPIN', Customer."VAT Registration No.");
                    /*  OutStreamObj.WRITETEXT('Customer PIN ' + Customer."VAT Registration No.");
                     OutStreamObj.WRITETEXT(); */

                    /*   JsonTextWriter.WritePropertyName('VAT_A_Net');
                      IF SalesInvHeader."Prices Including VAT" THEN
                          JsonTextWriter.WriteValue(AmtInc - VatAmt)
                      ELSE
                          JsonTextWriter.WriteValue(AmtInc - VatAmt); */
                    IF SalesInvHeader."Prices Including VAT" THEN
                        JSonSales.Add('VAT_A_Net', AmtInc - VatAmt)
                    ELSE
                        JSonSales.Add('VAT_A_Net', AmtInc - VatAmt);
                    /* OutStreamObj.WRITETEXT('VAT A Amount ' + FORMAT((AmtInc - VatAmt)));
                    OutStreamObj.WRITETEXT(); */

                    /* OutStreamObj.WRITETEXT('VAT Amount ' + FORMAT(VatAmt));
                    OutStreamObj.WRITETEXT(); */
                    /*  JsonTextWriter.WritePropertyName('VAT_A');
                     JsonTextWriter.WriteValue(VatAmt);*/
                    JSonSales.Add('VAT_A', VatAmt);
                    /* JsonTextWriter.WritePropertyName('VAT_E_Net'); 
                    TotalAmt := GetTotalSalesLine(SalesInvHeader."No.", TRUE);
                    JsonTextWriter.WriteValue(TotalAmt); */
                    TotalAmt := GetTotalSalesLine(SalesInvHeader."No.", TRUE);
                    JSonSales.Add('VAT_E_Net', TotalAmt);
                    /*  JsonTextWriter.WritePropertyName('VAT_E');
                     JsonTextWriter.WriteValue(0); */
                    JSonSales.Add('VAT_E', 0);
                    /* OutStreamObj.WRITETEXT('VAT E Amount ' + FORMAT(TotalAmt));
                    OutStreamObj.WRITETEXT();
 */

                    /*   JsonTextWriter.WritePropertyName('data');
                      JsonTextWriter.WriteStartArray; */
                    /* OutStreamObj.WRITETEXT('Start Lines');
                    OutStreamObj.WRITETEXT(); */

                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE("Document No.", SalesInvHeader."No.");
                    SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
                    IF SalesInvoiceLine.FINDSET() THEN
                        REPEAT
                            Clear(JsonSubSales);
                            /*  JsonTextWriter.WriteStartObject;
                         JsonTextWriter.WritePropertyName('productCode'); */
                            CASE SalesInvoiceLine.Type OF
                                SalesInvoiceLine.Type::"G/L Account":
                                    BEGIN
                                        GLAccount.GET(SalesInvoiceLine."No.");
                                        GLAccount.TESTFIELD("HS Code");
                                        // JsonTextWriter.WriteValue(GLAccount."HS Code");
                                        JsonSubSales.Add('productCode', GLAccount."HS Code");
                                        /*  OutStreamObj.WRITETEXT('HS Code ' + GLAccount."HS Code");
                                         OutStreamObj.WRITETEXT(); */

                                    END;
                                SalesInvoiceLine.Type::Item:
                                    BEGIN
                                        Item.GET(SalesInvoiceLine."No.");
                                        Item.TESTFIELD("HS Code");
                                        // JsonTextWriter.WriteValue(Item."HS Code");
                                        JsonSubSales.Add('productCode', Item."HS Code");
                                    END;
                            END;

                            /*   JsonTextWriter.WritePropertyName('productDesc');
                              JsonTextWriter.WriteValue(SalesInvoiceLine.Description);
                              JsonTextWriter.WritePropertyName('quantity');
                              JsonTextWriter.WriteValue(1); */
                            JsonSubSales.Add('productDesc', SalesInvoiceLine.Description);
                            JsonSubSales.Add('quantity', 1);
                            /*  JsonTextWriter.WritePropertyName('UnitPrice');
                            IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) / SalesInvHeader."Currency Factor"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100)) / SalesInvHeader."Currency Factor"
                            END ELSE BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := SalesInvoiceLine."Unit Price"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100));

                            END;
                            UnitPrice *= SalesInvoiceLine.Quantity;
                            UnitPrice := ROUND(UnitPrice, 1, '=');
                        UnitP := UnitPrice;
                            OutStreamObj.WRITETEXT('Unit Price ' + FORMAT(UnitPrice));
                            OutStreamObj.WRITETEXT();
                             JsonTextWriter.WriteValue(UnitPrice);
                            JSonSales.Add('UnitPrice', UnitPrice); */

                            IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) / SalesInvHeader."Currency Factor"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100)) / SalesInvHeader."Currency Factor"
                            END ELSE BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := SalesInvoiceLine."Unit Price"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100));

                            END;
                            //UnitPrice *= SalesInvoiceLine.Quantity;
                            UnitPrice := ROUND(UnitPrice, 1, '=');
                            //UnitP := UnitPrice;
                            /* OutStreamObj.WRITETEXT('Unit Price ' + FORMAT(UnitPrice));
                            OutStreamObj.WRITETEXT(); */

                            JsonSubSales.Add('UnitPrice', UnitPrice);
                            /* JsonTextWriter.WritePropertyName('discount');
                            JsonTextWriter.WriteValue(SalesInvoiceLine."Line Discount Amount"); */
                            JsonSubSales.Add('discount', SalesInvoiceLine."Line Discount Amount");
                            /*   JsonTextWriter.WritePropertyName('taxtype');
                              TaxRate := ROUND(SalesInvoiceLine."VAT %", 1, '=');
                              OutStreamObj.WRITETEXT('VAT ' + FORMAT(TaxRate));
                              OutStreamObj.WRITETEXT();
                              JsonTextWriter.WriteValue(TaxRate); */

                            TaxRate := ROUND(SalesInvoiceLine."VAT %", 1, '=');
                            /*  OutStreamObj.WRITETEXT('VAT ' + FORMAT(TaxRate));
                             OutStreamObj.WRITETEXT(); */
                            JsonSubSales.Add('taxtype', TaxRate);
                            //  JsonTextWriter.WriteEndObject;
                            GetJSONArr.Add(JsonSubSales);
                        UNTIL SalesInvoiceLine.NEXT() = 0;
                    JSonSales.Add('data', GetJSONArr);
                    /*  JSonSales.WriteTo(JsonMsgTxt);
                     Message(JsonMsgTxt); */

                    /*   JsonTextWriter.WriteEndArray;
                      JsonTextWriter.WriteEndObject;
                      JsonTextWriter.Flush; 
                     JSonString := GetJSon;
                    OutStreamObj.WRITETEXT();
                    TestFile.CLOSE;
                 OutStreamObj.WRITETEXT();*/
                    JSonSales.WriteTo(OutStreams);
                    /*       OutStreams.WriteText()
                          TestFile.CLOSE;
                          Display Json Structure
                          TempBlob.CreateInStream(InStr); // B2BUPG handled using streams
                           Tempblob2.CreateInStream(InStr);
                           FileNameTxt := 'Sales invoice' + SalesInvHeader."No." + '.Json';
                           DownloadFromStream(InStr, '', '', '', FileNameTxt); */// B2BUPG handled using streams


                    IF NOT CallWebService(Setup."Invoice Url", 'POST') THEN
                        EXIT;
                    WHILE NOT InStr.EOS() DO BEGIN
                        NumRead := InStr.READTEXT(txt, 100);
                        IF NumRead > 0 THEN
                            ResponseJsonText += txt;
                    END;
                    //  String := ResponseJsonText;
                    TempPostingExchField.DELETEALL;
                    CLEAR(Colmn);
                    ReadJson(ResponseG, TempPostingExchField);

                    IF TempPostingExchField.FINDSET THEN BEGIN
                        REPEAT
                            CASE TempPostingExchField."Node ID" OF
                                'CUIN':
                                    BEGIN
                                        SalesInvHeader."Invoice Number" := TempPostingExchField.Value;
                                    END;
                                'QRCode':
                                    BEGIN
                                        SalesInvHeader.CALCFIELDS("QR Code");
                                        IF SalesInvHeader."QR Code".HASVALUE THEN
                                            CLEAR(SalesInvHeader."QR Code");
                                        SalesInvHeader."Link Text" := TempPostingExchField.Value;
                                        SalesInvHeader."TIMS Time" := CURRENTDATETIME;
                                        QRCodeInput := TempPostingExchField.Value;
                                        IF QRCodeInput <> '' THEN BEGIN

                                            /* GetQRCodeProvider();
                                           CLEAR(TempBlob2);
                                            FileManager.BLOBImportFromServerFile(TempBlob2, QRCodeFileName);
                                            SalesInvHeader."QR Code" := TempBlob2.Blob; */

                                            QRCodeTxt := SalesInvHeader."No.";
                                            TempBlob2.CreateInStream(InsStr);
                                            QRCodeGenerator.GenerateQRCodeImage(QRCodeTxt, TempBlob2);
                                            SalesInvHeader."QR Code".CreateOutStream(OutStr);
                                            CopyStream(OutStr, InsStr);  //Handled using streams 
                                        END;
                                    END;
                                'CUSN':
                                    BEGIN
                                        SalesInvHeader."Deivice Code" := TempPostingExchField.Value;
                                    END;

                            END;
                        UNTIL TempPostingExchField.NEXT = 0;
                        IF EventsAndSubs.ModifySalesInv(SalesInvHeader) THEN
                            /*  IF EXISTS(QRFileName) THEN
                                  ERASE(QRFileName); */

                        COMMIT;
                    END;
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN

                    RecRef.SETTABLE(SalesCrHeader);
                    SalesCrHeader.TESTFIELD(SalesCrHeader."Applies-to Doc. Type", SalesCrHeader."Applies-to Doc. Type"::Invoice);
                    SalesCrHeader.TESTFIELD(SalesCrHeader."Applies-to Doc. No.");
                    SalesInvHeader.GET(SalesCrHeader."Applies-to Doc. No.");
                    SalesInvHeader.TESTFIELD("Invoice Number");
                    Customer.GET(SalesCrHeader."Sell-to Customer No.");
                    SalesCrHeader.CALCFIELDS("Amount Including VAT", Amount);
                    FileNameTxt := SalesCrHeader."No.";
                    FileNamex := Setup."QR Location" + 'Json.TXT';
                    IF NOT (SalesCrHeader."Invoice Number" = '') THEN
                        EXIT;

                    TempBlob.CreateOutStream(OutStreamObj);
                    TempBlob2.CreateOutStream(OutStreams);
                    /*  OutStreamObj.WriteText(FileNamex);
                      IF EXISTS(FileNamex) THEN
                          ERASE(FileNamex);
                      TestFile.CREATE(FileNamex);
                      TestFile.CREATEOUTSTREAM(OutStreamObj); */ // B2BUPG handled above using streams


                    AmountInc := GetTotalSalesCreditLine(SalesCrHeader."No.", GetTotalVATSalesCreditLine(SalesCrHeader."No.") = 0);
                    IF NOT (GetTotalVATSalesCreditLine(SalesCrHeader."No.") = 0) THEN
                        VATAmount := ROUND(((AmountInc * 0.16) / 1.16), 0.01, '=');
                    VatAmt := VATAmount;
                    AmtInc := AmountInc;
                    TotalAmt := GetTotalSalesCreditLine(SalesCrHeader."No.", FALSE) + GetTotalSalesCreditLine(SalesCrHeader."No.", TRUE);
                    /*  Initialize;
                     JsonTextWriter.WriteStartObject;
                     JsonTextWriter.WritePropertyName('saleType');

                    JsonTextWriter.WriteValue('refund');  */
                    JSonSales.Add('saleType', 'refund');
                    /* OutStreamObj.WRITETEXT('refund');
                    OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('cuin');
                    JsonTextWriter.WriteValue(SalesInvHeader."Invoice Number"); */
                    JSonSales.Add('cuin', SalesInvHeader."Invoice Number");
                    /*  OutStreamObj.WRITETEXT('cuin ' + SalesInvHeader."Invoice Number");
                     OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('till');
                    JsonTextWriter.WriteValue(FORMAT(1));
                    JsonTextWriter.WritePropertyName('rctNo');
                    JsonTextWriter.WriteValue(DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars))); */
                    JSonSales.Add('till', FORMAT(1));
                    JSonSales.Add('rctNo', DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars)));
                    /* OutStreamObj.WRITETEXT('RctNo ' + FORMAT(DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars))));
                    OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('total');
                    JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('Paid');
                    JsonTextWriter.WriteValue(TotalAmt); */
                    JSonSales.Add('total', TotalAmt);
                    JSonSales.Add('Paid', TotalAmt);
                    /* OutStreamObj.WRITETEXT('Total Amount ' + FORMAT(TotalAmt));
                    OutStreamObj.WRITETEXT(); */

                    /*  JsonTextWriter.WritePropertyName('Payment');
                     JsonTextWriter.WriteValue('Credit');
                     JsonTextWriter.WritePropertyName('CustomerPIN');
                     JsonTextWriter.WriteValue(Customer."VAT Registration No."); */
                    JSonSales.Add('Payment', 'Credit');
                    JSonSales.Add('CustomerPIN', Customer."VAT Registration No.");
                    /*  OutStreamObj.WRITETEXT('Customer PIN ' + Customer."VAT Registration No.");
                     OutStreamObj.WRITETEXT(); */

                    /*  JsonTextWriter.WritePropertyName('VAT_A_Net');
                     IF SalesCrHeader."Prices Including VAT" THEN
                         JsonTextWriter.WriteValue(AmtInc - VatAmt)
                     ELSE
                         JsonTextWriter.WriteValue(AmtInc - VatAmt);                 
  */
                    IF SalesCrHeader."Prices Including VAT" THEN
                        JSonSales.Add('VAT_A_Net', AmtInc - VatAmt)
                    ELSE
                        JSonSales.Add('VAT_A_Net', AmtInc - VatAmt);
                    /*  OutStreamObj.WRITETEXT('VAT A Amount ' + FORMAT((AmtInc - VatAmt)));
                     OutStreamObj.WRITETEXT(); */

                    /* OutStreamObj.WRITETEXT('VAT Amount ' + FORMAT(VatAmt));
                    OutStreamObj.WRITETEXT(); */
                    /*  JsonTextWriter.WritePropertyName('VAT_A');
                     JsonTextWriter.WriteValue(VatAmt); */
                    JSonSales.Add('VAT_A', VatAmt);
                    /*  JsonTextWriter.WritePropertyName('VAT_E_Net');
                     TotalAmt := GetTotalSalesCreditLine(SalesCrHeader."No.", TRUE);
                     JsonTextWriter.WriteValue(TotalAmt); */

                    TotalAmt := GetTotalSalesCreditLine(SalesCrHeader."No.", TRUE);
                    JSonSales.Add('VAT_E_Net', TotalAmt);
                    /*  JsonTextWriter.WritePropertyName('VAT_E');
                     JsonTextWriter.WriteValue(0); */
                    JSonSales.Add('VAT_E', 0);
                    /* OutStreamObj.WRITETEXT('VAT E Amount ' + FORMAT(TotalAmt));
                    OutStreamObj.WRITETEXT(); */


                    /* JsonTextWriter.WritePropertyName('data');
                    JsonTextWriter.WriteStartArray; */
                    /*  OutStreamObj.WRITETEXT('Start Lines');
                     OutStreamObj.WRITETEXT(); */

                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", SalesCrHeader."No.");
                    SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
                    IF SalesCrMemoLine.FINDSET() THEN
                        REPEAT
                            Clear(JsonSubSales);
                            /*   JsonTextWriter.WriteStartObject;
                         JsonTextWriter.WritePropertyName('productCode'); */
                            CASE SalesCrMemoLine.Type OF
                                SalesCrMemoLine.Type::"G/L Account":
                                    BEGIN
                                        GLAccount.GET(SalesCrMemoLine."No.");
                                        GLAccount.TESTFIELD("HS Code");
                                        //JsonTextWriter.WriteValue(GLAccount."HS Code");
                                        JsonSubSales.Add('productCode', GLAccount."HS Code");
                                        /*   OutStreamObj.WRITETEXT('HS Code ' + GLAccount."HS Code");
                                          OutStreamObj.WRITETEXT(); */

                                    END;
                                SalesCrMemoLine.Type::Item:
                                    BEGIN
                                        Item.GET(SalesCrMemoLine."No.");
                                        Item.TESTFIELD("HS Code");
                                        //JsonTextWriter.WriteValue(Item."HS Code");
                                        JsonSubSales.Add('productCode', Item."HS Code");
                                    END;
                            END;

                            /*   JsonTextWriter.WritePropertyName('productDesc');
                              JsonTextWriter.WriteValue(SalesCrMemoLine.Description);
                              JsonTextWriter.WritePropertyName('quantity');
                              JsonTextWriter.WriteValue(1); */
                            JsonSubSales.Add('productDesc', SalesCrMemoLine.Description);
                            JsonSubSales.Add('quantity', 1);
                            // JsonTextWriter.WritePropertyName('UnitPrice');
                            IF SalesCrHeader."Currency Factor" <> 0 THEN BEGIN
                                IF SalesCrHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) / SalesCrHeader."Currency Factor"
                                ELSE
                                    UnitPrice := ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100)) / SalesCrHeader."Currency Factor"
                            END ELSE BEGIN
                                IF SalesCrHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity)
                                ELSE
                                    UnitPrice := ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100));

                            END;
                            // UnitPrice *= SalesCrMemoLine.Quantity;
                            UnitPrice := ROUND(UnitPrice, 1, '=');
                            //UnitP := UnitPrice;
                            /*  OutStreamObj.WRITETEXT('Unit Price ' + FORMAT(UnitPrice));
                             OutStreamObj.WRITETEXT(); */
                            // JsonTextWriter.WriteValue(UnitPrice);
                            JsonSubSales.Add('UnitPrice', UnitPrice);
                            /*  JsonTextWriter.WritePropertyName('discount');
                             JsonTextWriter.WriteValue(SalesCrMemoLine."Line Discount Amount"); */
                            JsonSubSales.Add('discount', SalesCrMemoLine."Line Discount Amount");
                            //JsonTextWriter.WritePropertyName('taxtype');
                            TaxRate := ROUND(SalesCrMemoLine."VAT %", 1, '=');
                            /*  OutStreamObj.WRITETEXT('VAT ' + FORMAT(TaxRate));
                             OutStreamObj.WRITETEXT(); */
                            //JsonTextWriter.WriteValue(TaxRate);

                            JsonSubSales.Add('taxtype', TaxRate);
                            //  JsonTextWriter.WriteEndObject;
                            GetJSONArr.Add(JsonSubSales);
                        UNTIL SalesCrMemoLine.NEXT() = 0;
                    JSonSales.Add('data', GetJSONArr);
                    /* JSonSales.WriteTo(JsonMsgTxt);
                    Message(JsonMsgTxt); 
                       JsonTextWriter.WriteEndArray;
                      JsonTextWriter.WriteEndObject;
                      JsonTextWriter.Flush; 
                     JSonString := GetJSon;
                    OutStreamObj.WRITETEXT();
                      TestFile.CLOSE;
                    OutStreamObj.WRITETEXT();*/
                    JSonSales.WriteTo(OutStreams);
                    /*   OutStreams.WriteText()
                    TestFile.CLOSE;
                       Display Json Structure
                       TempBlob.CreateInStream(InStr); // B2BUPG handled using streams
                         Tempblob2.CreateInStream(InStr);
                        FileNameTxt := 'Sales Credit Memo ' + SalesCrHeader."No." + '.Json';
                        DownloadFromStream(InStr, '', '', '', FileNameTxt); */// B2BUPG handled using streams

                    IF NOT CallWebService(Setup."Invoice Url", 'POST') THEN
                        EXIT;
                    WHILE NOT InStr.EOS() DO BEGIN
                        NumRead := InStr.READTEXT(txt, 100);
                        IF NumRead > 0 THEN
                            ResponseJsonText += txt;
                    END;
                    //String := ResponseJsonText;
                    TempPostingExchField.DELETEALL;
                    CLEAR(Colmn);
                    ReadJson(ResponseG, TempPostingExchField);

                    IF TempPostingExchField.FINDSET THEN BEGIN
                        REPEAT
                            CASE TempPostingExchField."Node ID" OF
                                'CUIN':
                                    BEGIN
                                        SalesCrHeader."Invoice Number" := TempPostingExchField.Value;
                                    END;
                                'QRCode':
                                    BEGIN
                                        SalesCrHeader.CALCFIELDS("QR Code");
                                        IF SalesCrHeader."QR Code".HASVALUE THEN
                                            CLEAR(SalesCrHeader."QR Code");
                                        SalesCrHeader.Link := TempPostingExchField.Value;
                                        SalesCrHeader."TIMS Time" := CURRENTDATETIME;
                                        QRCodeInput := TempPostingExchField.Value;
                                        IF QRCodeInput <> '' THEN BEGIN
                                            /* GetQRCodeProvider();
                                            CLEAR(TempBlob2);
                                               FileManager.BLOBImportFromServerFile(TempBlob2, QRCodeFileName);
                                              SalesCrHeader."QR Code" := TempBlob2;  */

                                            QRCodeTxt := SalesCrHeader."No.";
                                            TempBlob2.CreateInStream(InsStr);
                                            QRCodeGenerator.GenerateQRCodeImage(QRCodeTxt, TempBlob2);
                                            SalesCrHeader."QR Code".CreateOutStream(OutStr);
                                            CopyStream(OutStr, InsStr);  //Handled using streams 
                                        END;
                                    END;
                                'CUSN':
                                    BEGIN
                                        SalesCrHeader."Device Code" := TempPostingExchField.Value;
                                    END;
                            END;
                        UNTIL TempPostingExchField.NEXT = 0;
                        IF EventsAndSubs.ModifySalesCreditMemo(SalesCrHeader) THEN
                            /* IF EXISTS(QRFileName) THEN
                                ERASE(QRFileName); */

                        COMMIT;
                    END;

                END;
        END;
    end;
    //Naveen B2bUPG-->>
    local procedure CallWebService(URL: Text; Method: Text): Boolean
    begin
        /* HttpWebRequestMgt.Initialize(URL);
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod(Method);
        HttpWebRequestMgt.SetReturnType('application/json');
        HttpWebRequestMgt.SetContentType('application/json');
        IF NOT (Method IN ['GET']) THEN
            HttpWebRequestMgt.AddBodyAsText(JSonString);
        // >> BT
        MESSAGE(FORMAT(JSonString));
        // << BT
        // TempBlob.INIT;
        TempBlob.CREATEINSTREAM(InStr);
        EXIT(HttpWebRequestMgt.GetResponse(InStr, HttpStatusCode, ResponseHeaders)); */

        JSonSales.WriteTo(JsonTxt);
        Clear(HttpRequestMessageG);
        Clear(HttpClientG);
        Clear(HttpContentG);
        Clear(HttpHeadersG);
        Clear(HeadersG);
        Clear(HttpResponseMessageG);
        HttpRequestMessageG.SetRequestUri(URL);
        HttpRequestMessageG.Method := 'POST';
        HeadersG := HttpClientG.DefaultRequestHeaders;
        HttpClientG.DefaultRequestHeaders.Clear();
        HttpContentG.GetHeaders(HttpHeadersG);
        HttpHeadersG.Clear();
        HttpHeadersG.Add('Content-Type', 'application/json');
        HttpContentG.WriteFrom(JsonTxt);//Attcah Body                                      
        HttpRequestMessageG.Content := HttpContentG;
        HttpClientG.Send(HttpRequestMessageG, HttpResponseMessageG);
        if not HttpResponseMessageG.IsSuccessStatusCode then
            exit(false);
        HttpResponseMessageG.Content().ReadAs(ResponseG);
    end;
    //Naveen B2bUPG--<<


    local procedure SalesLinesToJson()
    begin
    end;

    local procedure AddSalesLineToJson()
    begin
    end;

    /* local procedure Initialize()
    begin
        StringBuilder := StringBuilder.StringBuilder;
        StringWriter := StringWriter.StringWriter(StringBuilder);
        JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
        JsonTextWriter.Formatting := JsonFormatting.Indented;

        CLEAR(GlobalNULL);
    end;

    local procedure GetJSon() JSon: Text
    begin
        JSon := StringBuilder.ToString;
        Initialize;
    end; */       //we are not using dotnet variables no need of initialize

    local procedure ReadJson(var String: Text; var TempPostingExchField: Record "Data Exch. Field." temporary)
    var
        /* JsonToken: DotNet JsonToken;
        PropertyName: Text;
        JsonArray: DotNet JsonArrayAttribute;
        JsonObject: DotNet JsonObjectAttribute;
        PrefixArray: DotNet Array;
        PrefixString: DotNet String;
        InArray: array[300] of Boolean;
        ColumnNo: Integer;
        PropertyName2: Text;
        PrefixArray := PrefixArray.CreateInstance(GETDOTNETTYPE(String), 250);
        StringReader := StringReader.StringReader(String);
        JsonTextReader := JsonTextReader.JsonTextReader(StringReader);
        WHILE JsonTextReader.Read DO
            CASE TRUE OF
                JsonTextReader.TokenType.CompareTo(JsonToken.StartObject) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.StartArray) = 0:
                    BEGIN
                        InArray[JsonTextReader.Depth + 1] := TRUE;
                        ColumnNo := 0;
                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.StartConstructor) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.PropertyName) = 0:
                    BEGIN
                        PrefixArray.SetValue(JsonTextReader.Value, JsonTextReader.Depth - 1);
                        PropertyName2 := FORMAT(JsonTextReader.Value, 0, 9);
                        IF JsonTextReader.Depth > 1 THEN BEGIN
                            PrefixString := PrefixString.Join('.', PrefixArray, 0, JsonTextReader.Depth - 1);
                            IF PrefixString.Length > 0 THEN
                                PropertyName := FORMAT(JsonTextReader.Value, 0, 9)
                            ELSE
                                PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                        END ELSE
                            PropertyName := FORMAT(JsonTextReader.Value, 0, 9);
                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.String) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Integer) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Float) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Boolean) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Date) = 0,
                JsonTextReader.TokenType.CompareTo(JsonToken.Bytes) = 0:
                    BEGIN
                        TempPostingExchField."Data Exch. No." := JsonTextReader.Depth;
                        TempPostingExchField."Line No." := JsonTextReader.LineNumber;
                        TempPostingExchField."Column No." := ColumnNo;
                        TempPostingExchField."Node ID" := PropertyName;
                        TempPostingExchField.Value := FORMAT(JsonTextReader.Value, 0, 9);
                        TempPostingExchField."Data Exch. Line Def Code" := JsonTextReader.TokenType.ToString;
                        //TempPostingExchField."Node ID 2" := PropertyName2;
                        TempPostingExchField.INSERT;
                        LastColumn := ColumnNo;
                    END;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndConstructor) = 0:
                    ;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndArray) = 0:
                    InArray[JsonTextReader.Depth + 1] := FALSE;
                JsonTextReader.TokenType.CompareTo(JsonToken.EndObject) = 0:
                    IF JsonTextReader.Depth > 0 THEN
                        IF InArray[JsonTextReader.Depth] THEN ColumnNo += 1;
            END; */


        JObject: JsonObject;
        JToken: JsonToken;
        ResponseCodeVar: Code[20];
        MessageVar: Text[50];
        TSINVar: Code[20];
        CUSNVar: Code[50];
        CUINVar: Code[50];
        QRCodeVar: Text[250];
        DtStmpVar: Text[20];
        ResponseL: Text[350];
    begin
        JObject.ReadFrom(String);
        if JObject.Get('ResponseCode', JToken) then
            if JToken.IsValue then
                ResponseCodeVar := JToken.AsValue().AsCode();
        Clear(JToken);
        if JObject.Get('Message', JToken) then
            if JToken.IsValue then
                MessageVar := JToken.AsValue().AsText();
        Clear(JToken);
        if JObject.Get('TSIN', JToken) then
            if JToken.IsValue then
                TSINVar := JToken.AsValue().AsCode();
        Clear(JToken);
        if JObject.Get('CUSN', JToken) then
            if JToken.IsValue then
                CUSNVar := JToken.AsValue().AsCode();
        Clear(JToken);
        if JObject.Get('CUIN', JToken) then
            if JToken.IsValue then
                CUINVar := JToken.AsValue().AsCode();
        Clear(JToken);
        if JObject.Get('QRCode', JToken) then
            if JToken.IsValue then
                QRCodeVar := JToken.AsValue().AsText();
        Clear(JToken);
        if JObject.Get('dtStmp', JToken) then
            if JToken.IsValue then
                DtStmpVar := JToken.AsValue().AsText();
        Clear(JToken);
    end;


    /* procedure GetQRCodeProvider()

    begin
     Encoder := Encoder.EncodingOptions();
        Encoder.Height := 330;
        Encoder.Width := 330;

        QRCodeProvider := QRCodeProvider.BarcodeWriter;
        QRCodeProvider.Format := QRCodeFormat.QR_CODE;
        QRCodeProvider.Options := Encoder;

        BitMatrix := QRCodeProvider.Encode(QRCodeInput);
        bitmap := QRCodeProvider.Write(BitMatrix);
        QRFileName := MoveToPath(FileNameTxt); 

    end; */

    /* procedure MoveToPath(SourceFileName: Text) DestinationFileName: Text
    begin
        DestinationFileName := Setup."QR Location" + SourceFileName + BmpFormat;

        IF NOT ISSERVICETIER THEN
            // IF EXISTS(DestinationFileName) THEN
            //     ERASE(DestinationFileName);
        bitmap.Save(DestinationFileName, ImageFormat.Bmp);
        QRCodeFileName := DestinationFileName;
    end; */

    local procedure GetTotalSalesLine(DocNo: Code[20]; Zero: Boolean): Decimal
    var
        SalesInvLine: Record 113;
        TotalPrice: Decimal;
    begin
        CLEAR(TotalPrice);
        SalesInvLine.RESET;
        SalesInvLine.SETCURRENTKEY(SalesInvLine."Line No.");
        SalesInvLine.ASCENDING(FALSE);
        SalesInvLine.SETRANGE("Document No.", DocNo);
        SalesInvLine.SETFILTER("No.", '<>%1', '');
        IF Zero THEN
            SalesInvLine.SETFILTER(SalesInvLine."VAT %", '%1', 0)
        ELSE
            SalesInvLine.SETFILTER(SalesInvLine."VAT %", '<>%1', 0);

        IF SalesInvLine.FINDSET THEN
            REPEAT
                //Here
                IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                    IF SalesInvHeader."Prices Including VAT" THEN
                        TotalPrice += (SalesInvLine."Unit Price" * SalesInvLine.Quantity) / SalesInvHeader."Currency Factor"
                    ELSE
                        TotalPrice += ((SalesInvLine."Unit Price" * SalesInvLine.Quantity) * ((100 + SalesInvLine."VAT %") / 100)) / SalesInvHeader."Currency Factor"
                END ELSE BEGIN
                    IF SalesInvHeader."Prices Including VAT" THEN
                        TotalPrice += SalesInvLine."Unit Price" * SalesInvLine.Quantity
                    ELSE
                        TotalPrice += ((SalesInvLine."Unit Price" * SalesInvLine.Quantity) * ((100 + SalesInvLine."VAT %") / 100));

                END;

                TotalPrice := ROUND(TotalPrice, 1, '=');

            //Here
            UNTIL SalesInvLine.NEXT = 0;

        EXIT(TotalPrice);
    end;

    local procedure GetTotalVATSalesLine(DocNo: Code[20]): Decimal
    var
        SalesInvLine: Record 113;
        TotalPrice: Decimal;
    begin
        CLEAR(TotalPrice);
        SalesInvLine.RESET;
        SalesInvLine.SETRANGE("Document No.", DocNo);
        SalesInvLine.SETFILTER("No.", '<>%1', '');
        SalesInvLine.SETFILTER(SalesInvLine."VAT %", '<>%1', 0);

        IF SalesInvLine.FINDSET THEN
            REPEAT
                //Here
                IF SalesInvLine."VAT Amount" = 0 THEN BEGIN
                    IF SalesInvHeader."Currency Factor" <> 0 THEN
                        TotalPrice += ((SalesInvLine."Unit Price" * SalesInvLine.Quantity) * ((SalesInvLine."VAT %") / 100)) / SalesInvHeader."Currency Factor"

                    ELSE
                        TotalPrice += ((SalesInvLine."Unit Price" * SalesInvLine.Quantity) * ((SalesInvLine."VAT %") / 100));

                END ELSE BEGIN
                    IF SalesInvHeader."Currency Factor" <> 0 THEN
                        TotalPrice += SalesInvLine."VAT Amount" / SalesInvHeader."Currency Factor"
                    ELSE
                        TotalPrice += SalesInvLine."VAT Amount";
                END;

                TotalPrice := ROUND(TotalPrice, 1, '=');
            //Here
            UNTIL SalesInvLine.NEXT = 0;
        EXIT(TotalPrice);
    end;

    local procedure GetTotalSalesCreditLine(DocNo: Code[20]; Zero: Boolean): Decimal
    var
        TotalPrice: Decimal;
        SalesCrMemoLine: Record 115;
    begin
        CLEAR(TotalPrice);
        SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETRANGE("Document No.", DocNo);
        SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
        IF Zero THEN
            SalesCrMemoLine.SETFILTER("VAT %", '%1', 0)
        ELSE
            SalesCrMemoLine.SETFILTER("VAT %", '<>%1', 0);

        IF SalesCrMemoLine.FINDSET THEN
            REPEAT
                //Here
                IF SalesCrHeader."Currency Factor" <> 0 THEN BEGIN
                    IF SalesCrHeader."Prices Including VAT" THEN
                        TotalPrice += (SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) / SalesCrHeader."Currency Factor"
                    ELSE
                        TotalPrice += ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100)) / SalesCrHeader."Currency Factor";
                END ELSE BEGIN
                    IF SalesCrHeader."Prices Including VAT" THEN
                        TotalPrice += SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity
                    ELSE
                        TotalPrice += ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100));

                END;

                TotalPrice := ROUND(TotalPrice, 1, '=');
            //TotalPrice := Round(TotalPrice,0.01);

            //Here
            UNTIL SalesCrMemoLine.NEXT = 0;
        EXIT(TotalPrice);
    end;

    local procedure GetTotalVATSalesCreditLine(DocNo: Code[20]): Decimal
    var
        SalesCrMemoLine: Record 115;
        TotalPrice: Decimal;
    begin
        CLEAR(TotalPrice);
        SalesCrMemoLine.RESET;
        SalesCrMemoLine.SETRANGE("Document No.", DocNo);
        SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
        SalesCrMemoLine.SETFILTER("VAT %", '<>%1', 0);

        IF SalesCrMemoLine.FINDSET THEN
            REPEAT
                //Here
                IF SalesCrMemoLine."VAT %" = 0 THEN BEGIN
                    IF SalesCrHeader."Currency Factor" <> 0 THEN
                        TotalPrice += (SalesCrMemoLine."Unit Price" * ((SalesCrMemoLine."VAT %") / 100)) / SalesCrHeader."Currency Factor"

                    ELSE
                        TotalPrice += (SalesCrMemoLine."Unit Price" * ((SalesCrMemoLine."VAT %") / 100));

                END ELSE BEGIN
                    IF SalesInvHeader."Currency Factor" <> 0 THEN
                        TotalPrice += (SalesCrMemoLine."Unit Price" * ((SalesCrMemoLine."VAT %") / 100)) / SalesCrHeader."Currency Factor"
                    ELSE
                        TotalPrice += (SalesCrMemoLine."Unit Price" * ((SalesCrMemoLine."VAT %") / 100));
                END;
                //TotalPrice := ROUND(TotalPrice,1,'=');
                TotalPrice := ROUND(TotalPrice, 0.01);
            //Here
            UNTIL SalesCrMemoLine.NEXT = 0;
        EXIT(TotalPrice);
    end;


    procedure GetJSONData(SourceDoc: Variant)
    var
        AmountInc: Decimal;
        VATAmount: Decimal;
        txt: Text;
        ResponseJsonText: Text;
        //  String: DotNet String;
        TempPostingExchField: Record 50081 temporary;
        i: Integer;
        Colmn: Integer;
        Item: Record 27;
        GLAccount: Record 15;
        SalesPost: Codeunit 80;
        UnitPrice: Decimal;
        TaxRate: Integer;
        TestFile: File;
        FileNamex: Text;
        OutStreamObj: OutStream;
        OutStreams: OutStream;
        UnitP: Decimal;
        VatAmt: Decimal;
        AmtInc: Decimal;
        TotalAmt: Decimal;
        AllowedChars: Label 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        TempBlob, Tempblob2 : Codeunit "Temp Blob";
    begin
        //Replicated the Feature to get the JSON Data for the both Invoice and Credit Memo
        CLEAR(Url);
        Setup.GET();
        CompanySet.GET();
        Setup.TESTFIELD("QR Location");
        Setup.TESTFIELD("Invoice Url");
        RecRef.GETTABLE(SourceDoc);
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Header":
                BEGIN
                    RecRef.SETTABLE(SalesHeader);
                END;
            DATABASE::"Sales Invoice Header":
                BEGIN
                    RecRef.SETTABLE(SalesInvHeader);
                    Customer.GET(SalesInvHeader."Sell-to Customer No.");
                    SalesInvHeader.CALCFIELDS("Amount Including VAT", "VAT Amount", Amount);
                    FileNameTxt := SalesInvHeader."No.";
                    FileNamex := Setup."QR Location" + 'Json.TXT';
                    /*IF NOT( SalesInvHeader."Invo
                      EXIT;*///BT
                    //Naveen B2BUPG---->>>>
                    TempBlob.CreateOutStream(OutStreamObj);
                    Tempblob2.CreateOutStream(OutStreams);
                    // OutStreamObj.WriteText(FileNamex);
                    /* IF EXISTS(FileNamex) THEN
                        ERASE(FileNamex);
                    TestFile.CREATE(FileNamex);
                    TestFile.CREATEOUTSTREAM(OutStreamObj); */ // B2BUPG handled above using streams

                    AmountInc := GetTotalSalesLine(SalesInvHeader."No.", FALSE);
                    IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                        VATAmount := ABS((SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount) / SalesInvHeader."Currency Factor")
                    END ELSE BEGIN
                        VATAmount := ABS((SalesInvHeader."Amount Including VAT" - SalesInvHeader.Amount));
                    END;
                    VATAmount := GetTotalVATSalesLine(SalesInvHeader."No.");
                    VATAmount := ROUND(((AmountInc * 0.16) / 1.16), 0.01, '=');
                    VatAmt := VATAmount;
                    AmtInc := AmountInc;
                    TotalAmt := GetTotalSalesLine(SalesInvHeader."No.", FALSE) + GetTotalSalesLine(SalesInvHeader."No.", TRUE);
                    // Initialize;
                    /* JsonTextWriter.WriteStartObject;
                    JsonTextWriter.WritePropertyName('saleType');
                    JsonTextWriter.WriteValue('sales');
                    JsonTextWriter.WritePropertyName('cuin');
                    JsonTextWriter.WriteValue('');
                    JsonTextWriter.WritePropertyName('till');
                    JsonTextWriter.WriteValue(FORMAT(1));
                    JsonTextWriter.WritePropertyName('rctNo');
                    JsonTextWriter.WriteValue(DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars))); */

                    GetJSONObj.Add('saleType', 'sales');
                    GetJSONObj.Add('cuin', '');
                    GetJSONObj.Add('till', 1);
                    GetJSONObj.Add('rctNo', DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars)));

                    /*  OutStreamObj.WRITETEXT('RctNo ' + FORMAT(DELCHR(SalesInvHeader."No.", '=', DELCHR(SalesInvHeader."No.", '=', AllowedChars))));
                     OutStreamObj.WRITETEXT(); */
                    /* JsonTextWriter.WritePropertyName('total');
                    JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('Paid');
                    JsonTextWriter.WriteValue(TotalAmt); */

                    GetJSONObj.Add('total', TotalAmt);
                    GetJSONObj.Add('Paid', TotalAmt);

                    /*  OutStreamObj.WRITETEXT('Total Amount ' + FORMAT(TotalAmt));
                     OutStreamObj.WRITETEXT(); 

                     JsonTextWriter.WritePropertyName('Payment');
                    JsonTextWriter.WriteValue('Credit');
                    JsonTextWriter.WritePropertyName('CustomerPIN');
                    JsonTextWriter.WriteValue(Customer."VAT Registration No."); */

                    GetJSONObj.Add('Payment', 'Credit');
                    GetJSONObj.Add('CustomerPIN', Customer."VAT Registration No.");

                    /*   OutStreamObj.WRITETEXT('Customer PIN ' + Customer."VAT Registration No.");
                      OutStreamObj.WRITETEXT();
   
                     JsonTextWriter.WritePropertyName('VAT_A_Net');
                    IF SalesInvHeader."Prices Including VAT" THEN
                        JsonTextWriter.WriteValue(AmtInc - VatAmt)
                    ELSE
                        JsonTextWriter.WriteValue(AmtInc - VatAmt); */

                    IF SalesInvHeader."Prices Including VAT" THEN
                        GetJSONObj.Add('VAT_A_Net', AmtInc - VatAmt)
                    ELSE
                        GetJSONObj.Add('VAT_A_Net', AmtInc - VatAmt);

                    /* OutStreamObj.WRITETEXT('VAT A Amount ' + FORMAT((AmtInc - VatAmt)));
                    OutStreamObj.WRITETEXT();

                    OutStreamObj.WRITETEXT('VAT Amount ' + FORMAT(VatAmt));
                    OutStreamObj.WRITETEXT(); */
                    /*  JsonTextWriter.WritePropertyName('VAT_A');
                     JsonTextWriter.WriteValue(VatAmt);
                     JsonTextWriter.WritePropertyName('VAT_E_Net'); */

                    GetJSONObj.Add('VAT_A', VatAmt);

                    TotalAmt := GetTotalSalesLine(SalesInvHeader."No.", TRUE);
                    /* JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('VAT_E');
                    JsonTextWriter.WriteValue(0); */

                    GetJSONObj.Add('VAT_E_Net', TotalAmt);
                    GetJSONObj.Add('VAT_E', 0);

                    /*  OutStreamObj.WRITETEXT('VAT E Amount ' + FORMAT(TotalAmt));
                     OutStreamObj.WRITETEXT(); */

                    /*  JsonTextWriter.WritePropertyName('data');
                     JsonTextWriter.WriteStartArray; */
                    /* OutStreamObj.WRITETEXT('Start Lines');
                    OutStreamObj.WRITETEXT();
 */
                    SalesInvoiceLine.RESET;
                    SalesInvoiceLine.SETRANGE("Document No.", SalesInvHeader."No.");
                    SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
                    IF SalesInvoiceLine.FINDSET() THEN
                        REPEAT
                            Clear(GetJsonSubObj);
                            /* JsonTextWriter.WriteStartObject;
                             JsonTextWriter.WritePropertyName('productCode'); */
                            CASE SalesInvoiceLine.Type OF
                                SalesInvoiceLine.Type::"G/L Account":
                                    BEGIN
                                        GLAccount.GET(SalesInvoiceLine."No.");
                                        GLAccount.TESTFIELD("HS Code");
                                        // JsonTextWriter.WriteValue(GLAccount."HS Code");
                                        GetJsonSubObj.Add('productCode', GLAccount."HS Code");

                                        /*  OutStreamObj.WRITETEXT('HS Code ' + GLAccount."HS Code");
                                         OutStreamObj.WRITETEXT(); */
                                    END;
                                SalesInvoiceLine.Type::Item:
                                    BEGIN
                                        Item.GET(SalesInvoiceLine."No.");
                                        Item.TESTFIELD("HS Code");
                                        // JsonTextWriter.WriteValue(Item."HS Code");
                                        GetJsonSubObj.Add('productCode', Item."HS Code");
                                    END;
                            END;
                            /* JsonTextWriter.WritePropertyName('productDesc');
                            JsonTextWriter.WriteValue(SalesInvoiceLine.Description);
                            JsonTextWriter.WritePropertyName('quantity');
                            JsonTextWriter.WriteValue(1);
                            JsonTextWriter.WritePropertyName('UnitPrice'); */

                            GetJsonSubObj.Add('productDesc', SalesInvoiceLine.Description);
                            GetJsonSubObj.Add('quantity', 1);

                            IF SalesInvHeader."Currency Factor" <> 0 THEN BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) / SalesInvHeader."Currency Factor"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100)) / SalesInvHeader."Currency Factor"
                            END ELSE BEGIN
                                IF SalesInvHeader."Prices Including VAT" THEN
                                    UnitPrice := SalesInvoiceLine."Unit Price"
                                ELSE
                                    UnitPrice := ((SalesInvoiceLine."Unit Price" * SalesInvoiceLine.Quantity) * ((100 + SalesInvoiceLine."VAT %") / 100));
                            END;
                            //UnitPrice *= SalesInvoiceLine.Quantity;
                            UnitPrice := ROUND(UnitPrice, 1, '=');
                            //UnitP := UnitPrice;
                            /* OutStreamObj.WRITETEXT('Unit Price ' + FORMAT(UnitPrice));
                            OutStreamObj.WRITETEXT(); */
                            /*  JsonTextWriter.WriteValue(UnitPrice);
                             JsonTextWriter.WritePropertyName('discount');
                             JsonTextWriter.WriteValue(SalesInvoiceLine."Line Discount Amount");
                             JsonTextWriter.WritePropertyName('taxtype'); */

                            GetJsonSubObj.Add('UnitPrice', UnitPrice);
                            GetJsonSubObj.Add('discount', SalesInvoiceLine."Line Discount Amount");

                            TaxRate := ROUND(SalesInvoiceLine."VAT %", 1, '=');
                            /* OutStreamObj.WRITETEXT('VAT ' + FORMAT(TaxRate));
                            OutStreamObj.WRITETEXT(); */
                            // JsonTextWriter.WriteValue(TaxRate);

                            GetJsonSubObj.Add('taxtype', 'VAT ' + FORMAT(TaxRate));
                            GetJSONArr.Add(GetJsonSubObj);
                        //  JsonTextWriter.WriteEndObject;
                        UNTIL SalesInvoiceLine.NEXT() = 0;
                    /*  JsonTextWriter.WriteEndArray;
                     JsonTextWriter.WriteEndObject;
                     JsonTextWriter.Flush; */

                    GetJSONObj.Add('data', GetJSONArr);
                    GetJSONObj.WriteTo(JsonMsgTxt);
                    MESSAGE(Format(JsonMsgTxt));

                    /* JSonString := GetJSon;
                     OutStreamObj.WRITETEXT(); */
                    GetJSONObj.WriteTo(OutStreams);
                    /* OutStreams.WriteText()
                    TestFile.CLOSE;
                    Display Json Structure
                    TempBlob.CreateInStream(InStr); */ // B2BUPG handled using streams
                    Tempblob2.CreateInStream(InStr);
                    FileNameTxt := 'Sale invoice ' + SalesInvHeader."No." + '.Json';
                    DownloadFromStream(InStr, '', '', '', FileNameTxt);// B2BUPG handled using streams

                    //Naveen B2BUPG----<<<<
                END;
            DATABASE::"Sales Cr.Memo Header":
                BEGIN
                    RecRef.SETTABLE(SalesCrHeader);
                    SalesCrHeader.TESTFIELD(SalesCrHeader."Applies-to Doc. Type", SalesCrHeader."Applies-to Doc. Type"::Invoice);
                    SalesCrHeader.TESTFIELD(SalesCrHeader."Applies-to Doc. No.");
                    SalesInvHeader.GET(SalesCrHeader."Applies-to Doc. No.");
                    SalesInvHeader.TESTFIELD("Invoice Number");
                    Customer.GET(SalesCrHeader."Sell-to Customer No.");
                    SalesCrHeader.CALCFIELDS("Amount Including VAT", Amount);
                    //  FileNameTxt := SalesCrHeader."No.";
                    FileNamex := Setup."QR Location" + '.Json';
                    FileNameTxt := 'Sales Invoice' + SalesInvHeader."No." + '.Json';
                    /*IF NOT ( SalesCrHeader."Invoi
                      EXIT;*/
                    //Naveen B2BUPG---->>>>
                    TempBlob.CreateOutStream(OutStreamObj);
                    Tempblob2.CreateOutStream(OutStreams);
                    //  OutStreamObj.WriteText(FileNamex);
                    /*  IF EXISTS(FileNamex) THEN
                         ERASE(FileNamex);
                     TestFile.CREATE(FileNamex);
                     TestFile.CREATEOUTSTREAM(OutStreamObj); */ // B2BUPG handled above using streams

                    AmountInc := GetTotalSalesCreditLine(SalesCrHeader."No.", GetTotalVATSalesCreditLine(SalesCrHeader."No.") = 0);
                    IF NOT (GetTotalVATSalesCreditLine(SalesCrHeader."No.") = 0) THEN
                        VATAmount := ROUND(((AmountInc * 0.16) / 1.16), 0.01, '=');
                    VatAmt := VATAmount;
                    AmtInc := AmountInc;
                    TotalAmt := GetTotalSalesCreditLine(SalesCrHeader."No.", FALSE) + GetTotalSalesCreditLine(SalesCrHeader."No.", TRUE);
                    // Initialize;
                    /*  JsonTextWriter.WriteStartObject;

                      JsonTextWriter.WritePropertyName('saleType');

                       JsonTextWriter.WriteValue('refund'); */

                    GetJSONObj.Add('saleType', 'refund');

                    /* OutStreamObj.WRITETEXT('refund');
                    OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('cuin');
                    JsonTextWriter.WriteValue(SalesInvHeader."Invoice Number"); */

                    GetJSONObj.Add('cuin', SalesInvHeader."Invoice Number");

                    /* OutStreamObj.WRITETEXT('cuin ' + SalesInvHeader."Invoice Number");
                    OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('till');
                    JsonTextWriter.WriteValue(FORMAT(1));
                    JsonTextWriter.WritePropertyName('rctNo');
                    JsonTextWriter.WriteValue(DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars))); */

                    GetJSONObj.Add('till', FORMAT(1));
                    GetJSONObj.Add('rctNo', DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars)));

                    /* OutStreamObj.WRITETEXT('RctNo ' + FORMAT(DELCHR(SalesCrHeader."No.", '=', DELCHR(SalesCrHeader."No.", '=', AllowedChars))));
                    OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('total');
                    JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('Paid');
                    JsonTextWriter.WriteValue(TotalAmt); */

                    GetJSONObj.Add('total', TotalAmt);
                    GetJSONObj.Add('Paid', TotalAmt);

                    /*  OutStreamObj.WRITETEXT('Total Amount ' + FORMAT(TotalAmt));
                     OutStreamObj.WRITETEXT(); */

                    /* JsonTextWriter.WritePropertyName('Payment');
                    JsonTextWriter.WriteValue('Credit');
                    JsonTextWriter.WritePropertyName('CustomerPIN');
                    JsonTextWriter.WriteValue(Customer."VAT Registration No."); */

                    GetJSONObj.Add('Payment', 'Credit');
                    GetJSONObj.Add('CustomerPIN', Customer."VAT Registration No.");

                    /*  OutStreamObj.WRITETEXT('Customer PIN ' + Customer."VAT Registration No.");
                     OutStreamObj.WRITETEXT();
  */
                    /* JsonTextWriter.WritePropertyName('VAT_A_Net');
                    IF SalesCrHeader."Prices Including VAT" THEN
                        JsonTextWriter.WriteValue(AmtInc - VatAmt)
                    ELSE
                        JsonTextWriter.WriteValue(AmtInc - VatAmt); */

                    IF SalesCrHeader."Prices Including VAT" THEN
                        GetJSONObj.Add('VAT_A_Net', AmtInc - VatAmt)
                    ELSE
                        GetJSONObj.Add('VAT_A_Net', AmtInc - VatAmt);

                    /*  OutStreamObj.WRITETEXT('VAT A Amount ' + FORMAT((AmtInc - VatAmt)));
                     OutStreamObj.WRITETEXT();

                     OutStreamObj.WRITETEXT('VAT Amount ' + FORMAT(VatAmt));
                     OutStreamObj.WRITETEXT(); */
                    /*  JsonTextWriter.WritePropertyName('VAT_A');
                     JsonTextWriter.WriteValue(VatAmt);
                     JsonTextWriter.WritePropertyName('VAT_E_Net'); */

                    GetJSONObj.Add('VAT_A', VatAmt);

                    TotalAmt := GetTotalSalesCreditLine(SalesCrHeader."No.", TRUE);
                    /* JsonTextWriter.WriteValue(TotalAmt);
                    JsonTextWriter.WritePropertyName('VAT_E');
                    JsonTextWriter.WriteValue(0); */

                    GetJSONObj.Add('VAT_E_Net', TotalAmt);
                    GetJSONObj.Add('VAT_E', 0);

                    /*  OutStreamObj.WRITETEXT('VAT E Amount ' + FORMAT(TotalAmt));
                     OutStreamObj.WRITETEXT(); */

                    /*  JsonTextWriter.WritePropertyName('data');
                     JsonTextWriter.WriteStartArray; */
                    /*  OutStreamObj.WRITETEXT('Start Lines');
                     OutStreamObj.WRITETEXT(); */

                    SalesCrMemoLine.RESET;
                    SalesCrMemoLine.SETRANGE("Document No.", SalesCrHeader."No.");
                    SalesCrMemoLine.SETFILTER("No.", '<>%1', '');
                    IF SalesCrMemoLine.FINDSET() THEN
                        REPEAT
                            Clear(GetJsonSubObj);
                            /*   JsonTextWriter.WriteStartObject;
                             JsonTextWriter.WritePropertyName('productCode');  */
                            CASE SalesCrMemoLine.Type OF
                                SalesCrMemoLine.Type::"G/L Account":
                                    BEGIN
                                        GLAccount.GET(SalesCrMemoLine."No.");
                                        GLAccount.TESTFIELD("HS Code");
                                        //JsonTextWriter.WriteValue(GLAccount."HS Code");
                                        GetJsonSubObj.Add('productCode', GLAccount."HS Code");

                                        /* OutStreamObj.WRITETEXT('HS Code ' + GLAccount."HS Code");
                                        OutStreamObj.WRITETEXT(); */
                                    END;
                                SalesCrMemoLine.Type::Item:
                                    BEGIN
                                        Item.GET(SalesCrMemoLine."No.");
                                        Item.TESTFIELD("HS Code");
                                        /*JsonTextWriter.WriteValue(Item."HS Code");
                                          GetJsonSubObj.Add('productCode', Item."HS Code"); */
                                    END;
                            END;
                            /*  JsonTextWriter.WritePropertyName('productDesc');
                             JsonTextWriter.WriteValue(SalesCrMemoLine.Description);
                             JsonTextWriter.WritePropertyName('quantity');
                             JsonTextWriter.WriteValue(1);
                             JsonTextWriter.WritePropertyName('UnitPrice'); */

                            GetJsonSubObj.Add('productDesc', SalesCrMemoLine.Description);
                            GetJsonSubObj.Add('quantity', 1);

                            IF SalesCrHeader."Currency Factor" <> 0 THEN BEGIN
                                IF SalesCrHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) / SalesCrHeader."Currency Factor"
                                ELSE
                                    UnitPrice := ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100)) / SalesCrHeader."Currency Factor"
                            END ELSE BEGIN
                                IF SalesCrHeader."Prices Including VAT" THEN
                                    UnitPrice := (SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity)
                                ELSE
                                    UnitPrice := ((SalesCrMemoLine."Unit Price" * SalesCrMemoLine.Quantity) * ((100 + SalesCrMemoLine."VAT %") / 100));
                            END;
                            // UnitPrice *= SalesCrMemoLine.Quantity;
                            UnitPrice := ROUND(UnitPrice, 1, '=');
                            //UnitP := UnitPrice;
                            /* OutStreamObj.WRITETEXT('Unit Price ' + FORMAT(UnitPrice));
                            OutStreamObj.WRITETEXT(); */
                            /*  JsonTextWriter.WriteValue(UnitPrice);
                             JsonTextWriter.WritePropertyName('discount');
                             JsonTextWriter.WriteValue(SalesCrMemoLine."Line Discount Amount"); 
                             JsonTextWriter.WritePropertyName('taxtype');*/

                            GetJsonSubObj.Add('UnitPrice', UnitPrice);
                            GetJsonSubObj.Add('discount', SalesCrMemoLine."Line Discount Amount");

                            TaxRate := ROUND(SalesCrMemoLine."VAT %", 1, '=');
                            /* OutStreamObj.WRITETEXT('VAT ' + FORMAT(TaxRate));
                            OutStreamObj.WRITETEXT(); */
                            //JsonTextWriter.WriteValue(TaxRate);

                            GetJsonSubObj.Add('taxtype', 'VAT ' + FORMAT(TaxRate));

                            //JsonTextWriter.WriteEndObject;
                            GetJSONArr.Add(GetJsonSubObj);
                        UNTIL SalesCrMemoLine.NEXT() = 0;

                    GetJSONObj.Add('data', GetJSONArr);
                    GetJSONObj.WriteTo(JsonMsgTxt);
                    MESSAGE(JsonMsgTxt);
                    /*  JsonTextWriter.WriteEndArray;
                     JsonTextWriter.WriteEndObject;
                     JsonTextWriter.Flush; */

                    /* JSonString := GetJSon;
                    OutStreamObj.WRITETEXT(); */
                    GetJSONObj.WriteTo(OutStreams);
                    /*OutStreams.WriteText()
                    TestFile.CLOSE;
                    Display Json Structure
                    TempBlob.CreateInStream(InStr); */ // B2BUPG handled using streams
                    Tempblob2.CreateInStream(InStr);
                    FileNameTxt := 'Sales Credit Memo ' + SalesCrHeader."No." + '.Json';
                    DownloadFromStream(InStr, '', '', '', FileNameTxt);// B2BUPG handled using streams

                END;
        END;
    end;
} //B2BUPG Integration

