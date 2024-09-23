table 50077 "MAWB Header 2"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "MAWB Receipt"."MAWB No." WHERE (Assigned = FILTER (Yes),
                                                             Prepared = FILTER (No));

            trigger OnValidate()
            begin
                //+++++++++++Make MAWBs Prepared
                /*IF NOT CountMAWb("No.") THEN BEGIN
                  ERROR('The allocated houses are less than the allocated FAMs');
                END;*/
                LoadingSheetHeader.RESET;
                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Loading Sheet MAWB No", "No.");
                IF LoadingSheetHeader.FINDFIRST THEN BEGIN
                    "Flight Code" := LoadingSheetHeader."Flight Code";
                END ELSE BEGIN
                    ERROR('The Loading Sheet for this MAWB %1 has not been Prepared', "No.");
                END;

                BookingSheetMAWBAlloc.RESET;
                BookingSheetMAWBAlloc.SETRANGE(BookingSheetMAWBAlloc."MAWB No", "No.");
                IF BookingSheetMAWBAlloc.FINDFIRST THEN BEGIN
                    "Flight Code" := BookingSheetMAWBAlloc."Flight No";
                    "Source Airport" := BookingSheetMAWBAlloc."Source Airport";
                    "Destination Airport" := BookingSheetMAWBAlloc."Destination Airport";
                    "Shipper Code" := BookingSheetMAWBAlloc."Shipper Code";
                    Airport.RESET;
                    Airport.SETRANGE(Airport.Code, "Destination Airport");
                    IF Airport.FINDFIRST THEN
                        "Destination Code" := Airport."Country Code";
                    VALIDATE("Shipper Code");
                    // VALIDATE("Destination Airport");
                END;

                BKMawb.RESET;
                BKMawb.SETRANGE(BKMawb."MAWB No", "No.");
                IF BKMawb.FINDFIRST THEN BEGIN
                    IF BKMawb.Houses THEN BEGIN
                        HAWBLine.RESET;
                        HAWBLine.SETRANGE(HAWBLine."MAWB No.", BKMawb."MAWB No");
                        IF HAWBLine.FINDFIRST THEN BEGIN
                        END ELSE BEGIN
                            ERROR('The MAWB %1 has no houses defined', "No.");
                        END;
                    END;
                END;
                MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "No.");
                IF MAWBReceipt.FINDFIRST THEN BEGIN
                    MAWBReceipt.Prepared := TRUE;
                    MAWBReceipt.MODIFY;
                    "Airline Code" := MAWBReceipt."Airline Code";
                END;
                //+++++++++++
                ExportSetup.GET();
                HAWBLine.RESET;
                HAWBLine.SETRANGE(HAWBLine."MAWB No.", "No.");
                IF HAWBLine.FINDFIRST THEN BEGIN
                    HasHouses := TRUE;
                    "Has Houses" := TRUE;
                END ELSE BEGIN
                    HasHouses := FALSE;
                    "Has Houses" := FALSE;
                END;
                IF NOT HasHouses THEN BEGIN
                    LoadingSheetLine.RESET;
                    LoadingSheetLine.SETRANGE(LoadingSheetLine."MAWB No.", "No.");
                    IF LoadingSheetLine.FINDSET THEN BEGIN
                        LoadingSheetHeader.RESET;
                        LoadingSheetHeader.SETRANGE("No.", LoadingSheetLine."Loading Sheet No.");
                        IF LoadingSheetHeader.FINDFIRST THEN BEGIN
                            "Shipper Code" := LoadingSheetHeader."Shipper Code";
                            "Preparation Date" := TODAY;
                            //LoadingSheetHeader.GET(LoadingSheetLine."Loading Sheet No.");
                            "Shipper Code" := LoadingSheetHeader."Shipper Code";
                            "Destination Code" := LoadingSheetHeader."Destination Code";
                        END;
                        REPEAT
                            MAWBLine4.RESET;
                            MAWBLine4.SETRANGE(MAWBLine4."MAWB No.", "No.");
                            IF MAWBLine4.FINDLAST THEN BEGIN
                                LineNo := MAWBLine4."Line No." + 1000;
                            END;
                            LoadingSheetHeader.RESET;
                            LoadingSheetHeader.SETRANGE(LoadingSheetHeader."No.", LoadingSheetLine."Loading Sheet No.");
                            IF LoadingSheetHeader.FINDFIRST THEN
                                LoadingSheetLine.CALCFIELDS(LoadingSheetLine."FWL Docket Weight");
                            LoadingSheetLine.CALCFIELDS(LoadingSheetLine.Quantity);

                            MAWBLine.INIT;
                            MAWBLine."Line No." := LineNo;
                            MAWBLine."Airline Code" := LoadingSheetLine."Airline Code";
                            MAWBLine."Flight Code" := LoadingSheetLine."Flight Code";
                            MAWBLine.Description := LoadingSheetLine.Description;
                            MAWBLine."Unit of Measure Code" := LoadingSheetLine."Unit of Measure Code";
                            MAWBLine.Type := LoadingSheetLine.Type;
                            MAWBLine."Item No." := LoadingSheetLine."Item No.";
                            MAWBLine."Gross Weight" := LoadingSheetLine."FWL Gross Weight";
                            MAWBLine."Chargeable Weight" := LoadingSheetLine."FWL Docket Weight";
                            MAWBLine.Quantity := LoadingSheetLine.Quantity;
                            MAWBLine."Location Code" := LoadingSheetLine."Location Code";
                            MAWBLine."MAWB No." := "No.";
                            MAWBLine."Destination Code" := LoadingSheetLine."Destination Code";
                            MAWBLine."Destination Code" := LoadingSheetLine."Destination Code";
                            MAWBLine."Flight Date" := LoadingSheetHeader."Loading Date";
                            MAWBLine."Shipper Code" := LoadingSheetHeader."Shipper Code";
                            MAWBLine.Lendth := LoadingSheetLine.Length;
                            MAWBLine.Width := LoadingSheetLine.Width;
                            MAWBLine.Height := LoadingSheetLine.Height;
                            MAWBLine."FWL Docket Weight" := LoadingSheetLine."FWL Docket Weight";
                            MAWBLine."FWL Gross Weight" := LoadingSheetLine."FWL Gross Weight";
                            MAWBLine."Volume Metric Weight" := LoadingSheetLine."Volume Metric Weight";
                            ChargeBle := ((LoadingSheetLine.Height * LoadingSheetLine.Width * LoadingSheetLine.Length) / ExportSetup."Division Factor") * (LoadingSheetLine.Quantity);
                            IF LoadingSheetLine."FWL Docket Weight" > ChargeBle THEN BEGIN
                                MAWBLine."Chargeable Weight" := LoadingSheetLine."FWL Docket Weight";
                            END ELSE BEGIN
                                MAWBLine."Chargeable Weight" := ChargeBle;
                            END;
                            "Item Description" := LoadingSheetLine.Description;
                            gRecCustomer.GET(LoadingSheetLine."Shipper Code");
                            IF gRecCustomer."Weight Type" = gRecCustomer."Weight Type"::"Docket Weight" THEN
                                MAWBLine."Chargeable Weight" := LoadingSheetLine."FWL Docket Weight"
                            ELSE
                                IF gRecCustomer."Weight Type" = gRecCustomer."Weight Type"::"Volume Metric Weight" THEN
                                    MAWBLine."Chargeable Weight" := LoadingSheetLine."Volume Metric Weight";
                            MAWBLine.INSERT;
                        UNTIL LoadingSheetLine.NEXT = 0;
                    END;
                END;
                IF ImpExpSetup.GET THEN BEGIN
                    "Source Airport" := ImpExpSetup."Source Airport";
                    "Carrier Agent Code" := ImpExpSetup."Carrier Agent Code";
                    "Agent's IATA Code" := ImpExpSetup."Agent's IATA Code";
                END;
                "Prepared By" := USERID;

            end;
        }
        field(2; "Shipper Code"; Code[20])
        {
            TableRelation = Customer.No.;

            trigger OnValidate()
            begin
                IF "Shipper Code" = '' THEN BEGIN END ELSE BEGIN
                Shipper.GET("Shipper Code");
                "Shipper Name":=Shipper.Name;
                "Shipper Address":=Shipper.Address;
                END;
            end;
        }
        field(3;"Shipper Address";Text[30])
        {
            Editable = false;
        }
        field(4;"Shipper Name";Text[30])
        {
            Editable = false;
        }
        field(5;"Consignee Code";Code[20])
        {
            TableRelation = Consignee.No.;

            trigger OnValidate()
            begin
                Consignee.GET("Consignee Code");
                "Consignee Name":=Consignee.Name;
            end;
        }
        field(6;"Consignee Name";Code[20])
        {
            Editable = false;
        }
        field(7;"Agent's IATA Code";Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(8;"Carrier Agent Code";Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(9;"Source Airport";Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(10;"Airline Code";Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                IF "Airline Code"<> xRec."Airline Code" THEN BEGIN
                  "Flight Code":='';
                END;
            end;
        }
        field(11;"Destination Airport";Code[20])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));

            trigger OnValidate()
            begin
                Airport.RESET;
                Airport.SETRANGE(Airport.Code,"Destination Airport");
                IF Airport.FINDFIRST THEN BEGIN
                  "Destination Code":=Airport."Country Code";
                END;
            end;
        }
        field(13;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight No." WHERE (Airline Code=FIELD(Airline Code));
        }
        field(14;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;

            trigger OnValidate()
            begin
                IF "Destination Code"<> xRec."Destination Code" THEN
                  "Destination Airport":='';
            end;
        }
        field(15;"Preparation Date";Date)
        {
        }
        field(16;Consolidated;Boolean)
        {
        }
        field(17;"Agent Code";Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(22;Comments;Text[250])
        {
        }
        field(23;Status;Option)
        {
            OptionCaption = 'New,Pending,Submitted,Archived';
            OptionMembers = New,Pending,Submitted,Archived;
        }
        field(24;"Phyto Certificate";Code[50])
        {

            trigger OnValidate()
            begin
                TESTFIELD("Has Houses",FALSE);
            end;
        }
        field(26;"Chargeable Weight";Decimal)
        {
            CalcFormula = Sum("MAWB Line"."Chargeable Weight" WHERE (MAWB No.=FIELD(No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27;"Booked Weight";Decimal)
        {
            CalcFormula = Sum("Good Receipt Line"."Booked Weight" WHERE (MAWB No.=FIELD(No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28;"Euro Form No";Code[50])
        {

            trigger OnValidate()
            begin
                TESTFIELD("Has Houses",FALSE);
                IF ((STRPOS('GSP',"Euro Form No")=0) AND (STRPOS('EURO',"Euro Form No")=0)) AND (STRPOS('COO',"Euro Form No")=0) AND (STRPOS('COMESA',"Euro Form No")=0) AND (STRPOS('EAC',"Euro Form No")=0) AND (STRPOS('N/A',"Euro Form No")=0) THEN
                BEGIN
                  MESSAGE('Please fill a Certificate Type');
                END;
            end;
        }
        field(29;"Custom Entry No";Code[50])
        {

            trigger OnValidate()
            begin
                TESTFIELD("Has Houses",FALSE);
            end;
        }
        field(30;"Has Houses";Boolean)
        {
        }
        field(31;"Prepared By";Code[50])
        {
        }
        field(32;"Processed By";Code[50])
        {
        }
        field(33;"Last Edited By";Code[50])
        {
        }
        field(34;"Last Edited On";Date)
        {
        }
        field(35;"Gate Pass Prepared";Boolean)
        {
            Editable = true;
        }
        field(36;"Commercial Invoice No";Code[50])
        {
        }
        field(37;Currency;Code[10])
        {
        }
        field(38;Amount;Decimal)
        {
        }
        field(39;"Invoice Status";Option)
        {
            OptionCaption = 'New,Submitted,Posted';
            OptionMembers = New,Submitted,Posted;
        }
        field(40;"Processed At";Time)
        {
        }
        field(41;Closed;Boolean)
        {
        }
        field(42;"Total Weight";Decimal)
        {
            FieldClass = Normal;
        }
        field(43;"House Nos";Integer)
        {
        }
        field(44;"Item Description";Text[250])
        {
        }
        field(45;"Total Quantity";Decimal)
        {
            CalcFormula = Sum("MAWB Line".Quantity WHERE (MAWB No.=FIELD(No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000;"Purchase Posting Date";Date)
        {
        }
        field(50001;"Total Docket Weight";Decimal)
        {
            CalcFormula = Sum("MAWB Line"."FWL Docket Weight" WHERE (MAWB No.=FIELD(No.)));
            FieldClass = FlowField;
        }
        field(50002;"Total Gross Weight";Decimal)
        {
            CalcFormula = Sum("MAWB Line"."FWL Gross Weight" WHERE (MAWB No.=FIELD(No.)));
            FieldClass = FlowField;
        }
        field(50003;"Total Volume Metric Weight";Decimal)
        {
            CalcFormula = Sum("MAWB Line"."Volume Metric Weight" WHERE (MAWB No.=FIELD(No.)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"Shipper Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.","No.");
        IF MAWBReceipt.FINDFIRST THEN BEGIN
          MAWBReceipt.Prepared:=FALSE;
          MAWBReceipt.MODIFY;
        END;
        MAWBLine.RESET;
        MAWBLine.SETRANGE(MAWBLine."MAWB No.","No.");
        IF MAWBLine.FIND('-') THEN
        MAWBLine.DELETEALL;

        ClearCalculatedCharges("No.");
    end;

    trigger OnInsert()
    begin
        "Preparation Date":=TODAY;
    end;

    trigger OnModify()
    begin
        "Last Edited By":=USERID;
        "Last Edited On":= TODAY;
    end;

    var
        Airport: Record "50019";
        BKMawb: Record "50070";
        ExchangeRates1: Record "330";
        ExchangeRates: Record "330";
        Tot: Decimal;
        ChargeBle: Decimal;
        ExportSetup: Record "50010";
        LoadingSheetHeader: Record "50060";
        HasHouses: Boolean;
        LineNo: Integer;
        MAWBs: Record "50077";
        BookingSheetMAWBAlloc: Record "50070";
        MAWBLine4: Record "50076";
        MAWBInCharges1: Record "50073";
        MAWBLine2: Record "50076";
        BookingSheetLine: Record "50054";
        MAWBLine: Record "50076";
        BookingSheetLine2: Record "50054";
        ShipperCount: Integer;
        Shipper: Record "18";
        BookingSheetHAWBAllocation: Record "50056";
        Consignee: Record "50015";
        HAWBLine: Record "50074";
        HAWBLine2: Record "50074";
        TotalQuantity: Decimal;
        SplitFactor: Decimal;
        MAWBReceipt: Record "50039";
        MAWBHeader: Record "50077";
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
        MAWBInvoiceNotifyParty: Record "50072";
        NotifyParty: Record "50017";
        Text50000: Label '-VAT';
        Text50001: Label '%1 %2 does not have any lines';
        Text50002: Label 'Do you want to calculate total charges for %1 %2?';
        Text50003: Label 'Do you want to split %1 %2?';
        Text50004: Label 'The booking date is not within the allowed flight charge effective dates';
        GenJnlLine: Record "81";
        VATPostingSetup: Record "325";
        Currency: Record "4";
        TotalWeight: Decimal;
        MAWBLineCharge: Record "50004";
        UnrecoveredCharge: Record "50006";
        TotalAmount: Decimal;
        PreviousT0weight: Decimal;
        PreviousT0weight2: Decimal;
        FreightCharge: Record "50018";
        VATPostingSetup2: Record "325";
        ImportExportSetup: Record "50010";
        GeneralLedgerSetup: Record "98";
        MAWBReceipt2: Record "50039";
        MAWBReceiptdate: Date;
        InvoiceCurrency: Code[10];
        ImpExpSetup: Record "50010";
        BookingSheetMawbAllocation: Record "50070";
        LoadingSheetLine: Record "50061";
        gRecCustomer: Record "18";

    [Scope('Internal')]
    procedure DistinctRec()
    begin
        TotalQuantity:=0;
        ShipperCount:=0;
        HAWBLine.SETCURRENTKEY("Shipper Code");
        IF HAWBLine.FINDSET THEN BEGIN
            REPEAT


              //MESSAGE('%1',HAWBLine.Quantity);

              IF (HAWBLine2."Shipper Code" <> HAWBLine."Shipper Code") THEN BEGIN
                //ShipperCount := ShipperCount + 1;
                //TotalQuantity:=TotalQuantity+HAWBLine.Quantity;
                 //MESSAGE('%1',HAWBLine."Shipper Code");

                HAWBLine2.SETRANGE("Shipper Code",HAWBLine."Shipper Code");
                HAWBLine2.CALCSUMS(Quantity);
                MESSAGE('%1',HAWBLine2.Quantity);

              END;
              //MESSAGE('%1',TotalQuantity);

              HAWBLine2 := HAWBLine;
              //MESSAGE('%1',HAWBLine2.Quantity);
             // SplitFactor:=HAWBLine.Quantity/HAWBLine2.Quantity;
              //MESSAGE('%1',HAWBLine.Quantity);
             // MESSAGE('%1',SplitFactor);
            UNTIL HAWBLine.NEXT=0;
            //MESSAGE('%1',HAWBLine.Quantity);

        END;
    end;

    [Scope('Internal')]
    procedure CalculateMAWBCharges()
    var
        BookingSheetLine: Record "50054";
        Customer: Record "18";
        FreightCharge: Record "50018";
        HandlingSlab: Record "50045";
        TotalSales: Decimal;
        Items: Record "27";
        FreightCost: Decimal;
        FreightCharge3: Record "50018";
        MAWBInvoiceCharge3: Record "50073";
        Text002: Label 'Freight charge  has already been calculated';
    begin
         //=====================Philip==========
         MAWBLine2.RESET;
         MAWBLine2.SETRANGE(MAWBLine2."MAWB No.","No.");
         IF MAWBLine2.FINDSET THEN
         BEGIN
           TotalWeight:=0;
           REPEAT
             TotalWeight+=MAWBLine2."Chargeable Weight";
           UNTIL MAWBLine2.NEXT=0;
         END;
        //
          Tot:=TotalWeight;
          MAWBs:=Rec;
          BookingSheetMAWBAlloc.RESET;
          BookingSheetMAWBAlloc.SETRANGE(BookingSheetMAWBAlloc."MAWB No","No.");
          IF BookingSheetMAWBAlloc.FINDFIRST THEN
          BEGIN
          //MESSAGE('Booking Sheet %1',BookingSheetMAWBAlloc."Booking Sheet No");
            BookingSheetLine.RESET;
            BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.",BookingSheetMAWBAlloc."Booking Sheet No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Airline Code",BookingSheetMAWBAlloc."Airline Code");
            BookingSheetLine.SETRANGE(BookingSheetLine."Flight Code",BookingSheetMAWBAlloc."Flight No");
            BookingSheetLine.SETRANGE(BookingSheetLine."Source Airport",BookingSheetMAWBAlloc."Source Airport");
            BookingSheetLine.SETRANGE(BookingSheetLine."Destination Airport",BookingSheetMAWBAlloc."Destination Airport");
            //MESSAGE('Getting Here %1',BookingSheetMAWBAlloc."Booking Sheet No");
            IF BookingSheetLine.FINDFIRST THEN
            BEGIN
            //MESSAGE('Getting Here');
                  FreightChargeByAirline.RESET;
                  FreightChargeByAirline.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                  IF FreightChargeByAirline.FINDFIRST THEN BEGIN
                    IF (BookingSheetLine."Booking Date"<FreightChargeByAirline."Effective Start Date") OR
                       (BookingSheetLine."Booking Date">FreightChargeByAirline."Effective End Date") THEN
                        ERROR(Text50004,BookingSheetLine.FIELDCAPTION("Booking Date"))
                    ELSE BEGIN
                      FreightChargeByFlight.RESET;
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Airline Code",BookingSheetLine."Airline Code");
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Flight Code",BookingSheetLine."Flight Code");
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Source Airport",BookingSheetLine."Source Airport");
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Destination Airport", BookingSheetLine."Destination Airport");
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Destination Code",BookingSheetLine."Destination Code");
                      FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Source Country",BookingSheetLine."Source Code");
                      IF FreightChargeByFlight.FINDFIRST THEN BEGIN
                      //MESSAGE('p %1',BookingSheetLine."Booking Sheet No.");
                        FreightChargeByItem.RESET;
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Airline Code",BookingSheetLine."Airline Code");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Flight Code",BookingSheetLine."Flight Code");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."No.",BookingSheetLine."Item No.");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Source Airport",BookingSheetLine."Source Airport");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Destination Airport",BookingSheetLine."Destination Airport");
                        IF FreightChargeByItem.FINDFIRST THEN
                        BEGIN
                          FreightItemCharge.RESET;
                          FreightItemCharge.SETRANGE(FreightItemCharge."Airline Code",BookingSheetLine."Airline Code");
                          FreightItemCharge.SETRANGE(FreightItemCharge."Flight Code",BookingSheetLine."Flight Code");
                          FreightItemCharge.SETRANGE(FreightItemCharge."Item No.",BookingSheetLine."Item No.");
                          FreightItemCharge.SETRANGE(FreightItemCharge."Source Airport",BookingSheetLine."Source Airport");
                          FreightItemCharge.SETRANGE(FreightItemCharge."Destination Airport",BookingSheetLine."Destination Airport");
                          IF FreightItemCharge.FINDSET THEN BEGIN
                            REPEAT
                              CASE FreightItemCharge.Source OF
                                FreightItemCharge.Source::System:
                                BEGIN

                                  MAWBInvoiceCharge.INIT;
                                  MAWBInvoiceCharge."Transaction Date":=TODAY;
                                  MAWBInvoiceCharge."MAWB No.":="No.";
                                  MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                                  MAWBInvoiceCharge."Freight Charge Code":=FreightItemCharge.Code;
                                  MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
                                  MAWBInvoiceCharge.Description:=FreightItemCharge.Description;
                                  MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
                                  CostAmount:=0;
                                  SalesAmount:=0;
                                  VATAmount:=0;
                                  MarginAmount:=0;

                                  //================Philip
                                  FreightItemChargeMatrix.RESET;
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Airline Code",BookingSheetLine."Airline Code");
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Flight Code",BookingSheetLine."Flight Code");
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Item No.",BookingSheetLine."Item No.");
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Freight Charge Code",FreightItemCharge.Code);
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Source airport",FreightItemCharge."Source Airport");
                                  FreightItemChargeMatrix.SETRANGE( FreightItemChargeMatrix."Destination Airport",FreightItemCharge."Destination Airport");
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix.Calculation,FreightItemChargeMatrix.Calculation::"Flat Rate");
                                  IF FreightItemChargeMatrix.FINDSET THEN
                                  BEGIN

                                    REPEAT
                                      CostAmount+=FreightItemChargeMatrix."Rate Amount";
                                      TotalWeight:=TotalWeight-FreightItemChargeMatrix.Difference;
                                    UNTIL FreightItemChargeMatrix.NEXT = 0;
                                  END;
                                  //Message('%1 Flat Rate Total Weight %2',CostAmount,TotalWeight);

                                  FreightItemChargeMatrix.RESET;
                                  FreightItemChargeMatrix.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                                  FreightItemChargeMatrix.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                                  FreightItemChargeMatrix.SETRANGE("Item No.",BookingSheetLine."Item No.");
                                  FreightItemChargeMatrix.SETRANGE("Freight Charge Code",FreightItemCharge.Code);
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Source airport",FreightItemCharge."Source Airport");
                                  FreightItemChargeMatrix.SETRANGE( FreightItemChargeMatrix."Destination Airport",FreightItemCharge."Destination Airport");
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix.Calculation,FreightItemChargeMatrix.Calculation::"Kilo Rate");
                                  IF FreightItemChargeMatrix.FINDSET THEN
                                  BEGIN
                                  //MESSAGE('56 Freight Item Charge %1',FreightItemChargeMatrix."Freight Charge Code");
                                    REPEAT
                                      IF TotalWeight>FreightItemChargeMatrix."To Weight" THEN
                                      BEGIN
                                      CostAmount += (FreightItemChargeMatrix."Rate Amount"*FreightItemChargeMatrix.Difference);
                                      TotalWeight:= TotalWeight-FreightItemChargeMatrix.Difference;
                                      //Message('%1 Kilo Rate %2 Total Weight %3 Cost Amount',FreightItemChargeMatrix."Rate Amount",TotalWeight,CostAmount);
                                      END ELSE
                                      BEGIN
                                        CostAmount+=(TotalWeight*FreightItemChargeMatrix."Rate Amount");
                                        //Message('%1 Kilo Rate %2 Total Weight %3 Cost Ammount',FreightItemChargeMatrix."Rate Amount",TotalWeight,CostAmount);
                                      END;
                                    UNTIL FreightItemChargeMatrix.NEXT = 0;
                                  END;
                                   //<=======================
                                  FreightItemChargeMatrix.RESET;
                                  FreightItemChargeMatrix.SETRANGE("Airline Code",BookingSheetLine."Airline Code");
                                  FreightItemChargeMatrix.SETRANGE("Flight Code",BookingSheetLine."Flight Code");
                                  FreightItemChargeMatrix.SETRANGE("Item No.",BookingSheetLine."Item No.");
                                  FreightItemChargeMatrix.SETRANGE("Freight Charge Code",FreightItemCharge.Code);
                                  FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Source airport",FreightItemCharge."Source Airport");
                                  FreightItemChargeMatrix.SETRANGE( FreightItemChargeMatrix."Destination Airport",FreightItemCharge."Destination Airport");
                                  IF FreightItemChargeMatrix.FINDSET THEN
                                  BEGIN


                                    MAWBInvoiceCharge."Currency Code":=FreightItemChargeMatrix."Currency Code";

                                    GeneralLedgerSetup.GET();
                                    IF MAWBInvoiceCharge."Currency Code"='' THEN
                                     MAWBInvoiceCharge."Currency Code":=GeneralLedgerSetup."LCY Code" ;
                                    //ELSE
                                   // InvoiceCurrency:= MAWBInvoiceCharge."Currency Code";
                                    ImportExportSetup.GET();

                                    MAWBInvoiceCharge."Base Unit Price":=CostAmount;
                                    MAWBInvoiceCharge."Cost Amount":=CostAmount;
                                    //MarginAmount:=(FreightCharge."Margin %"*CostAmount)/100;
                                    MAWBInvoiceCharge."Sales Amount Ex. VAT":=MAWBInvoiceCharge."Invoice Unit Price"+MarginAmount;
                                    VATAmount:=(VATPostingSetup."VAT %"*(MAWBInvoiceCharge."Invoice Unit Price"+MarginAmount))/100;
                                    MAWBInvoiceCharge."VAT Amount":=VATAmount;
                                    MAWBInvoiceCharge."Sales Amount Inc. VAT":=(MAWBInvoiceCharge."Invoice Unit Price"+MarginAmount+VATAmount);
                                    FreightCharge.GET(FreightItemCharge.Code);
                                    MAWBInvoiceCharge."Margin %":=FreightCharge."Margin %";
                                    MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");
                                    VATPostingSetup2.RESET;
                                    VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Bus. Posting Group",FreightCharge."VAT Bus. Posting Group");
                                    VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Prod. Posting Group",FreightCharge."VAT Prod. Posting Group");
                                    IF VATPostingSetup2.FIND('-') THEN BEGIN
                                     MAWBInvoiceCharge."VAT %":=VATPostingSetup2."VAT %";
                                     MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."VAT %");
                                    END;
                                    MAWBInvoiceCharge."Chargeable Weight":=Tot;
                                    IF Tot<> 0 THEN BEGIN
                                    MAWBInvoiceCharge."Contract Rate":=CostAmount/Tot;
                                    MAWBInvoiceCharge."Agreed Rate":=CostAmount/Tot;
                                    END;
                                    MAWBInvoiceCharge."Prepared By":=USERID;
                                    MAWBInvoiceCharge."Prepared On":=TODAY;
                                    //MESSAGE('%1/%2',TotalWeight,CostAmount);
                                    MAWBInvoiceCharge.INSERT;
                                  END;//END OF FreightItemChargeMatrix
                                END;//END OF NEXT BEGIN OF CASE
                             END;//END OF CASE
                             //MESSAGE(FreightItemChargeMatrix."Freight Charge Code");
                            UNTIL FreightItemCharge.NEXT=0;
                          END;//END OF FreightItemCharge
                        END;//END OF FreightChargeByItem
                      END;// END OF FreightChargeByFlight



                    END;//END OF BookingSheetLine
                  END;//Booking Sheet MAWB Allocation
                 END;//END OF FreightChargeByAirline
          END;


            //=========GET DEFAULT MAWB CHARGES/KAA Fees AMOUNT==============
         MAWBLineCharge.RESET;
         //MAWBLineCharge.SETRANGE("MAWB No.","No.");
         IF MAWBLineCharge.FINDSET THEN BEGIN
          REPEAT
          MAWBInvoiceCharge.INIT;
          IF MAWBInvoiceCharge.FINDLAST THEN BEGIN
            MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
          END;
          MAWBInvoiceCharge."Transaction Date":=TODAY;
          MAWBInvoiceCharge."MAWB No.":="No.";
          MAWBInvoiceCharge."Freight Charge Code":=MAWBLineCharge.Code;
          MAWBInvoiceCharge.Description:=MAWBLineCharge.Description;
          //MAWBInvoiceCharge."Item No.":=BookingSheetLine."Item No.";
          MAWBInvoiceCharge."Currency Code":=MAWBLineCharge."Currency Code";
          MAWBReceipt2.RESET;
          MAWBReceipt2.SETRANGE(MAWBReceipt2."MAWB No.","No.");
          IF MAWBReceipt2.FIND('-') THEN BEGIN
           MAWBReceiptdate:=MAWBReceipt2."Receipt Date";

          END;
          BookingSheetMawbAllocation.RESET;
          BookingSheetMawbAllocation.SETRANGE(BookingSheetMawbAllocation."MAWB No","No.");
          IF BookingSheetMawbAllocation.FINDFIRST THEN BEGIN
          MAWBInvoiceCharge."Item No.":=BookingSheetMAWBAlloc."Item No";
          END;

          ImportExportSetup.GET();
           IF MAWBLineCharge."Currency Code"<> ImportExportSetup."Invoicing Currency Code" THEN BEGIN
              ExchangeRates.RESET;
              ExchangeRates.SETRANGE(ExchangeRates."Currency Code",ImportExportSetup."Invoicing Currency Code");
              ExchangeRates.SETRANGE(ExchangeRates."Relational Currency Code",MAWBLineCharge."Currency Code" );
              ExchangeRates.SETFILTER(ExchangeRates."Starting Date",'<=%1',TODAY);
              IF ExchangeRates.FINDFIRST THEN BEGIN
                MAWBInvoiceCharge."Base Unit Price":=((MAWBLineCharge.Amount*ExchangeRates."Exchange Rate Amount")/(ExchangeRates."Relational Exch. Rate Amount"));
                MAWBInvoiceCharge."Cost Amount":=((MAWBLineCharge.Amount*ExchangeRates."Exchange Rate Amount")/(ExchangeRates."Relational Exch. Rate Amount"));
                MAWBInvoiceCharge."Currency Code":=ImportExportSetup."Invoicing Currency Code";
              END ELSE BEGIN
                ExchangeRates.RESET;
                ExchangeRates.SETRANGE(ExchangeRates."Currency Code",MAWBLineCharge."Currency Code" );
                ExchangeRates.SETRANGE(ExchangeRates."Relational Currency Code",'');
                IF ExchangeRates.FINDFIRST THEN BEGIN
                  ExchangeRates1.RESET;
                  ExchangeRates1.SETRANGE(ExchangeRates1."Currency Code",ImportExportSetup."Invoicing Currency Code");
                  ExchangeRates1.SETRANGE(ExchangeRates1."Relational Currency Code",'');
                  IF ExchangeRates1.FINDFIRST THEN BEGIN
                    MAWBInvoiceCharge."Base Unit Price":=(((MAWBLineCharge.Amount*ExchangeRates."Exchange Rate Amount")/(ExchangeRates."Relational Exch. Rate Amount"))*(ExchangeRates1."Relational Exch. Rate Amount"))/ExchangeRates1."Exchange Rate Amount";
                    MAWBInvoiceCharge."Cost Amount":=(((MAWBLineCharge.Amount*ExchangeRates."Exchange Rate Amount")/(ExchangeRates."Relational Exch. Rate Amount"))*(ExchangeRates1."Relational Exch. Rate Amount"))/ExchangeRates1."Exchange Rate Amount";
                    MAWBInvoiceCharge."Currency Code":=ImportExportSetup."Invoicing Currency Code";
                  END;
                  //MESSAGE('No Exchange Rate for this period for currency %1',ExchangeRates."Relational Exch. Rate Amount");
                  END;
              END;
           END;

          FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");

          MAWBInvoiceCharge."Margin %":=FreightCharge."Margin %";
          MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");

          MAWBInvoiceCharge."Sales Amount Ex. VAT":=MAWBInvoiceCharge."Invoice Unit Price";
          MAWBInvoiceCharge."Sales Amount Inc. VAT":=MAWBInvoiceCharge."Invoice Unit Price";
          MAWBInvoiceCharge."Prepared By":=USERID;
          MAWBInvoiceCharge."Prepared On":=TODAY;

          MAWBInvoiceCharge.INSERT;
          UNTIL MAWBLineCharge.NEXT=0;
         END;
    end;

    [Scope('Internal')]
    procedure CalculateHandlingFees()
    var
        BookingSheetLine: Record "50054";
        Customer: Record "18";
        FreightCharge: Record "50018";
        HandlingSlab: Record "50045";
        TotalSales: Decimal;
        Items: Record "27";
        FreightCost: Decimal;
        MAWBInvoiceCharge: Record "50073";
        HandlingSlabMatrix: Record "50045";
        FreightItemCharge: Record "50028";
        FreightCharge2: Record "50018";
        Text001: Label 'Are you sure that you want to calculate the Handling fees?';
        FreightCharge3: Record "50018";
        MAWBInvoiceCharge3: Record "50073";
        Text002: Label 'Handling Fee has already been calculated';
    begin
          FreightCharge3.RESET;
          FreightCharge3.SETRANGE(FreightCharge3."Handling Charge",TRUE);
          IF FreightCharge3.FIND('-') THEN
          BEGIN
          //MESSAGE('HERE');
           MAWBInvoiceCharge3.RESET;
           MAWBInvoiceCharge3.SETRANGE(MAWBInvoiceCharge3."Freight Charge Code",FreightCharge3.Code);
           MAWBInvoiceCharge3.SETRANGE( MAWBInvoiceCharge3."MAWB No.","No.");
           IF MAWBInvoiceCharge3.FIND('-') THEN
             MAWBInvoiceCharge3.DELETEALL;
          END;//END MAWBInvoiceCharge3.
          MAWBInvoiceCharge.RESET;
          MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.","No.");
          IF MAWBInvoiceCharge.FIND('-') THEN
          BEGIN
           REPEAT
            TotalSales:=TotalSales+MAWBInvoiceCharge."Base Unit Price";
           UNTIL MAWBInvoiceCharge.NEXT=0;

           HandlingSlabMatrix.RESET;
           HandlingSlabMatrix.SETFILTER(HandlingSlabMatrix."From Weight",'<=%1',TotalSales);
           HandlingSlabMatrix.SETFILTER(HandlingSlabMatrix."To Weight",'>=%1',TotalSales);

         IF HandlingSlabMatrix.FIND('-')  THEN
         BEGIN
        BookingSheetMawbAllocation.RESET;
        BookingSheetMawbAllocation.SETRANGE(BookingSheetMawbAllocation."MAWB No","No.");

           MAWBInvoiceCharge.INIT;
           MAWBInvoiceCharge."Transaction Date":=TODAY;
           MAWBInvoiceCharge."MAWB No.":="No.";
           IF BookingSheetMawbAllocation.FINDFIRST THEN BEGIN
           MAWBInvoiceCharge."Item No.":=BookingSheetMawbAllocation."Item No";
           END;
            FreightCharge2.RESET;
            FreightCharge2.SETRANGE(FreightCharge2."Handling Charge",TRUE);
            IF FreightCharge2.FIND('-') THEN
            BEGIN
             MAWBInvoiceCharge."Freight Charge Code":=FreightCharge2.Code;
             MAWBInvoiceCharge.Description:=FreightCharge2.Description;
             MAWBInvoiceCharge."Margin %":=FreightCharge2."Margin %";
             MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");
             MAWBInvoiceCharge."Purchase A/C Code":=FreightCharge2."Purchase A/C Code";
            END;  //END Freight Charge 2
           MAWBInvoiceCharge."Line No.":=MAWBInvoiceCharge."Line No."+10000;
           MAWBInvoiceCharge."Base Unit Price":=HandlingSlabMatrix."Rate Amount";
           MAWBInvoiceCharge."Cost Amount":=HandlingSlabMatrix."Rate Amount";
           MAWBInvoiceCharge."Currency Code":=HandlingSlabMatrix."Currency Code";
           GeneralLedgerSetup.GET();
           IF MAWBInvoiceCharge."Currency Code"='' THEN
           InvoiceCurrency:=GeneralLedgerSetup."LCY Code"
           ELSE
           InvoiceCurrency:=MAWBInvoiceCharge."Currency Code";
           ImportExportSetup.GET();
           FreightCharge.GET(MAWBInvoiceCharge."Freight Charge Code");
           MAWBInvoiceCharge."Margin %":=FreightCharge."Margin %";
           MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."Margin %");

           MAWBInvoiceCharge."Sales Amount Ex. VAT":=MAWBInvoiceCharge."Invoice Unit Price";
           VATPostingSetup2.RESET;
           VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Bus. Posting Group",FreightCharge2."VAT Bus. Posting Group");
           VATPostingSetup2.SETRANGE(VATPostingSetup2."VAT Prod. Posting Group",FreightCharge2."VAT Prod. Posting Group");
           IF VATPostingSetup2.FIND('-') THEN
           BEGIN
            MAWBInvoiceCharge.VALIDATE(MAWBInvoiceCharge."VAT %",VATPostingSetup2."VAT %");
           END;//END VATPosting setup2
           MAWBInvoiceCharge."Prepared By":=USERID;
           MAWBInvoiceCharge."Prepared On":=TODAY;
           MAWBInvoiceCharge.INSERT;
         END //END HandlingSlabMatrix
         ELSE BEGIN MESSAGE('Not Found');
         END;
          END;  //END MAWBInvoiceCharge
    end;

    [Scope('Internal')]
    procedure ClearCalculatedCharges("MAWB No": Code[50])
    var
        CalculatedCharges: Record "50073";
    begin
        CalculatedCharges.RESET;
        CalculatedCharges.SETRANGE(CalculatedCharges."MAWB No.","MAWB No");
        IF CalculatedCharges.FIND('-') THEN
        BEGIN
        CalculatedCharges.DELETEALL;
        END;
    end;

    [Scope('Internal')]
    procedure ArchiveHouses("MAWB No": Code[50])
    var
        HAWBHeaders: Record "50075";
        HAWBLines: Record "50074";
    begin
        HAWBHeaders.RESET;
        HAWBHeaders.SETRANGE(HAWBHeaders."MAWB No.","MAWB No");
        IF HAWBHeaders.FINDSET THEN
        BEGIN
          //MESSAGE('Found');
          REPEAT
            HAWBHeaders.Status:=HAWBHeaders.Status::Archived;
            HAWBHeaders.MODIFY;
          UNTIL HAWBHeaders.NEXT =0;
        END;
    end;

    local procedure CountMAWb(MAWB: Code[40]) Equal: Boolean
    var
        HAWB: Record "50074";
        Fams: Record "50058";
        i: Integer;
        j: Integer;
    begin
         HAWB.RESET;
         HAWB.SETRANGE(HAWB."MAWB No.",MAWB);//FAMs
         IF HAWB.FINDSET THEN BEGIN
         i:=0;
         REPEAT
          i+=1;
         UNTIL HAWB.NEXT = 0;
         END;

        Fams.RESET;
        Fams.SETRANGE(Fams."MAWB No",MAWB);
        IF Fams.FINDSET THEN BEGIN
          j:=0;
          REPEAT
            j+=1;
          UNTIL Fams.NEXT = 0;
        END;
        IF j=i THEN BEGIN
          Equal := TRUE;
        END ELSE BEGIN
          Equal :=FALSE;
        END;
    end;
}

