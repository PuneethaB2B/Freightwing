tableextension 70000020 tableextension70000020 extends "Sales Line"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on "Description(Field 11)".


        //Unsupported feature: Property Insertion (Editable) on ""Line Discount %"(Field 27)".


        //Unsupported feature: Property Insertion (Editable) on ""Line Discount Amount"(Field 28)".


        //Unsupported feature: Property Insertion (Editable) on ""Line Amount"(Field 103)".


        //Unsupported feature: Property Modification (Data type) on ""Product Group Code"(Field 5712)".


        //Unsupported feature: Code Insertion on ""VAT %"(Field 25)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        "VAT Amount":=("VAT %"/100)*"Cost Amount";
        "Line Amount":="Line Amount"+"VAT Amount";
        */
        //end;

        //Unsupported feature: Property Deletion (Editable) on ""VAT %"(Field 25)".



        //Unsupported feature: Code Modification on ""Line Amount"(Field 103).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        TESTFIELD("Unit Price");
        GetSalesHeader;
        "Line Amount" := ROUND("Line Amount",Currency."Amount Rounding Precision");
        VALIDATE(
          "Line Discount Amount",ROUND(Quantity * "Unit Price",Currency."Amount Rounding Precision") - "Line Amount");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Type);
        TESTFIELD(Quantity);
        //TESTFIELD("Unit Price");
        #4..7
        */
        //end;
        field(50000; "MAWB No."; Code[20])
        {
            Editable = false;
            TableRelation = "HAWB Header".No.;
        }
        field(50001; "HAWB No."; Code[20])
        {
            Editable = false;
            TableRelation = "HAWB Header".No.;
        }
        field(50002; "Division Code"; Code[20])
        {
            TableRelation = Division/Farm.Code;
        }
        field(50003;"Split Weight";Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(50004;"Airline Code";Code[20])
        {
            TableRelation = Airline;
        }
        field(50005;"Consignee Code";Code[20])
        {
            TableRelation = Consignee;
        }
        field(50006;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE (Airline Code=FIELD(Airline Code));
        }
        field(50007;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(50008;"Flight Date";Date)
        {
        }
        field(50009;"VAT Amount";Decimal)
        {
            Editable = false;
        }
        field(50010;"Cost Amount";Decimal)
        {

            trigger OnValidate()
            begin
                VALIDATE("VAT %");
                VALIDATE("Unit Price","Cost Amount");
            end;
        }
        field(50011;"Freight Charge Code";Code[20])
        {
            TableRelation = "Freight Charge".Code;

            trigger OnValidate()
            begin
                Charges.GET("Freight Charge Code");
                "No.":=Charges."G/L Account";
                Description:= Charges.Description;
            end;
        }
        field(50012;"Split Factor";Decimal)
        {
        }
        field(50013;"Freight Cost";Boolean)
        {
            CalcFormula = Lookup("Freight Charge"."Freight Cost" WHERE (Code=FIELD(Freight Charge Code)));
            FieldClass = FlowField;
        }
        field(50014;"Margin %";Decimal)
        {
            DecimalPlaces = 5:5;

            trigger OnValidate()
            begin
                FreightCharge.GET("Freight Charge Code");
                FreightCharge.TESTFIELD(FreightCharge."Margin Applicable",TRUE);
                 IF SalesHeader.GET("Document Type","Document No.") THEN
                 BEGIN
                  Cust.GET(SalesHeader."Bill-to Customer No.");
                  IF Cust."Customer Type"=Cust."Customer Type"::Group THEN
                  BEGIN
                    FIELDERROR("Margin %",' Cannot be Edited for Group Customers');
                  END ELSE
                  BEGIN
                    MAWBInvoiceCharge.RESET;
                    MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.","MAWB No.");
                    MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."Freight Charge Code","Freight Charge Code");
                    IF MAWBInvoiceCharge.FINDFIRST THEN
                    BEGIN
                      Margn:=(("Margin %"+MAWBInvoiceCharge."Agreed Rate")*MAWBInvoiceCharge."Chargeable Weight")-MAWBInvoiceCharge."Base Unit Price";
                      "Margin Amount":=Margn;
                      VALIDATE(Amount,"Margin Amount"+"Cost Amount");
                      VALIDATE("Line Amount","Margin Amount"+"Cost Amount");
                      VALIDATE("Amount Including VAT","Margin Amount"+"Cost Amount");
                      VALIDATE("Amount Including VAT");
                      VALIDATE("VAT %");
                      VALIDATE("VAT Prod. Posting Group");
                      VALIDATE("Currency Code");
                      MODIFY();
                      //MESSAGE('Agreed Rate %1, New Rate %2, Total %3 Margin Amnt %4',MAWBInvoiceCharge."Agreed Rate","Margin %",(xRec."Margin %"+MAWBInvoiceCharge."Agreed Rate"));
                    END;
                  END;
                END;
            end;
        }
        field(50015;"Margin Amount";Decimal)
        {
        }
        field(50016;"Freight Handling Type";Option)
        {
            OptionCaption = 'Custom bond fees, Handling charges Agent, Security Screening Charges, Export BUP charges, Other charges';
            OptionMembers = "Custom bond fees"," Handling charges Agent"," Security Screening Charges"," Export BUP charges"," Other charges";
        }
        field(50017;"Agreed Rate";Decimal)
        {
        }
        field(50018;"Total weight";Decimal)
        {
        }
        field(50019;"Total Amount Incl. VAT";Decimal)
        {
        }
        field(50020;"Total Amount Excl. VAT";Decimal)
        {
        }
        field(50021;TBLCurrency;Code[10])
        {
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TestStatusOpen;
        IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
           (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
        #4..67
            SalesLine2.MODIFY;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..70

        //********EXPORT PROCESS*******
        IF "Document Type"="Document Type"::Invoice THEN  BEGIN
          MAWBLine.RESET;
          MAWBLine.SETRANGE("MAWB No.","MAWB No.");
          MAWBLine.SETRANGE("HAWB No.","HAWB No.");
          MAWBLine.SETRANGE("Item No.","No.");
          IF MAWBLine.FINDFIRST THEN BEGIN
            MAWBLine."Invoice No.":='';
            MAWBLine.MODIFY;
          END;
        END;
        */
    //end;

    var
        Header: Record "36";
        FreightCharge: Record "50018";
        Margn: Decimal;
        SalesLine: Record "37";
        MAWBInvoiceCharge: Record "50073";
        Cust: Record "18";
        Charges: Record "50018";

    var
        BookingSheetHAWBAllocation: Record "50056";
        MAWBLine: Record "50076";
}

