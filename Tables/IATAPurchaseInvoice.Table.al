table 50016 "IATA Purchase Invoice"
{
    Caption = 'IATA Invoice';

    fields
    {
        field(1; "Airline Invoice Date"; Date)
        {
        }
        field(2; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No.";
        }
        field(5; "Weight As Per FWL"; Decimal)
        {
        }
        field(6; "Amount As Per FWL"; Decimal)
        {
        }
        field(7; "Rate Per Kilo As Per FWL"; Decimal)
        {
        }
        field(8; "Weight as per Airline"; Decimal)
        {
            Caption = 'Airline Weight';

            trigger OnValidate()
            begin
                "Difference in Weight" := "Weight As Per FWL" - "Weight as per Airline";
            end;
        }
        field(9; "Amount as per Airline"; Decimal)
        {
            Caption = 'Airline Amount';

            trigger OnValidate()
            begin
                "Difference In Amount" := "Amount As Per FWL" - "Amount as per Airline";
            end;
        }
        field(10; "Airline Kilo Rate"; Decimal)
        {
            Caption = 'Airline Kilo Rate';

            trigger OnValidate()
            begin
                //"Rate Per Kilo As Per IATA":= "Weight As Per IATA"/"Amount As Per IATA";
                "Rate Difference" := "Rate Per Kilo As Per FWL" - "Airline Kilo Rate";
            end;
        }
        field(11; "Difference in Weight"; Decimal)
        {
        }
        field(12; "Rate Difference"; Decimal)
        {
        }
        field(13; "Difference In Amount"; Decimal)
        {
        }
        field(14; Comments; Text[50])
        {
        }
        field(15; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(16; "Vendor No."; Code[20])
        {
            TableRelation = Vendor.No.;

            trigger OnValidate()
            begin
                IF Vendors.GET("Vendor No.") THEN
                BEGIN
                 "Vendor Name":=Vendors.Name;
                END;
            end;
        }
        field(17;"Vendor Name";Text[50])
        {
        }
        field(19;"Billing Start Date";Date)
        {
        }
        field(20;"Billing End Date";Date)
        {
        }
        field(21;"Airline Invoice No";Code[20])
        {
            Caption = 'Airline Invoice No';
        }
        field(22;Converted;Boolean)
        {
        }
        field(23;"Purchase Invoice No.";Code[20])
        {
        }
        field(24;"Airline Code";Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                IF Airlines.GET("Airline Code") THEN
                "Airline Name":=Airlines.Name;
            end;
        }
        field(25;"Purchase A/C Code";Code[20])
        {
        }
        field(26;Reconciled;Boolean)
        {
        }
        field(27;Currency;Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(28;"Airline Name";Text[30])
        {
        }
        field(29;"Imported By";Code[59])
        {
            Editable = false;
        }
        field(30;"Processed By";Code[50])
        {
            Editable = false;
        }
        field(31;"Imported On";Date)
        {
            Editable = false;
        }
        field(32;"Processed On";Date)
        {
            Editable = false;
        }
        field(33;From;Date)
        {
        }
        field(34;"Invoice Date";Date)
        {
            Caption = 'Invoice Date';
        }
        field(35;"Other Charges Due Airline";Decimal)
        {
        }
        field(36;"Other Charges DUE Agent";Decimal)
        {
        }
        field(37;Commission;Decimal)
        {
        }
        field(38;Discount;Decimal)
        {
        }
        field(39;"Net Amount Less Tax";Decimal)
        {
        }
        field(40;Taxt;Decimal)
        {
        }
        field(41;Net;Decimal)
        {
        }
        field(42;"Amount Payable";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Airline Code","MAWB No.","Airline Invoice No","Amount as per Airline","Weight as per Airline")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Converted,FALSE);
    end;

    trigger OnInsert()
    begin
        "Imported By":=USERID;
        "Imported On":=TODAY;
        VALIDATE("Airline Kilo Rate");
    end;

    trigger OnModify()
    begin
        TESTFIELD(Converted,FALSE);
    end;

    var
        PurchaseInvoiceHeader: Record "38";
        PurchaseInvoiceLine: Record "39";
        Text001: Label 'Do you wish to convert MAWB No. %1  into a Purchase Invoice?';
        Text002: Label 'MAWB No. %1 has been converted into a Purchase Invoice number %2';
        GLAccount: Record "15";
        Vendors: Record "23";
        IATAPurchaseInvoice1: Record "50016";
        IATAPurchaseInvoice: Record "50016";
        ImportExportSetup: Record "50010";
        LineNo: Integer;
        Airlines: Record "50021";
        InvoicingSetDimensions: Codeunit "50028";
        Ok: Boolean;
        IATAPurchaseInvoice2: Record "50016";

    [Scope('Internal')]
    procedure ConvertIATATempToPurchInvoice(var IATAPurchaseInvoice: Record "50016")
    var
        Vend: Record "23";
        Window: Dialog;
        Airlines: Record "50021";
    begin
        Window.OPEN('Converting IATA Lines to Purchase Invoice Lines \Converting Airline #1### \Invoice Number #2### \Adding MAWB #3####');

        ImportExportSetup.GET();
        RESET;
        SETRANGE(Converted,FALSE);
        IF FINDSET THEN
        BEGIN
          REPEAT
            IATAPurchaseInvoice1.RESET;
            IATAPurchaseInvoice1.SETRANGE(IATAPurchaseInvoice1."Airline Code","Airline Code");
            IATAPurchaseInvoice1.SETRANGE(IATAPurchaseInvoice1."Invoice Date","Invoice Date");
            IATAPurchaseInvoice1.SETRANGE(IATAPurchaseInvoice1."Airline Invoice No","Airline Invoice No");
            IF IATAPurchaseInvoice1.FINDSET THEN
            BEGIN
              //Create Purchase Header
              Ok:=Airlines.GET("Airline Code");
              Airlines.TESTFIELD(Airlines."Default Vendor No");
              PurchaseInvoiceHeader.INIT;
              PurchaseInvoiceHeader."Document Type" := PurchaseInvoiceHeader."Document Type"::Invoice;
              PurchaseInvoiceHeader.Status := PurchaseInvoiceHeader.Status::Open;
              PurchaseInvoiceHeader.VALIDATE(PurchaseInvoiceHeader."No.",'');
              PurchaseInvoiceHeader."Vendor Invoice No.":=IATAPurchaseInvoice2."Airline Invoice No";
              PurchaseInvoiceHeader."Buy-from Vendor No.":=Airlines."Default Vendor No";
              PurchaseInvoiceHeader.VALIDATE("Buy-from Vendor No.");
              PurchaseInvoiceHeader."Posting Date":=IATAPurchaseInvoice1."Invoice Date";
              PurchaseInvoiceLine.LOCKTABLE;
              PurchaseInvoiceHeader.INSERT(TRUE);
              //End Purchase Header
              IF "Invoice Date" <> 0D THEN BEGIN
                PurchaseInvoiceHeader."Posting Date" := IATAPurchaseInvoice1."Invoice Date";
                PurchaseInvoiceHeader."Document Date" :=IATAPurchaseInvoice1."Invoice Date"
              END;
              PurchaseInvoiceHeader."Posting Date":=IATAPurchaseInvoice1."Airline Invoice Date";
              PurchaseInvoiceHeader."Vendor Invoice No.":=IATAPurchaseInvoice1."Airline Invoice No";
              PurchaseInvoiceHeader.MODIFY;
              //Create Purchase Lines
              PurchaseInvoiceLine.RESET;
              PurchaseInvoiceLine.SETRANGE(PurchaseInvoiceLine."Document No.",PurchaseInvoiceHeader."No.");
              IF PurchaseInvoiceLine.FIND('-') THEN BEGIN
                PurchaseInvoiceLine.DELETEALL;
              END;
              REPEAT
                Ok:=Airlines.GET(IATAPurchaseInvoice1."Airline Code");
                Airlines.TESTFIELD(Airlines."Default Vendor No");
                Window.UPDATE(1,Airlines.Name);
                Window.UPDATE(2,IATAPurchaseInvoice1."Airline Invoice No");
                Window.UPDATE(3,IATAPurchaseInvoice1."MAWB No.");
                IF PurchaseInvoiceLine.FINDLAST THEN
                  LineNo:=PurchaseInvoiceLine."Line No."+1000
                ELSE
                  LineNo:=1000;

                PurchaseInvoiceLine."Document Type" :=PurchaseInvoiceHeader."Document Type";
                PurchaseInvoiceLine."Line No.":=LineNo;
                PurchaseInvoiceLine."Document No." := PurchaseInvoiceHeader."No.";
                PurchaseInvoiceLine.Type:=PurchaseInvoiceLine.Type::"G/L Account";
                PurchaseInvoiceLine.VALIDATE(PurchaseInvoiceLine."No.",IATAPurchaseInvoice1."Purchase A/C Code");
                PurchaseInvoiceLine."MAWB No.":=IATAPurchaseInvoice1."MAWB No.";
                PurchaseInvoiceLine."Location Code":='FWL';
                PurchaseInvoiceLine."Direct Unit Cost":=IATAPurchaseInvoice1."Airline Kilo Rate";
                PurchaseInvoiceLine.VALIDATE("Direct Unit Cost");
                PurchaseInvoiceLine.Quantity:=IATAPurchaseInvoice1."Weight as per Airline";
                PurchaseInvoiceLine.VALIDATE(Quantity);
                PurchaseInvoiceLine."Unit of Measure":='KG';
                PurchaseInvoiceLine.VALIDATE(PurchaseInvoiceLine."Unit of Measure");
                IF getChargeCode("MAWB No.")<>'' THEN
                  PurchaseInvoiceLine.VALIDATE(PurchaseInvoiceLine."Charge Code",getChargeCode("MAWB No."));
                PurchaseInvoiceLine.INSERT;
                InvoicingSetDimensions.SetDimensionsPurch("MAWB No.",PurchaseInvoiceLine);
                IATAPurchaseInvoice1.Converted:=TRUE;
                IATAPurchaseInvoice1."Purchase Invoice No.":=PurchaseInvoiceHeader."No.";
                IATAPurchaseInvoice1."Vendor No.":=Airlines."Default Vendor No";
                IATAPurchaseInvoice1."Vendor Name":=Airlines."Vendor Name";
                IATAPurchaseInvoice1.MODIFY;
                SLEEP(10);
              UNTIL IATAPurchaseInvoice1.NEXT = 0;
            END;
          UNTIL NEXT = 0;
        END;
        MESSAGE('Converted');
    end;

    local procedure getChargeCode(MAWB: Code[50]) Charge: Code[50]
    var
        cust: Record "18";
        ls: Record "50060";
    begin
        ls.RESET;
        ls.SETRANGE(ls."MAWB No.",MAWB);
        IF ls.FINDFIRST THEN BEGIN
          IF cust.GET(ls."Shipper Code") THEN BEGIN
            IF cust."Customer Type"=cust."Customer Type"::Group THEN BEGIN
              EXIT('14');
            END ELSE BEGIN
              EXIT('82');
            END;
          END;
        END;
    end;
}

