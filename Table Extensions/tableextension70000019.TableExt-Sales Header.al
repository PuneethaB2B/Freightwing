tableextension 70000019 tableextension70000019 extends "Sales Header"
{
    fields
    {

        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        TESTFIELD(Status,Status::Open);
        IF ("Sell-to Customer No." <> xRec."Sell-to Customer No.") AND
        #4..158

        IF NOT SkipSellToContact THEN
          UpdateSellToCont("Sell-to Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //
        LoadingSheetHeader.RESET;
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Loading Sheet MAWB No","MAWB No.");
        LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Shipper Code","Sell-to Customer No.");
        IF LoadingSheetHeader.FINDFIRST THEN
        //MESSAGE(LoadingSheetHeader."Shipper Code");
        //VALIDATE("Sell-to Customer No.");
        "External Document No.":="MAWB No.";
        MAWBAlloc.RESET;
        MAWBAlloc.SETRANGE(MAWBAlloc."MAWB No","MAWB No.");
        IF MAWBAlloc.FINDFIRST THEN BEGIN
        //=======GET NOTIFY PARTIES FROM BOOKING SHEET========
        BookingSheetLine.RESET;
        BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.",MAWBAlloc."Booking Sheet No");
        BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code",MAWBAlloc."Airline Code");
        BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code",MAWBAlloc."Flight No");
        BookingSheetLine.SETRANGE(BookingSheetLine."Source Airport",MAWBAlloc."Source Airport");
        BookingSheetLine.SETRANGE(BookingSheetLine."Destination Airport",MAWBAlloc."Destination Airport");
        BookingSheetLine.SETRANGE("Shipper Code","Sell-to Customer No.");
        IF BookingSheetLine.FINDFIRST THEN BEGIN
          NotifyParty.RESET;
          NotifyParty.SETRANGE(Type,NotifyParty.Type::Shipper);
          NotifyParty.SETRANGE("Type Code","Sell-to Customer No.");
          IF NotifyParty.FINDFIRST THEN BEGIN
            MAWBInvoiceNotifyParty.INIT;
            MAWBInvoiceNotifyParty."Invoice No.":="No.";
            MAWBInvoiceNotifyParty."MAWB No.":="MAWB No.";
            MAWBInvoiceNotifyParty."HAWB No.":="HAWB No.";
            MAWBInvoiceNotifyParty."Line No.":=MAWBInvoiceNotifyParty."Line No."+10000;
            MAWBInvoiceNotifyParty."Notify-Party No.":=NotifyParty."No.";
            MAWBInvoiceNotifyParty."Notify-Party Name":=NotifyParty.Name;;
            MAWBInvoiceNotifyParty."Source Code":=NotifyParty."Type Code";;
            MAWBInvoiceNotifyParty."Source Type":=NotifyParty.Type::Shipper;
            MAWBInvoiceNotifyParty.INSERT;
          END;

           BookingSheetHAWBAllocation.RESET;
           BookingSheetHAWBAllocation.SETRANGE("MAWB No.","MAWB No.");
           BookingSheetHAWBAllocation.SETRANGE("Shipper Code","Sell-to Customer No.");
           IF BookingSheetHAWBAllocation.FINDFIRST THEN BEGIN
             NotifyParty.RESET;
             NotifyParty.SETRANGE(Type,NotifyParty.Type::Consignee);
             NotifyParty.SETRANGE("Type Code",BookingSheetHAWBAllocation."Consignee Code");
             IF NotifyParty.FINDFIRST THEN BEGIN
              MAWBInvoiceNotifyParty.INIT;
              MAWBInvoiceNotifyParty."Invoice No.":="No.";
              MAWBInvoiceNotifyParty."MAWB No.":="MAWB No.";
              MAWBInvoiceNotifyParty."HAWB No.":="HAWB No.";
              MAWBInvoiceNotifyParty."Line No.":=MAWBInvoiceNotifyParty."Line No."+10000;
              MAWBInvoiceNotifyParty."Notify-Party No.":=NotifyParty."No.";
              MAWBInvoiceNotifyParty."Notify-Party Name":=NotifyParty.Name;
              MAWBInvoiceNotifyParty."Source Type":=NotifyParty.Type::Consignee;
              MAWBInvoiceNotifyParty."Source Code":=NotifyParty."Type Code";
              MAWBInvoiceNotifyParty.INSERT;
             END;
           END;
        END;
        END;
        IF NOT HasHouses THEN
        BEGIN
          SalesLine2.RESET;
          SalesLine2.SETRANGE(SalesLine2."Document No.","No.");
          MAWBLine7.InsertSalesInvoiceFromMAWBLine(SalesLine2);
        END;


        //
        #1..161
        */
        //end;
        field(50000; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE (Prepared = FILTER (Yes),
                                                             Assigned = FILTER (Yes),
                                                             Invoiced = FILTER (No));

            trigger OnValidate()
            begin
                ShippedWeight := 0;
                Offload.RESET;
                Offload.SETRANGE(Offload."MAWB No.", "MAWB No.");
                IF Offload.FINDSET THEN BEGIN
                    //MESSAGE('Part of AWB No %1 Was Offloaded.',Offload."MAWB No.");
                    REPEAT
                        ShippedWeight += Offload.Diffrence;
                    UNTIL Offload.NEXT = 0;
                    //MESSAGE('Shipped Weight %1',ShippedWeight);
                    AmmendCharge.CalculateMAWBCharges("MAWB No.");
                    AmmendCharge.CalculateHandlingFees("MAWB No.");
                    HAWBLines.RESET;

                END ELSE BEGIN
                    GatePassLine.RESET;
                    GatePassLine.SETRANGE(GatePassLine."MAWB No.", "MAWB No.");
                    IF GatePassLine.FINDSET THEN BEGIN
                        REPEAT
                            IF GPHeader.GET(GatePassLine."Gate-Pass No.") THEN BEGIN
                                IF GPHeader.Status <> GPHeader.Status::Released THEN BEGIN
                                    IF CONFIRM('The Gate Pass for this AWB has not been Released Do you want to Release and Proceed') THEN BEGIN
                                        GPHeader.Status := GPHeader.Status::Released;
                                        GPHeader.MODIFY;
                                    END;
                                END;
                            END;
                        UNTIL GatePassLine.NEXT = 0;

                    END;
                END;
                HAWBLines.SETRANGE(HAWBLines."MAWB No.", "MAWB No.");
                IF HAWBLines.FINDSET THEN BEGIN
                    HasHouses := TRUE;
                END ELSE BEGIN
                    HasHouses := FALSE;
                END;
                MAWBHeader.GET("MAWB No.");
                MAWBHeader."Invoice Status" := MAWBHeader."Invoice Status"::New;
                MAWBHeader.MODIFY;
                "External Document No." := "MAWB No.";
            end;
        }
        field(50001; "Airline Code"; Code[20])
        {
            TableRelation = Airline;
        }
        field(50002; "Consignee Code"; Code[20])
        {
            TableRelation = Consignee;
        }
        field(50003; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE (Airline Code=FIELD(Airline Code));
        }
        field(50004;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(50005;"Flight Date";Date)
        {
        }
        field(50006;"Chargeable Weight";Decimal)
        {
        }
        field(50007;"Gross Weight";Decimal)
        {
        }
        field(50008;"HAWB No.";Code[20])
        {
        }
        field(50009;Posted;Boolean)
        {
        }
        field(50010;"Import MAWB No.";Code[20])
        {
            TableRelation = "Pre Alert Header"."MAWB No" WHERE (Invoiced=FILTER(No));

            trigger OnValidate()
            begin
                PreAlertHeader.SETRANGE(PreAlertHeader."MAWB No","Import MAWB No.");
                IF PreAlertHeader.FIND('-') THEN
                  PreAlertLine.GET(PreAlertHeader."No.");
                  "Sell-to Customer No.":=PreAlertLine."Shipper Code";
                  "Bill-to Customer No.":=PreAlertLine."Shipper Code";
                  Customer.GET(PreAlertLine."Shipper Code");
                  "Sell-to Customer Name":=Customer.Name;
                  "Bill-to Address":=Customer.Address;
                  "Payment Terms Code" := Customer."Payment Terms Code";
                  "Prepmt. Payment Terms Code" := Customer."Payment Terms Code";
                  VALIDATE("Payment Terms Code");
                  VALIDATE("Prepmt. Payment Terms Code");
                  "External Document No.":="Import MAWB No.";
                //*******INSERT Static CHARGES********
                  SalesLine5.RESET;
                  SalesLine5.SETFILTER(SalesLine5."Line No.",'>%1',0);
                  IF SalesLine5.FIND('+') THEN BEGIN
                   LineNo:=SalesLine5."Line No."+10000;
                  END;
                  SalesHeader.GET("Document Type","No.");
                  ImportChargeMaster.SETFILTER(ImportChargeMaster.Code,'<>%1','');
                  IF ImportChargeMaster.FINDSET THEN BEGIN
                   REPEAT
                    SalesLine.INIT;
                    SalesLine."Document Type":=SalesHeader."Document Type";
                    SalesLine."Document No.":=SalesHeader."No.";
                    SalesLine."Line No.":=LineNo+10000;
                    SalesLine.Type:=SalesLine.Type::"G/L Account";
                    SalesLine."No.":=ImportChargeMaster."G/L Account";
                   // SalesLine.VALIDATE(SalesLine."No.");
                   SalesLine."Freight Charge Code":=ImportChargeMaster.Code;
                    SalesLine.Description:=ImportChargeMaster.Description;
                    SalesLine.Quantity:=1;
                    SalesLine."Unit Price":=ImportChargeMaster."Import Charge";
                    SalesLine.VALIDATE(SalesLine."Unit Price");
                    SalesLine."Line Amount":=ImportChargeMaster."Import Charge";
                    SalesLine.VALIDATE(SalesLine."Line Amount");
                    SalesLine."Currency Code":=ImportChargeMaster.Currency;
                    SalesLine.VALIDATE( SalesLine."Currency Code");
                    SalesLine."MAWB No.":="Import MAWB No.";
                    //SalesLine."Airline Code":=MAWBLine."Airline Code";
                    SalesLine."Consignee Code":=PreAlertLine."Consignee Code";
                    SalesLine."Unit of Measure Code":='';
                    //SalesLine."Flight Code":=MAWBLine."Flight Code";
                    //SalesLine."Destination Code":=MAWBLine."Destination Code";
                    SalesLine."Flight Date":=PreAlertHeader."Actual Arrival Date";
                    SalesLine."Qty. to Ship":=SalesLine.Quantity;
                    SalesLine."Qty. to Invoice":=SalesLine.Quantity;
                    SalesLine."Qty. to Assign":=SalesLine.Quantity;
                    SalesLine."Qty. Assigned":=SalesLine.Quantity;
                    SalesLine."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                    SalesLine."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
                    SalesLine."Customer Price Group" :="Customer Price Group";
                    SalesLine."Customer Disc. Group" :="Customer Disc. Group";
                    SalesLine."Allow Line Disc." := "Allow Line Disc.";
                    SalesLine."Transaction Type" := "Transaction Type";
                    SalesLine."Transport Method" := "Transport Method";
                    SalesLine."Bill-to Customer No." := "Bill-to Customer No.";
                    SalesLine."Exit Point" := "Exit Point";
                    SalesLine. Area := Area;
                    SalesLine. "Transaction Specification" := "Transaction Specification";
                    SalesLine."Tax Area Code" := "Tax Area Code";
                    SalesLine."Tax Liable" := "Tax Liable";
                    GLAccount.GET(ImportChargeMaster."G/L Account");
                    SalesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                    SalesLine.VALIDATE(SalesLine."Gen. Prod. Posting Group");
                    SalesLine."VAT Prod. Posting Group" := ImportChargeMaster."VAT Prod. Posting Group";
                    SalesLine.VALIDATE(SalesLine."VAT Prod. Posting Group");
                    SalesLine.TESTFIELD(SalesLine."Gen. Prod. Posting Group");
                    SalesLine.INSERT;
                    LineNo:=LineNo+10000;
                  UNTIL ImportChargeMaster.NEXT=0;
                END;
            end;
        }
        field(50011;"CC/PP";Code[20])
        {
        }
        field(50012;"Product Code";Code[30])
        {
        }
        field(50013;"Total Weight";Decimal)
        {
        }
        field(50014;"Total Amount";Decimal)
        {
        }
        field(50015;"Agreed Rate";Decimal)
        {
        }
        field(50016;Commodity;Text[100])
        {
        }
        field(50017;"Customer Type";Option)
        {
            OptionMembers = " ",Group,"Third Party";
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF DOPaymentTransLogEntry.FINDFIRST THEN
          DOPaymentTransLogMgt.ValidateCanDeleteDocument("Payment Method Code","Document Type",FORMAT("Document Type"),"No.");

        #4..121
              SalesCrMemoHeaderPrepmt.PrintRecords(TRUE);
            END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..124
        //MAWBHeader.GET("MAWB No.");
        //MAWBHeader."Invoice Status":=MAWBHeader."Invoice Status"::New;
        //MAWBHeader.MODIFY;
        */
    //end;


    //Unsupported feature: Code Modification on "SalesLinesExist(PROCEDURE 3)".

    //procedure SalesLinesExist();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        EXIT(SalesLine.FINDFIRST);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        EXIT(SalesLine.FINDSET);
        */
    //end;

    local procedure GetPurchAmount(mawb: Code[50];Charge: Code[10]) Amnt: Decimal
    var
        PurchInvHeader: Record "122";
        PurchInvLine: Record "123";
        ImportExportSetup: Record "50010";
        ExchangeRates: Record "330";
        Rate: Decimal;
        LCYAmnt: Decimal;
        InvAmnt: Decimal;
        ExchangeRates1: Record "330";
        TempLCY: Decimal;
    begin
        ImportExportSetup.GET;
        PurchInvLine.RESET;
        PurchInvLine.SETRANGE(PurchInvLine."Payment Voucher No.",mawb);
        PurchInvLine.SETRANGE(PurchInvLine."Charge Code",Charge);
        IF PurchInvLine.FINDFIRST THEN BEGIN
          PurchInvLine.TESTFIELD(Amount);
          PurchInvHeader.GET(PurchInvLine."Document No.");
          IF PurchInvHeader."Currency Code" <> ImportExportSetup."Invoicing Currency Code" THEN
          BEGIN
            ExchangeRates.RESET;
            ExchangeRates.SETRANGE(ExchangeRates."Currency Code",ImportExportSetup."Invoicing Currency Code");
            ExchangeRates.SETFILTER(ExchangeRates."Starting Date",'<=%1',PurchInvHeader."Document Date");
            IF ExchangeRates.FINDFIRST THEN
            BEGIN
              Rate:=ExchangeRates."Relational Exch. Rate Amount"/ExchangeRates."Exchange Rate Amount";
              IF PurchInvHeader."Currency Factor"<> 0 THEN BEGIN
                TempLCY :=PurchInvLine.Amount/PurchInvHeader."Currency Factor";
              END ELSE BEGIN
                TempLCY :=PurchInvLine.Amount;
              END;
              EXIT(TempLCY/Rate);
            END;
          END ELSE BEGIN
            EXIT(PurchInvLine.Amount);
          END;
        END ELSE BEGIN
          ERROR('Charge Code %1 does Not have a posted purchase invoice',Charge);
        END;
        IF Rate = 0 THEN
        Rate:=1;
    end;

    local procedure GetExchangeRate(From: Code[10];Dates: Date) Rate: Decimal
    var
        ExchangeRates: Record "330";
    begin
        ExchangeRates.RESET;
        IF From<>'' THEN
        BEGIN
          ExchangeRates.SETRANGE(ExchangeRates."Currency Code",From);
          ExchangeRates.SETFILTER(ExchangeRates."Starting Date",'<=%1',Dates);
          IF ExchangeRates.FINDFIRST THEN
          BEGIN
          Rate:= (ExchangeRates."Relational Exch. Rate Amount");

          //MESSAGE('EX %1 curr %2',Rate,ExchangeRates."Currency Code");
          END ELSE BEGIN ERROR('No Exchange Rate Defined for %1 For Cur  %2',Dates,From);
          END;
          EXIT(Rate);
        END ELSE BEGIN
          ImportExportSetup.GET;
          ExchangeRates.SETRANGE(ExchangeRates."Currency Code",ImportExportSetup."Invoicing Currency Code");
          ExchangeRates.SETFILTER(ExchangeRates."Starting Date",'<=%1',Dates);
          IF ExchangeRates.FINDFIRST THEN
          BEGIN
          Rate:=ExchangeRates."Exchange Rate Amount"/ExchangeRates."Relational Exch. Rate Amount";

          //MESSAGE('EX %1 curr %2',Rate,ExchangeRates."Currency Code");
          END ELSE BEGIN ERROR('No Exchange Rate Defined for %1 For Cur  %2',Dates,From);
          END;
          EXIT(Rate);

        END;
    end;

    local procedure CountHAWs() Houses: Integer
    var
        number: Integer;
    begin
        number:=0;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
        IF SalesLine.FINDSET THEN
        BEGIN
          REPEAT
          number+=1;
          UNTIL SalesLine.NEXT=0;
        END;
        EXIT(number);
    end;

    local procedure "-----FWL-----"()
    begin
    end;

    procedure PostSalesInvoice()
    begin
        TESTFIELD("Sell-to Customer No.");
        TESTFIELD("Posting Description");
        TESTFIELD("Posting Date");
        TESTFIELD("External Document No.");
        TESTFIELD("MAWB No.");
        TESTFIELD("HAWB No.");
        /*CASE Status OF
         Status::Open:
         BEGIN
          ERROR(Text001,"No.");
         END;
         Status::"Pending Approval":
         BEGIN
          ERROR(Text002,"No.");
         END;
         Status::Released:
         BEGIN*/
          ImportExportSetup.GET;
          JournalTemplate:=ImportExportSetup."Sales Journal Template";
          JournalBatch:=ImportExportSetup."Sales Journal Batch";
        
          GenJnlLine.RESET;
          GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",JournalTemplate);
          GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",JournalBatch);
          GenJnlLine.DELETEALL;
        
          //*******INSERT CUSTOMER TRANSACTION************
          GenJnlLine.INIT;
          GenJnlLine."Journal Template Name":=JournalTemplate;
          GenJnlLine."Journal Batch Name":=JournalBatch;
          GenJnlLine."Document No.":= "No.";
          GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
          GenJnlLine."Posting Date":="Posting Date";
          GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
          GenJnlLine."External Document No.":="MAWB No.";
          GenJnlLine."Account Type":=GenJnlLine."Account Type"::Customer;
          GenJnlLine."Account No.":="Sell-to Customer No.";
          GenJnlLine.Description:="Posting Description";
          GenJnlLine."Currency Code":="Currency Code";
          GenJnlLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
          GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
          CALCFIELDS("Amount Including VAT");
          GenJnlLine.Amount:="Amount Including VAT";
        
          IF GenJnlLine.Amount<>0 THEN
          GenJnlLine.INSERT;
        
          //*******INSERT G/L TRANSACTION************
          SalesLine.RESET;
          SalesLine.SETRANGE("Document No.","No.");
          IF SalesLine.FINDSET THEN BEGIN
            REPEAT
              GenJnlLine."Journal Template Name":=JournalTemplate;
              GenJnlLine."Journal Batch Name":=JournalBatch;
              GenJnlLine."Document No.":= "No.";
              GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
              GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
              GenJnlLine."Posting Date":="Posting Date";
              GenJnlLine."External Document No.":="HAWB No.";
              GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
              GenJnlLine."Account No.":=SalesLine."No.";
              GenJnlLine.Description:=SalesLine.Description;
              GenJnlLine."Currency Code":="Currency Code";
              GenJnlLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
              GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
              GenJnlLine.Amount:=-SalesLine."Line Amount";
              IF GenJnlLine.Amount<>0 THEN
              GenJnlLine.INSERT;
        
            UNTIL SalesLine.NEXT=0;
          END;
        
          //*******INSERT VAT TRANSACTION************
        
          SalesLine.RESET;
          SalesLine.SETRANGE(SalesLine."Document No.","No.");
          SalesLine.SETFILTER(SalesLine."VAT Amount",'<>%1',0);
          IF SalesLine.FINDSET THEN BEGIN
            REPEAT
              GenJnlLine."Journal Template Name":=JournalTemplate;
              GenJnlLine."Journal Batch Name":=JournalBatch;
              GenJnlLine."Document No.":= "No.";
              GenJnlLine."Line No.":=GenJnlLine."Line No." + 1000;
              GenJnlLine."Posting Date":="Posting Date";
              GenJnlLine."External Document No.":="HAWB No.";
              GenJnlLine."Document Type":=GenJnlLine."Document Type"::Invoice;
              GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
              IF SalesLine.Type<>SalesLine.Type::" " THEN BEGIN
                VATPostingSetup.GET(SalesLine."VAT Bus. Posting Group",SalesLine."VAT Prod. Posting Group");
                GenJnlLine."Account No.":=VATPostingSetup."Sales VAT Account";
              END;
              GenJnlLine.Description:=SalesLine.Description+Text50000;
              GenJnlLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
              GenJnlLine."Shortcut Dimension 2 Code":="Shortcut Dimension 2 Code";
              GenJnlLine."Currency Code":="Currency Code";
              GenJnlLine.Amount:=-SalesLine."VAT Amount";
        
              IF GenJnlLine.Amount<>0 THEN
               GenJnlLine.INSERT;
        
            UNTIL SalesLine.NEXT=0;
          END;
        
          CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post",GenJnlLine);
            CustLedgEntry.RESET;
            CustLedgEntry.SETRANGE(CustLedgEntry."Document No.","No.");
            IF CustLedgEntry.FINDFIRST THEN BEGIN
              Posted:=TRUE;
              MODIFY;
            END;
          //END;
        //END;

    end;

    procedure CalculateMAWBCharges()
    var
        BookingSheetLine: Record "50054";
        Customer: Record "18";
        FreightCharge: Record "50018";
        HandlingSlab: Record "50045";
        TotalSales: Decimal;
        Items: Record "27";
        FreightCost: Decimal;
    begin
          /*IF CONFIRM(Text50002,FALSE,FIELDCAPTION("MAWB No."),"MAWB No.") THEN BEGIN
            TESTFIELD("MAWB No.");
            TESTFIELD("Sell-to Customer No.");
            Customer.RESET;
            Customer.SETRANGE("No.","Sell-to Customer No.");
            IF Customer.FINDFIRST THEN BEGIN
              IF Customer."Customer Type"=Customer."Customer Type"::Group THEN  BEGIN
              //=======CALCULATE FREIGHT CHARGES FOR THE ITEMS=============
              BookingSheetLine.RESET;
              BookingSheetLine.SETRANGE("MAWB No.","MAWB No.");
              BookingSheetLine.SETRANGE("Shipper Code","Sell-to Customer No.");
        
              IF BookingSheetLine.FINDFIRST THEN BEGIN
              FreightChargeByAirline.RESET;
              FreightChargeByAirline.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
              IF FreightChargeByAirline.FINDFIRST THEN BEGIN
                IF (BookingSheetLine."Booking Date"<FreightChargeByAirline."Effective Start Date") OR
                   (BookingSheetLine."Booking Date">FreightChargeByAirline."Effective End Date") THEN
                    ERROR(Text50004,BookingSheetLine.FIELDCAPTION("Booking Date"))
                ELSE BEGIN
                  FreightChargeByFlight.RESET;
                  FreightChargeByFlight.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                  FreightChargeByFlight.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                  FreightChargeByFlight.SETRANGE("Destination Code",BookingSheetLine."Destination Code");
                  IF FreightChargeByFlight.FINDFIRST THEN BEGIN
                    FreightChargeByItem.RESET;
                    FreightChargeByItem.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                    FreightChargeByItem.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                    FreightChargeByItem.SETRANGE("No.",BookingSheetLine."Item No.");
                    IF FreightChargeByItem.FINDFIRST THEN BEGIN
                      FreightItemCharge.RESET;
                      FreightItemCharge.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                      FreightItemCharge.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                      FreightItemCharge.SETRANGE("Item No.",BookingSheetLine."Item No.");
                      IF FreightItemCharge.FINDSET THEN BEGIN
                        REPEAT
                          MAWBInvoiceCharge.INIT;
                          MAWBInvoiceCharge."Invoice No.":="No.";
                          MAWBInvoiceCharge."MAWB No.":="MAWB No.";
                          MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                          MAWBInvoiceCharge."Freight Charge Code":=FreightItemCharge.Code;;
                          MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
                          MAWBInvoiceCharge.Description:=FreightItemCharge.Description;
                          MAWBInvoiceCharge."Unit Of Measure":=BookingSheetLine."Unit of Measure Code";
                          MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
        
             //=========GET DEFAULT MAWB CHARGES AMOUNT==============
                          MAWBReceipt.RESET;
                          MAWBReceipt.SETRANGE("MAWB No.","MAWB No.");
                          MAWBReceipt.SETRANGE("Freight Charge Code",FreightItemCharge.Code);
                          IF MAWBReceipt.FINDFIRST THEN BEGIN
                            MAWBInvoiceCharge."Unit Price":=MAWBReceipt."MAWB Fees";
                            MAWBInvoiceCharge."Cost Amount":=MAWBReceipt."MAWB Fees";
                            MAWBInvoiceCharge."Sales Amount Ex. VAT":=MAWBReceipt."MAWB Fees";
                            MAWBInvoiceCharge."Sales Amount Inc. VAT":=MAWBReceipt."MAWB Fees";
                          END;
        
                          CostAmount:=0;
                          SalesAmount:=0;
                          VATAmount:=0;
                          MarginAmount:=0;
                          FreightItemChargeMatrix.RESET;
                          FreightItemChargeMatrix.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                          FreightItemChargeMatrix.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                          FreightItemChargeMatrix.SETRANGE("Item No.",BookingSheetLine."Item No.");
                          FreightItemChargeMatrix.SETRANGE("Freight Charge Code",FreightItemCharge.Code);
                          IF FreightItemChargeMatrix.FINDSET THEN BEGIN
                            REPEAT
                            IF (BookingSheetLine."Actual Weight">=FreightItemChargeMatrix."From Weight") AND (BookingSheetLine."Actual Weight"<=FreightItemChargeMatrix."To Weight") THEN BEGIN
                              IF FreightItemCharge.Calculation=FreightItemCharge.Calculation::Calculated THEN BEGIN
                                MAWBInvoiceCharge."Unit Price":=FreightItemChargeMatrix."Rate Amount";
                                CostAmount:=BookingSheetLine."Actual Weight"*FreightItemChargeMatrix."Rate Amount";
                                MAWBInvoiceCharge."Cost Amount":=CostAmount;
                                MAWBInvoiceCharge."Currency Code":=FreightItemChargeMatrix."Currency Code";
        
                                FreightCharge.GET(FreightItemCharge.Code);
                                MAWBInvoiceCharge."Margin %":=FreightCharge."Margin %";
                                MarginAmount:=(FreightCharge."Margin %"*CostAmount)/100;
                                MAWBInvoiceCharge."Sales Amount Ex. VAT":=(CostAmount+MarginAmount);
                                VATPostingSetup.GET(FreightCharge."VAT Bus. Posting Group",FreightCharge."VAT Prod. Posting Group");
                                VATAmount:=(VATPostingSetup."VAT %"*(CostAmount+MarginAmount))/100;
                                MAWBInvoiceCharge."VAT %":=VATPostingSetup."VAT %";
                                MAWBInvoiceCharge."VAT Amount":=VATAmount;
                                MAWBInvoiceCharge."Sales Amount Inc. VAT":=(CostAmount+MarginAmount+VATAmount)
                               END
                              END ELSE IF FreightItemCharge.Calculation=FreightItemCharge.Calculation::"Flat Rate" THEN BEGIN
                                MAWBInvoiceCharge."Unit Price":=FreightItemChargeMatrix."Rate Amount";
                                CostAmount:=FreightItemChargeMatrix."Rate Amount";
                                MAWBInvoiceCharge."Cost Amount":=CostAmount;
                                MAWBInvoiceCharge."Currency Code":=FreightItemChargeMatrix."Currency Code";
        
                                FreightCharge.GET(FreightItemCharge.Code);
                                MAWBInvoiceCharge."Margin %":=FreightCharge."Margin %";
                                MarginAmount:=(FreightCharge."Margin %"*CostAmount)/100;
                                MAWBInvoiceCharge."Sales Amount Ex. VAT":=CostAmount+MarginAmount;
                                VATPostingSetup.GET(FreightCharge."VAT Bus. Posting Group",FreightCharge."VAT Prod. Posting Group");
                                VATAmount:=(VATPostingSetup."VAT %"*(CostAmount+MarginAmount))/100;
                                MAWBInvoiceCharge."VAT %":=VATPostingSetup."VAT %";
                                MAWBInvoiceCharge."VAT Amount":=VATAmount;
                                MAWBInvoiceCharge."Sales Amount Inc. VAT":=(CostAmount+MarginAmount+VATAmount)
                            END;
        
                            UNTIL FreightItemChargeMatrix.NEXT=0;
                          END;
                         MAWBInvoiceCharge.INSERT;
                        UNTIL FreightItemCharge.NEXT=0;
                      END;
                    END;
                   END;
                 END;
                END;
              END;
           END ELSE
          IF Customer."Customer Type"=Customer."Customer Type"::"Third Party" THEN  BEGIN
              BookingSheetLine.RESET;
              BookingSheetLine.SETRANGE("MAWB No.","MAWB No.");
              BookingSheetLine.SETRANGE("Shipper Code","Sell-to Customer No.");
              IF BookingSheetLine.FINDFIRST THEN BEGIN
                Items.GET(BookingSheetLine."Item No.");
                TotalSales:=BookingSheetLine."Actual Weight"*Items."Kilo Rate";
                FreightCost:=TotalSales;
                FreightCharge.RESET;
                FreightCharge.SETFILTER("Customer Type",'%1|%2',FreightCharge."Customer Type"::"Third Party",FreightCharge."Customer Type"::Both);
                FreightCharge.SETRANGE("Freight Cost",FALSE);
                IF FreightCharge.FINDSET THEN BEGIN
                  REPEAT
                    MAWBInvoiceCharge.INIT;
                    MAWBInvoiceCharge."Invoice No.":="No.";
                    MAWBInvoiceCharge."MAWB No.":="MAWB No.";
                    MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                    MAWBInvoiceCharge."Freight Charge Code":=FreightCharge.Code;;
                    MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
                    MAWBInvoiceCharge.Description:=FreightCharge.Description;
                    MAWBInvoiceCharge."Unit Of Measure":=BookingSheetLine."Unit of Measure Code";
                    MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                    MAWBInvoiceCharge."Unit Price":=FreightCharge."Flat Rate";
                    MAWBInvoiceCharge."Cost Amount":=FreightCharge."Flat Rate";
                    MAWBInvoiceCharge."Sales Amount Ex. VAT":=FreightCharge."Flat Rate";
                    MAWBInvoiceCharge."Sales Amount Inc. VAT":=FreightCharge."Flat Rate";
                    FreightCost:=FreightCost-FreightCharge."Flat Rate";
                    //=========GET DEFAULT MAWB CHARGES AMOUNT==============
                    MAWBReceipt.RESET;
                    MAWBReceipt.SETRANGE("MAWB No.","MAWB No.");
                    MAWBReceipt.SETRANGE("Freight Charge Code",FreightCharge.Code);
                    IF MAWBReceipt.FINDFIRST THEN BEGIN
                      MAWBInvoiceCharge."Unit Price":=MAWBReceipt."MAWB Fees";
                      MAWBInvoiceCharge."Cost Amount":=MAWBReceipt."MAWB Fees";
                      MAWBInvoiceCharge."Sales Amount Ex. VAT":=MAWBReceipt."MAWB Fees";
                      MAWBInvoiceCharge."Sales Amount Inc. VAT":=MAWBReceipt."MAWB Fees";
                      FreightCost:=FreightCost-MAWBReceipt."MAWB Fees";
                    END;
                    CostAmount:=0;
                    SalesAmount:=0;
                    VATAmount:=0;
                    MarginAmount:=0;
                    HandlingSlab.RESET;
                    HandlingSlab.SETRANGE("Freight Charge Code",FreightCharge.Code);
                    IF HandlingSlab.FINDSET THEN BEGIN
                     REPEAT
                      IF (BookingSheetLine."Actual Weight">=HandlingSlab."From Weight") AND (BookingSheetLine."Actual Weight"<=HandlingSlab."To Weight") THEN BEGIN
                       MAWBInvoiceCharge."Unit Price":=HandlingSlab."Rate Amount";
                       CostAmount:=HandlingSlab."Rate Amount";
                       MAWBInvoiceCharge."Cost Amount":=CostAmount;
                       MAWBInvoiceCharge."Currency Code":=FreightItemChargeMatrix."Currency Code";
                       MAWBInvoiceCharge."Sales Amount Ex. VAT":=CostAmount;
                       VATPostingSetup.GET(FreightCharge."VAT Bus. Posting Group",FreightCharge."VAT Prod. Posting Group");
                       VATAmount:=(VATPostingSetup."VAT %"*(CostAmount))/100;
                       MAWBInvoiceCharge."VAT %":=VATPostingSetup."VAT %";
                       MAWBInvoiceCharge."VAT Amount":=VATAmount;
                       MAWBInvoiceCharge."Sales Amount Inc. VAT":=(CostAmount+VATAmount);
                       FreightCost:=FreightCost-MAWBInvoiceCharge."Sales Amount Inc. VAT";
                      END;
                     UNTIL HandlingSlab.NEXT=0;
                    END;
                  MAWBInvoiceCharge.INSERT;
                  UNTIL FreightCharge.NEXT=0;
               END;
              END;
                FreightCharge.RESET;
                FreightCharge.SETFILTER("Customer Type",'%1|%2',FreightCharge."Customer Type"::"Third Party",FreightCharge."Customer Type"::Both);
                FreightCharge.SETRANGE("Freight Cost",TRUE);
                IF FreightCharge.FINDSET THEN BEGIN
                 REPEAT
                 MAWBInvoiceCharge.INIT;
                 MAWBInvoiceCharge."Invoice No.":="No.";
                 MAWBInvoiceCharge."MAWB No.":="MAWB No.";
                 MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                 MAWBInvoiceCharge."Freight Charge Code":=FreightCharge.Code;;
                 MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
                 MAWBInvoiceCharge.Description:=FreightCharge.Description;
                 MAWBInvoiceCharge."Unit Of Measure":=BookingSheetLine."Unit of Measure Code";
                 MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                 MAWBInvoiceCharge."Unit Price":=FreightCost;
                 MAWBInvoiceCharge."Cost Amount":=FreightCost;
                 MAWBInvoiceCharge."Sales Amount Ex. VAT":=FreightCost;
                 MAWBInvoiceCharge."Sales Amount Inc. VAT":=FreightCost;
                 MAWBInvoiceCharge.INSERT;
                 UNTIL FreightCharge.NEXT=0;
                END;
             END;
            END;
          END ELSE
         EXIT;
                 */

    end;

    procedure SplitMAWBInvoice()
    var
        BookingSheetLine: Record "50054";
        BookedWeight: Decimal;
        Customer: Record "18";
    begin
        //==========SPLIT THE INVOICE============
        IF CONFIRM(Text50003,FALSE,FIELDCAPTION("MAWB No."),"MAWB No.") THEN BEGIN
          BookedWeight := 0;
          MAWBInCharg.RESET;
          MAWBInCharg.SETRANGE(MAWBInCharg."MAWB No.","MAWB No.");
          IF MAWBInCharg.FINDSET THEN
            REPEAT
              BookedWeight += MAWBInCharg."Chargeable Weight";
            UNTIL MAWBInCharg.NEXT = 0;
          IF BookedWeight = 0 THEN BEGIN
            MAWBLine4.RESET;
            MAWBLine4.SETRANGE(MAWBLine4."MAWB No.","MAWB No.");
            IF MAWBLine4.FINDSET THEN
              REPEAT
                BookedWeight += MAWBLine4."Chargeable Weight";
              UNTIL MAWBLine4.NEXT =0;
          END;

          IF NOT SalesLinesExist THEN
            ERROR(Text50001,"Document Type","No.")
          ELSE BEGIN
            REPEAT
              SplitWeight := SalesLine."Split Weight";
              SplitFactor := 0;
              MAWBInvoiceCharge.RESET;
              MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.","MAWB No.");
              MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."Freight Charge Code",SalesLine."Freight Charge Code");
              IF MAWBInvoiceCharge.FINDFIRST THEN BEGIN
                "Freight Charg".RESET;
                "Freight Charg".GET(MAWBInvoiceCharge."Freight Charge Code");
                IF "Freight Charg"."Split On" = "Freight Charg"."Split On"::Weights THEN BEGIN
                  IF SplitFactor = 0 THEN
                    SplitFactor := 1;
                  SplitFactor := (SplitWeight/BookedWeight);
                  SplitAmount := MAWBInvoiceCharge."Cost Amount" * SplitFactor;
                END ELSE BEGIN
                  Hawbs := 0;
                  HAWBLines.RESET;
                  HAWBLines.SETRANGE(HAWBLines."MAWB No.",MAWBInvoiceCharge."MAWB No.");
                  IF HAWBLines.FINDSET THEN
                    REPEAT
                      Hawbs := Hawbs + 1;
                    UNTIL HAWBLines.NEXT=0;

                  SplitFactor := Hawbs;

                  IF SplitFactor = 0 THEN
                    SplitFactor := 1;

                  SplitAmount := MAWBInvoiceCharge."Cost Amount"/SplitFactor;
                END;//Split on Weights
                SalesLine."Document Type" := "Document Type";
                SalesLine."Document No." := "No.";
                SalesLine."Split Factor":= SplitFactor;
                SalesLine.Quantity :=1;
                SalesLine."Qty. to Ship" := SalesLine.Quantity;
                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                SalesLine."Qty. to Assign" := SalesLine.Quantity;
                SalesLine."Qty. Assigned" := SalesLine.Quantity;
                SalesLine."Customer Price Group" := "Customer Price Group";
                SalesLine."Cost Amount" := SplitAmount;
                FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");
                IF FreightCharge."Margin Applicable" THEN BEGIN
                  Cust.GET("Bill-to Customer No.");
                  SalesLine."Margin %" := Cust."Margin %";
                  IF Cust."Customer Type" = Cust."Customer Type"::Group THEN
                    SalesLine."Margin Amount" := (Cust."Margin %"/100) * SalesLine."Cost Amount"
                  ELSE BEGIN
                    MAWBInvoiceCharge.RESET;
                    MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.","MAWB No.");
                    IF MAWBInvoiceCharge.FINDSET THEN
                      REPEAT
                        IF "Freight Charg".GET(MAWBInvoiceCharge."Freight Charge Code") THEN
                          IF "Freight Charg"."Margin Applicable" THEN
                            SalesLine."Margin Amount" := ((Cust."Margin %" + MAWBInvoiceCharge."Agreed Rate") * MAWBInvoiceCharge."Chargeable Weight")
                                                         - MAWBInvoiceCharge."Base Unit Price";
                      UNTIL MAWBInvoiceCharge.NEXT = 0;
                  END;
                END;
                SalesLine."Line Amount":=SalesLine."Cost Amount"+SalesLine."Margin Amount";
                SalesLine."Unit Price":= SalesLine."Cost Amount"+SalesLine."Margin Amount";
                SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                SalesLine.VALIDATE("VAT Prod. Posting Group");
                SalesLine.VALIDATE("VAT %");
                ImportExportSetup.GET();
                SalesLine.VALIDATE("Currency Code",ImportExportSetup."Invoicing Currency Code");
                GLAccount.GET(SalesLine."No.");
                SalesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                Customer.GET("Sell-to Customer No.");
                SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                SalesLine.MODIFY;
              END ELSE BEGIN //IF Charge code not found on Invoice charges
                "Freight Charg".RESET;
                "Freight Charg".GET(SalesLine."Freight Charge Code");
                IF "Freight Charg"."Split On" = "Freight Charg"."Split On"::Weights THEN BEGIN
                  IF SplitFactor = 0 THEN
                    SplitFactor:=1
                  ELSE
                    SplitFactor := (SplitWeight/BookedWeight);
                    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ exchange rate--------------- if currency is not KHS
                  IF (SalesLine.TBLCurrency = 'EUR') OR (SalesLine.TBLCurrency = 'GBP') OR (SalesLine.TBLCurrency = 'USD') THEN BEGIN
                    TBLAmountLCY := 0;
                    TBLAmountUSD := 0;
                    TBLExchangeRate.RESET;//TBLBT
                    TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");  //TBLBT
                    TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",SalesLine.TBLCurrency);
                    IF TBLExchangeRate.FINDLAST THEN BEGIN
                      TBLAmountLCY := SalesLine."Cost Amount" * TBLExchangeRate."Relational Exch. Rate Amount";
                      TBLExchangeRate.RESET;//TBLBT
                      TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");  //TBLBT
                      TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",'USD');
                      IF TBLExchangeRate.FINDLAST THEN BEGIN
                        TBLAmountUSD := TBLAmountLCY / TBLExchangeRate."Relational Exch. Rate Amount";
                        SplitAmount := TBLAmountUSD * (SalesLine."Split Weight") / ("Total Weight");//TBLAMountUSD * SplitFactor;
                      END;
                    END;
                  END ELSE BEGIN // ------------- if currency is KHS
                    TBLAmountUSD := 0;
                    TBLExchangeRate.RESET;//TBLBT
                    TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");  //TBLBT
                    TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",'USD');
                    IF TBLExchangeRate.FINDLAST THEN BEGIN
                      //TBLAmountUSD := SalesLine."Cost Amount" / TBLExchangeRate."Relational Exch. Rate Amount"; // Not properly calculating the USD amounts due to cost amount
                      TBLAmountUSD := SalesLine."Unit Cost (LCY)" / TBLExchangeRate."Relational Exch. Rate Amount";
                      SplitAmount := TBLAmountUSD * (SalesLine."Split Weight") / ("Total Weight");//TBLAmountUSD * SplitFactor;
                    END;
                  END;
                  //^^^^^^^^^^^end of exchange rate
                END ELSE BEGIN //If Charge code not split by weights
                  SplitAmount:=0;
                  Hawbs:=0;
                  HAWBLines.RESET;
                  HAWBLines.SETRANGE(HAWBLines."MAWB No.",MAWBInvoiceCharge."MAWB No.");
                  IF HAWBLines.FINDSET THEN
                    REPEAT
                      Hawbs:=Hawbs+1;
                    UNTIL HAWBLines.NEXT=0;

                  SplitFactor:=Hawbs;
                  IF SplitFactor = 0 THEN
                    SplitFactor:=1;

                  //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ exchange rate -------------------------- if currency is not KHS
                  IF (SalesLine.TBLCurrency = 'EUR') OR (SalesLine.TBLCurrency = 'GBP') OR (SalesLine.TBLCurrency = 'USD') THEN BEGIN
                    TBLAmountLCY := 0;
                    TBLAmountUSD := 0;
                    TBLExchangeRate.RESET;//TBLBT
                    TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");  //TBLBT
                    TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",SalesLine.TBLCurrency);
                    IF TBLExchangeRate.FINDLAST THEN BEGIN
                      TBLAmountLCY := SalesLine."Cost Amount" * TBLExchangeRate."Relational Exch. Rate Amount";
                      TBLExchangeRate.RESET;
                      TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");//TBLBT
                      TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",'USD');
                      IF TBLExchangeRate.FINDLAST THEN BEGIN
                        TBLAmountUSD := TBLAmountLCY / TBLExchangeRate."Relational Exch. Rate Amount";
                        SplitAmount := TBLAmountUSD * (SalesLine."Split Weight") / ("Total Weight");//TBLAmountUSD / SplitFactor;
                      END;
                    END;
                  END ELSE BEGIN
                    TBLAmountUSD := 0;
                    TBLExchangeRate.RESET;
                    TBLExchangeRate.SETFILTER("Starting Date",'<=%1',"Posting Date");//TBLBT
                    TBLExchangeRate.SETFILTER(TBLExchangeRate."Currency Code",'USD');
                    IF TBLExchangeRate.FINDLAST THEN BEGIN
                      //TBLAmountUSD := SalesLine."Cost Amount" / TBLExchangeRate."Relational Exch. Rate Amount"; // Not properly calculating the USD amounts due to cost amount
                      TBLAmountUSD := SalesLine."Unit Cost (LCY)" / TBLExchangeRate."Relational Exch. Rate Amount";
                      SplitAmount := TBLAmountUSD * (SalesLine."Split Weight") / ("Total Weight");//TBLAmountUSD / SplitFactor;
                    END;
                  END;//^^^^^^^^^^end of exchange rate
                END;//Split on Weights

                SalesLine."Cost Amount" := SplitAmount;
                SalesLine."Document Type":="Document Type";
                SalesLine."Document No.":="No.";
                SalesLine."Split Factor":=SplitFactor;
                SalesLine.Quantity:=1;
                SalesLine."Qty. to Ship":=SalesLine.Quantity;
                SalesLine."Qty. to Invoice":=SalesLine.Quantity;
                SalesLine."Qty. to Assign":=SalesLine.Quantity;
                SalesLine."Qty. Assigned":=SalesLine.Quantity;
                SalesLine."Customer Price Group" :="Customer Price Group";
                SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                SalesLine."Line Amount":=SalesLine."Cost Amount";
                SalesLine."Unit Price":=SalesLine."Cost Amount" ;
                SalesLine.VALIDATE("VAT %");
                SalesLine.VALIDATE("VAT Prod. Posting Group");
                ImportExportSetup.GET();
                SalesLine.VALIDATE("Currency Code",ImportExportSetup."Invoicing Currency Code");
                GLAccount.GET(SalesLine."No.");
                SalesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
                Customer.GET("Sell-to Customer No.");
                SalesLine."Gen. Bus. Posting Group":=Customer."Gen. Bus. Posting Group";
                IF Item.GET(MAWBInvoiceCharge."Item No.") THEN;
                SalesLine."Product Group Code":=Item."Product Group Code";
                SalesLine.VALIDATE(Quantity);
                SalesLine.MODIFY;
              END;
          UNTIL SalesLine.NEXT=0;
          SetDim.SetDimensions("MAWB No.","Sell-to Customer No.");  ///old code
        END;
        END ELSE
        EXIT;
    end;

    procedure InsertUnrecoveredCharges()
    var
        UnrecoveredCharges: Record "50006";
        Text001: Label 'Are you sure you want to include charges from petty cash and LPO';
        SalesHeader: Record "36";
        Text002: Label 'Invoice Sales Lines has been updated';
        SalesLine: Record "37";
        Text003: Label 'Nothing to recover';
    begin
        IF CONFIRM(Text001) THEN BEGIN
          SalesLine5.RESET;
          SalesLine5.SETFILTER(SalesLine5."Line No.",'>%1',0);
          IF SalesLine5.FIND('+') THEN BEGIN
           LineNo:=SalesLine5."Line No."+10000;
          END;
          UnrecoveredCharges.RESET;
          UnrecoveredCharges.SETRANGE(UnrecoveredCharges."MAWB No","Import MAWB No.");
          UnrecoveredCharges.SETRANGE(UnrecoveredCharges.Recovered,FALSE);
          IF  UnrecoveredCharges.FINDSET THEN BEGIN
          REPEAT
           SalesLine.INIT;
           SalesLine."Document Type":="Document Type";
           SalesLine."Document No.":="No.";
           SalesLine."Line No.":=LineNo;
           SalesLine.Type:=SalesLine.Type::"G/L Account";
           SalesLine.VALIDATE("No.",UnrecoveredCharges."No.");
           SalesLine.Description:=UnrecoveredCharges.Description;
           SalesLine.Quantity:=1;
           SalesLine."Unit Price":=UnrecoveredCharges.Amount;
           SalesLine.VALIDATE(SalesLine."Unit Price");
           SalesLine."Line Amount":=UnrecoveredCharges."Line Amount";
           SalesLine.VALIDATE(SalesLine."Line Amount");
           SalesLine."Currency Code":=UnrecoveredCharges."Currency Code";
           SalesLine.VALIDATE(SalesLine."Currency Code");
           SalesLine."MAWB No.":=UnrecoveredCharges."MAWB No";
           SalesLine."Consignee Code":='';
           SalesLine."Unit of Measure Code":='';
           //"Flight Code":=MAWBLine."Flight Code";
           //"Destination Code":=MAWBLine."Destination Code";
           //"Flight Date":=PreAlertHeader."Actual Arrival Date";
           SalesLine."Qty. to Ship":=SalesLine.Quantity;
           SalesLine."Qty. to Invoice":=SalesLine.Quantity;
           SalesLine."Qty. to Assign":=SalesLine.Quantity;
           SalesLine."Qty. Assigned":=SalesLine.Quantity;
           SalesLine."Customer Price Group" :="Customer Price Group";
           SalesLine."Customer Disc. Group" :="Customer Disc. Group";
           SalesLine."Allow Line Disc." := "Allow Line Disc.";
           SalesLine."Transaction Type" := "Transaction Type";
           SalesLine."Transport Method" := "Transport Method";
           SalesLine."Bill-to Customer No." := "Bill-to Customer No.";
           SalesLine."Exit Point" := "Exit Point";
           GLAccount.GET(UnrecoveredCharges."No.");
           SalesLine."Gen. Prod. Posting Group" := GLAccount."Gen. Prod. Posting Group";
           SalesLine."VAT Prod. Posting Group" := GLAccount."VAT Prod. Posting Group";
           SalesLine."Gen. Bus. Posting Group" := GLAccount."Gen. Bus. Posting Group";
           SalesLine."VAT Bus. Posting Group" := GLAccount."VAT Bus. Posting Group";

           //SalesLine.TESTFIELD(SalesLine."Gen. Prod. Posting Group");
           SalesLine.INSERT;
           LineNo:=LineNo+10000;
           UnrecoveredCharges.Recovered:=TRUE;
           UnrecoveredCharges.MODIFY;
          UNTIL  UnrecoveredCharges.NEXT=0;
          MESSAGE(Text002);
          END ELSE
          MESSAGE(Text003);
         END;
    end;

    var
        MAWBInCharg: Record "50073";
        AmmendCharge: Codeunit "50031";
        GPHeader: Record "50068";
        ShippedWeight: Decimal;
        GatePassLine: Record "50069";
        Offload: Record "50065";
        SetDim: Codeunit "50028";
        DimVal: Record "349";
        TempDimSetEntry: Record "480" temporary;
        MAWBLine7: Record "50076";
        SalesLine2: Record "37";
        HasHouses: Boolean;
        HAWBLines: Record "50074";
        LoadingSheetHeader: Record "50060";
        SplitWeight: Decimal;
        SplitAmount: Decimal;
        MAWBLine4: Record "50076";
        Hawbs: Integer;
        "Freight Charg": Record "50018";

    var
        BookingSheetHAWBAllocation: Record "50056";
        Item: Record "27";
        BookingSheetLine: Record "50054";
        MAWBReceipt: Record "50039";
        FreightCharge: Record "50018";
        HAWBHeader: Record "50075";
        ImportExportSetup: Record "50010";
        JournalTemplate: Code[20];
        JournalBatch: Code[20];
        GenJnlLine: Record "81";
        VATPostingSetup: Record "325";
        Currency: Record "4";
        Text50000: Label '-VAT';
        MAWBHeader: Record "50077";
        MAWBLine: Record "50076";
        FreightChargeByAirline: Record "50025";
        FreightChargeByFlight: Record "50026";
        FreightChargeByItem: Record "50027";
        FreightItemCharge: Record "50028";
        FreightItemChargeMatrix: Record "50029";
        MAWBInvoiceCharge: Record "50073";
        CostAmount: Decimal;
        SalesAmount: Decimal;
        VATAmount: Decimal;
        MarginAmount: Decimal;
        SplitCostAmount: Decimal;
        SplitSalesAmountExVAT: Decimal;
        SplitVATAmount: Decimal;
        SplitMarginAmount: Decimal;
        SplitSalesAmountIncVAT: Decimal;
        SplitFactor: Decimal;
        Text50001: Label '%1 %2 does not have any lines';
        Text50002: Label 'Do you want to calculate total charges for %1 %2?';
        Text50003: Label 'Do you want to split %1 %2?';
        MAWBInvoiceNotifyParty: Record "50072";
        NotifyParty: Record "50017";
        Text50004: Label 'The booking date is not within the allowed flight charge effective dates';
        PreAlertHeader: Record "50030";
        PreAlertLine: Record "50023";
        Customer: Record "18";
        ImportChargeMaster: Record "50007";
        GLAccount: Record "15";
        SalesLine5: Record "37";
        LineNo: Integer;
        BookingSheetLine2: Record "50054";
        HAWBHeader2: Record "50075";
        "Count": Integer;
        MAWBLine2: Record "50076";
        DivisionFactor: Decimal;
        MAWBAlloc: Record "50070";
        TBLExchangeRate: Record "330";
        TBLAmountLCY: Decimal;
        TBLAmountUSD: Decimal;
}

