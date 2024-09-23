report 50025 "Sales Vs Purchase Comp V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesVsPurchaseCompV2.rdlc';

    dataset
    {
        dataitem(DataItem1; Table50039)
        {
            RequestFilterFields = "MAWB No.";
            column(MAWB_No; "MAWB Receipt"."MAWB No.")
            {
            }
            column(MAWB_Airline_Name; gRecAirLines.Name)
            {
            }
            column(MAWB_Charge; gDecWeight)
            {
            }
            column(ShowSummary; gBoolShowSummary)
            {
            }
            column(ShowLosses; gBoolShowLosses)
            {
            }
            column(TotalSalesNos; gIntTotalSalesNos)
            {
            }
            column(TotalPurchasesNos; gIntTotalPurchaseNos)
            {
            }
            column(TotalWeight; gIntTotalWeight)
            {
            }
            column(ShowClient; gBoolShowClient)
            {
            }
            column(showAssignDate; gBoolShowAssignedDate)
            {
            }
            column(AssignedDate; "MAWB Receipt"."Assigned Date")
            {
            }
            column(BillToName; gCodeBillToName)
            {
            }
            column(Commodity; gCodeCommodity)
            {
            }
            column(Sales_Assigned_Date; gDateAssignedDate)
            {
            }
            column(SalesCount; gIntSalesCount)
            {
            }
            column(PurchaseCount; gIntPurchasesCount)
            {
            }
            column(PurchaseInvAmt; gDecPurchInvAmount)
            {
            }
            column(PurchaseCrAmt; gDecPurchCrAmount)
            {
            }
            dataitem(DataItem7; Table112)
            {
                DataItemLink = MAWB No.=FIELD(MAWB No.);
                DataItemTableView = SORTING(No.)
                                    WHERE(MAWB No.=FILTER(<>''));
                column(Sales_Invoice_No;"Sales Invoice Header"."No.")
                {
                }
                column(Sales_Inv_Posting_Date;"Sales Invoice Header"."Posting Date")
                {
                }
                column(Sales_Customer_Name;gRecCustomer.Name)
                {
                }
                column(Sales_Total_Weight;"Sales Invoice Header"."Total Weight")
                {
                }
                column(Sales_Commodity;"Sales Invoice Header".Commodity)
                {
                }
                column(PurchTotalAmount;gRecPurchTotalAmount)
                {
                }
                dataitem(DataItem11;Table113)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    DataItemTableView = SORTING(Document No.,Line No.);
                    column(SalesLine_Amount_ACY;"Sales Invoice Line"."Amount Including VAT")
                    {
                    }
                    column(SalesLine_Amount_LCY;gRecSalesInvLCY)
                    {
                    }
                    column(SalesLine_Description;"Sales Invoice Line".Description)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        gRecSalesInvLCY := 0;
                        IF "Sales Invoice Header"."Currency Code" <> '' THEN
                          gRecSalesInvLCY := "Sales Invoice Line"."Amount Including VAT"/"Sales Invoice Header"."Currency Factor"
                        ELSE
                          gRecSalesInvLCY := "Sales Invoice Line"."Amount Including VAT";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF gRecCustomer.GET("Sales Invoice Header"."Bill-to Customer No.") THEN;
                    gRecPurchTotalAmount := 0;
                    IF gDecWeight <> 0 THEN
                      gRecPurchTotalAmount := ((gDecPurchInvAmount - gDecPurchCrAmount) * "Sales Invoice Header"."Total Weight")/gDecWeight;
                end;

                trigger OnPreDataItem()
                begin
                    IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Sales Invoice Header".SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
                end;
            }
            dataitem(DataItem15;Table114)
            {
                DataItemLink = External Document No.=FIELD(MAWB No.);
                DataItemTableView = WHERE(External Document No.=FILTER(<>''));
                column(Sales_Cr_No;"Sales Cr.Memo Header"."No.")
                {
                }
                column(Sales_Cr_Customer_Name;gRecCustomer2.Name)
                {
                }
                dataitem(DataItem18;Table115)
                {
                    DataItemLink = Document No.=FIELD(No.);
                    column(Sales_Cr_Amount_ACY;"Sales Cr.Memo Line"."Amount Including VAT")
                    {
                    }
                    column(Sales_Cr_Amount_LCY;gDecSalesCrLCY)
                    {
                    }
                    column(Sales_Cr_Description;"Sales Cr.Memo Line".Description)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        gDecSalesCrLCY := 0;
                        IF "Sales Cr.Memo Header"."Currency Code" <> '' THEN
                          gDecSalesCrLCY :="Sales Cr.Memo Line"."Amount Including VAT" / "Sales Cr.Memo Header"."Currency Factor"
                        ELSE
                          gDecSalesCrLCY := "Sales Cr.Memo Line"."Amount Including VAT";
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF gRecCustomer2.GET("Sales Cr.Memo Header"."Sell-to Customer No.") THEN;
                end;

                trigger OnPreDataItem()
                begin
                    IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Sales Cr.Memo Header".SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
                end;
            }
            dataitem(DataItem22;Table123)
            {
                DataItemLink = Payment Voucher No.=FIELD(MAWB No.);
                DataItemTableView = WHERE(Payment Voucher No.=FILTER(<>''));
                column(Purch_Inv_Document_No;"Purch. Inv. Line"."Document No.")
                {
                }
                column(Purch_Inv_Amount_ACY;"Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(Purch_Inv_Description;"Purch. Inv. Line".Description)
                {
                }
                column(Purch_Inv_Vendor_Name;gRecVendor.Name)
                {
                }
                column(Purch_Inv_Amount_LCY;gDecPurchInvLCY)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF gCodePurchInvoice <> "Purch. Inv. Line"."Document No." THEN
                      gIntTotalPurchaseNos += 1;

                    IF gRecVendor.GET("Purch. Inv. Line"."Buy-from Vendor No.") THEN;
                    gDecPurchInvLCY := 0;
                    gRecPurchInvHr.GET("Purch. Inv. Line"."Document No.");
                    IF gRecPurchInvHr."Currency Code" <> '' THEN
                      gDecPurchInvLCY := "Purch. Inv. Line"."Amount Including VAT"/gRecPurchInvHr."Currency Factor"
                    ELSE
                      gDecPurchInvLCY := "Purch. Inv. Line"."Amount Including VAT";

                    gCodePurchInvoice := "Purch. Inv. Line"."Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Purch. Inv. Line".SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
                end;
            }
            dataitem(DataItem28;Table125)
            {
                DataItemLink = Payment Voucher No.=FIELD(MAWB No.);
                DataItemTableView = WHERE(Payment Voucher No.=FILTER(<>''));
                column(Purch_Cr_Document_No;"Purch. Cr. Memo Line"."Document No.")
                {
                }
                column(Purch_Cr_Amount_ACY;"Purch. Cr. Memo Line"."Amount Including VAT")
                {
                }
                column(Purch_Cr_Description;"Purch. Cr. Memo Line".Description)
                {
                }
                column(Purch_Cr_Vendor_Name;gRecVendor2.Name)
                {
                }
                column(Purch_Cr_Amount_LCY;gDecPurchCrLCY)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF gCodePurchCreditMemo <> "Purch. Cr. Memo Line"."Document No." THEN
                      gIntTotalPurchaseNos += 1;


                    IF gRecVendor2.GET(gRecPurchCrHr."Buy-from Vendor No.") THEN;
                    gDecPurchCrLCY := 0;
                    gRecPurchCrHr.GET("Purch. Cr. Memo Line"."Document No.");
                    IF gRecPurchCrHr."Currency Code" <> '' THEN
                      gDecPurchCrLCY := "Purch. Cr. Memo Line"."Amount Including VAT"/gRecPurchCrHr."Currency Factor"
                    ELSE
                      gDecPurchCrLCY := "Purch. Cr. Memo Line"."Amount Including VAT";

                    gCodePurchCreditMemo := "Purch. Cr. Memo Line"."Document No.";
                end;

                trigger OnPreDataItem()
                begin
                    IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                    "Purch. Cr. Memo Line".SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                //Fetch Airline Name from Airline Code
                IF gRecAirLines.GET("MAWB Receipt"."Airline Code") THEN;
                //Calculate Chargeble Weight of MAWB No.
                WITH gRecMAWBInvChrg DO BEGIN
                  gDecWeight := 0;
                  RESET;
                  SETRANGE("MAWB No.","MAWB Receipt"."MAWB No.");
                  IF FINDSET THEN
                    REPEAT
                     gDecWeight += "Chargeable Weight";
                    UNTIL NEXT = 0;
                END;

                //IF (gCodeTempMAWBNo = "MAWB Receipt"."MAWB No.") OR (gDecWeight = 0) THEN BEGIN
                IF (gCodeTempMAWBNo = "MAWB Receipt"."MAWB No.") THEN BEGIN
                  CurrReport.SKIP;
                END;
                gCodeTempMAWBNo := "MAWB Receipt"."MAWB No.";
                IF gBoolShowClient THEN
                  "FetchBilltoName&Commodity"("MAWB Receipt"."MAWB No.");

                //Sales & Purchases Count
                gIntSalesCount := 0;
                gIntPurchasesCount := 0;

                gRecSalesInvHr.RESET;
                gRecSalesInvHr.SETRANGE("MAWB No.","MAWB Receipt"."MAWB No.");
                IF gRecSalesInvHr.FINDSET THEN
                  gIntSalesCount += gRecSalesInvHr.COUNT;

                 gRecSalesCrHr.RESET;
                 gRecSalesCrHr.SETRANGE("External Document No.","MAWB Receipt"."MAWB No.");
                 IF gRecSalesCrHr.FINDSET THEN
                   gIntSalesCount += gRecSalesCrHr.COUNT;

                gRecPurchDocNo := '';
                gDecPurchInvAmount := 0;
                gRecPurchInvLine.RESET;
                gRecPurchInvLine.SETCURRENTKEY(gRecPurchInvLine."Payment Voucher No.",gRecPurchInvLine."Document No.");
                gRecPurchInvLine.SETRANGE("Payment Voucher No.","MAWB Receipt"."MAWB No.");
                IF gRecPurchInvLine.FINDSET THEN REPEAT
                  IF gRecPurchDocNo <> gRecPurchInvLine."Document No." THEN
                    gIntPurchasesCount += 1;
                  gRecPurchDocNo := gRecPurchInvLine."Document No.";

                  gRecPurchInvHr.GET(gRecPurchInvLine."Document No.");
                  IF gRecPurchInvHr."Currency Code" <> '' THEN
                    gDecPurchInvAmount +=gRecPurchInvLine."Amount Including VAT"/gRecPurchInvHr."Currency Factor"
                ELSE
                  gDecPurchInvAmount += gRecPurchInvLine."Amount Including VAT";

                UNTIL gRecPurchInvLine.NEXT = 0;

                gDecPurchCrAmount := 0;
                gRecPurchCrLine.RESET;
                gRecPurchCrLine.SETCURRENTKEY(gRecPurchCrLine."Payment Voucher No.",gRecPurchCrLine."Document No.");
                gRecPurchCrLine.SETRANGE("Payment Voucher No.","MAWB Receipt"."MAWB No.");
                IF gRecPurchCrLine.FINDSET THEN REPEAT
                  IF gRecPurchDocNo <> gRecPurchCrLine."Document No." THEN
                    gIntPurchasesCount += 1;
                  gRecPurchDocNo := gRecPurchCrLine."Document No.";

                  gRecPurchCrHr.GET(gRecPurchCrLine."Document No.");
                  IF gRecPurchCrHr."Currency Code" <> '' THEN
                    gDecPurchCrAmount +=  gRecPurchCrLine."Amount Including VAT"/gRecPurchCrHr."Currency Factor"
                ELSE
                  gDecPurchCrAmount += gRecPurchCrLine."Amount Including VAT";


                UNTIL gRecPurchCrLine.NEXT = 0;
            end;

            trigger OnPreDataItem()
            begin
                //Date Filters
                "MAWB Receipt".SETCURRENTKEY("MAWB Receipt"."MAWB No.");
                //IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                //  "MAWB Receipt".SETRANGE("Invioced Date",gDateStartDate,gDateEndDate);
                //  FetchTotalPurhaseNos;
                //  FetchTotalWeight;
                gCodeTempMAWBNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Show Summary";gBoolShowSummary)
                {
                }
                field("Show Losses";gBoolShowLosses)
                {
                }
                field("Show Client";gBoolShowClient)
                {
                    Visible = true;
                }
                field("Assigned Date";gBoolShowAssignedDate)
                {
                }
                field("Start Date";gDateStartDate)
                {
                }
                field("End Date";gDateEndDate)
                {
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

    var
        gRecAirLines: Record "50021";
        gDecWeight: Decimal;
        gRecMAWBInvChrg: Record "50073";
        gBoolShowSummary: Boolean;
        gBoolShowLosses: Boolean;
        gRecCustomer: Record "18";
        gRecSalesInvLCY: Decimal;
        gRecCustomer2: Record "18";
        gDecSalesCrLCY: Decimal;
        gRecVendor: Record "23";
        gRecVendor2: Record "23";
        gDecPurchInvLCY: Decimal;
        gDecPurchCrLCY: Decimal;
        gRecPurchInvHr: Record "122";
        gRecPurchCrHr: Record "124";
        gDateStartDate: Date;
        gDateEndDate: Date;
        gCodeTempMAWBNo: Code[50];
        gIntTotalSalesNos: Integer;
        gIntTotalPurchaseNos: Integer;
        gIntTotalWeight: Decimal;
        gCodePurchInvoice: Code[20];
        gCodePurchCreditMemo: Code[20];
        gCodeBillToName: Code[50];
        gCodeCommodity: Code[50];
        gBoolShowClient: Boolean;
        gBoolShowAssignedDate: Boolean;
        gDateAssignedDate: Date;
        gIntSalesCount: Integer;
        gIntPurchasesCount: Integer;
        gRecSalesInvHr: Record "112";
        gRecSalesCrHr: Record "114";
        gRecPurchInvLine: Record "123";
        gRecPurchCrLine: Record "125";
        gRecPurchDocNo: Code[30];
        gDecPurchInvAmount: Decimal;
        gDecPurchCrAmount: Decimal;
        gRecPurchTotalAmount: Decimal;

    local procedure FetchTotalSalesNos()
    var
        lRecSalesInvHr: Record "112";
        lRecSalesCrHr: Record "114";
        lRecMAWBReciept: Record "50039";
        lCodeMAWBNo: Code[20];
    begin
        gIntTotalSalesNos := 0;
        lCodeMAWBNo := '';
        lRecMAWBReciept.RESET;
        lRecMAWBReciept.SETCURRENTKEY("MAWB No.");
        IF lRecMAWBReciept.FINDSET THEN
          REPEAT
            IF lCodeMAWBNo <> lRecMAWBReciept."MAWB No." THEN BEGIN
              lRecSalesInvHr.RESET;
              lRecSalesInvHr.SETRANGE("MAWB No.",lRecMAWBReciept."MAWB No.");
              IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                lRecSalesInvHr.SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
              IF lRecSalesInvHr.FINDFIRST THEN
                gIntTotalSalesNos += 1;
              lRecSalesCrHr.RESET;
              lRecSalesCrHr.SETRANGE("External Document No.",lRecMAWBReciept."MAWB No.");
              IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                lRecSalesCrHr.SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
              IF lRecSalesCrHr.FINDFIRST THEN
                gIntTotalSalesNos += 1;
            END;
           lCodeMAWBNo := lRecMAWBReciept."MAWB No.";
           UNTIL lRecMAWBReciept.NEXT = 0;
    end;

    local procedure FetchTotalPurhaseNos()
    var
        lRecPurchInvLine: Record "123";
        lRecPurchCrLine: Record "125";
        lRecMAWBReciept: Record "50039";
        lCodeMAWBNo: Code[20];
    begin
        gIntTotalPurchaseNos := 0;
        lCodeMAWBNo := '';
        lRecMAWBReciept.RESET;
        lRecMAWBReciept.SETCURRENTKEY("MAWB No.");
        lRecMAWBReciept.COPYFILTERS("MAWB Receipt");
        IF lRecMAWBReciept.FINDSET THEN
          REPEAT
            IF lCodeMAWBNo <> lRecMAWBReciept."MAWB No." THEN BEGIN
              lRecPurchInvLine.RESET;
              lRecPurchInvLine.SETRANGE("Payment Voucher No.",lRecMAWBReciept."MAWB No.");
              IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                lRecPurchInvLine.SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
              IF lRecPurchInvLine.FINDFIRST THEN
                gIntTotalPurchaseNos += 1;
              lRecPurchCrLine.RESET;
              lRecPurchCrLine.SETRANGE("Payment Voucher No.",lRecMAWBReciept."MAWB No.");
               IF (gDateStartDate <> 0D) AND (gDateEndDate <> 0D) THEN
                lRecPurchCrLine.SETRANGE("Posting Date",gDateStartDate,gDateEndDate);
              IF lRecPurchCrLine.FINDFIRST THEN
                gIntTotalPurchaseNos += 1;
            END;
           lCodeMAWBNo := lRecMAWBReciept."MAWB No.";
           UNTIL lRecMAWBReciept.NEXT = 0;
    end;

    local procedure FetchTotalWeight()
    var
        lRecSalesInvHr: Record "112";
        lRecSalesCrHr: Record "114";
        lRecPurchInvLine: Record "123";
        lRecPurchCrLine: Record "125";
        lRecMAWBReciept: Record "50039";
        lCodeMAWBNo: Code[20];
    begin
        lCodeMAWBNo := '';
        gIntTotalWeight := 0;
        lRecMAWBReciept.RESET;
        lRecMAWBReciept.SETCURRENTKEY("MAWB No.");
        lRecMAWBReciept.COPYFILTERS("MAWB Receipt");
        IF lRecMAWBReciept.FINDSET THEN


        WITH gRecMAWBInvChrg DO BEGIN
          gDecWeight := 0;
          RESET;
          SETRANGE("MAWB No.","MAWB Receipt"."MAWB No.");
          IF FINDSET THEN
            REPEAT
             gIntTotalWeight += "Chargeable Weight";
            UNTIL NEXT = 0;
        END;
    end;

    local procedure "FetchBilltoName&Commodity"(MAWBNo: Code[50])
    var
        lRecPstdSalesInvHr: Record "112";
        lRecCustomer: Record "18";
    begin
        gDateAssignedDate := 0D;
        gCodeCommodity := '';
        gCodeBillToName := '';
        lRecPstdSalesInvHr.RESET;
        lRecPstdSalesInvHr.SETRANGE("MAWB No.",MAWBNo);
        IF lRecPstdSalesInvHr.FINDFIRST THEN BEGIN
          IF lRecCustomer.GET(lRecPstdSalesInvHr."Bill-to Customer No.") THEN
            gCodeBillToName := lRecCustomer.Name;
          gCodeCommodity := lRecPstdSalesInvHr.Commodity;
          gDateAssignedDate := lRecPstdSalesInvHr."Posting Date";
        END;
    end;
}

