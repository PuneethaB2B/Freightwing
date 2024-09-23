table 50054 "Booking Sheet Line"
{

    fields
    {
        field(1; "Booking Sheet No."; Code[20])
        {
            TableRelation = "Booking Sheet Header".No.;
        }
        field(2;"Line No.";Integer)
        {
        }
        field(3;Description;Text[50])
        {
        }
        field(4;"Unit of Measure Code";Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(5;Type;Option)
        {
            Caption = 'Type';
            Editable = false;
            InitValue = Item;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item.No.;

            trigger OnValidate()
            var
                ICPartner: Record "413";
                ItemCrossReference: Record "5717";
                PrepmtMgt: Codeunit "441";
            begin
                Item.GET("Item No.");
                Description:=Item.Description;

                BookingSheetHeader.GET("Booking Sheet No.");
                "Booking Date":=BookingSheetHeader."Booking Date";
                "Shipper Code":=BookingSheetHeader."Shipper Code";


                DailyWeightDistByItem.RESET;
                DailyWeightDistByItem.SETRANGE(DailyWeightDistByItem."Airline Code","Airline Code");
                DailyWeightDistByItem.SETRANGE(DailyWeightDistByItem."Customer No.","Shipper Code");
                DailyWeightDistByItem.SETRANGE(DailyWeightDistByItem."Item No.","Item No.");
                IF DailyWeightDistByItem.FINDFIRST THEN BEGIN
                 //BookingSheetHeader.GET("Booking No.");
                  DailyWeightDistByAirline.RESET;
                  DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Daily No.",DailyWeightDistByItem."Daily No.");
                  DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Airline Code",DailyWeightDistByItem."Airline Code");
                  DailyWeightDistByAirline.SETRANGE(DailyWeightDistByAirline."Distribution Date",BookingSheetHeader."Booking Date");
                  IF DailyWeightDistByAirline.FINDFIRST THEN BEGIN
                    "Flight Code":=DailyWeightDistByAirline."Flight Code";
                    "Destination Code":=DailyWeightDistByAirline."Destination Code";
                    "Cut-off Time":=DailyWeightDistByAirline."Cut-off Time";
                    "Booked Weight":=DailyWeightDistByItem."Gross Weight";
                  END;
                END;
            end;
        }
        field(7;"Booked Weight";Decimal)
        {
            Caption = 'Booked Weight';
            DecimalPlaces = 2:2;
            Editable = false;
        }
        field(8;"Actual Weight";Decimal)
        {

            trigger OnValidate()
            begin
                "Weight Difference":="Booked Weight"-"Actual Weight";
            end;
        }
        field(11;"ULD Type Code";Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(12;"ULD No.";Code[20])
        {
            TableRelation = ULD."ULD No." WHERE (ULD Type Code=FIELD(ULD Type Code));
        }
        field(13;Quantity;Decimal)
        {
        }
        field(14;"Weight Difference";Decimal)
        {
            Editable = false;
        }
        field(15;"Booked Line Amount";Decimal)
        {
            Editable = false;
        }
        field(16;"Actual Line Amount";Decimal)
        {
            Editable = false;
        }
        field(17;"Rate Amount";Decimal)
        {
            Editable = false;
        }
        field(18;"Location Code";Code[20])
        {
            TableRelation = Location;
        }
        field(19;"Product Group Code";Code[20])
        {
            TableRelation = "Product Group".Code;
        }
        field(20;Status;Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(21;"Approved By";Code[20])
        {
            Editable = false;
        }
        field(22;"Approval Date";Date)
        {
            Editable = false;
        }
        field(23;"Consignee Code";Code[20])
        {
            TableRelation = Consignee.No.;
        }
        field(24;"Clearing Agent Code";Code[20])
        {
            TableRelation = "Shipping Agent".Code;
        }
        field(25;"Airline Code";Code[20])
        {
            TableRelation = Airline.Code;
        }
        field(26;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight No." WHERE (Airline Code=FIELD(Airline Code));
        }
        field(27;"MAWB No.";Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE (Airline Code=FIELD(Airline Code),
                                                             Prepared=FILTER(No));
        }
        field(28;"Port of Loading";Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(29;"Cut-off Time";Time)
        {
            Editable = false;

            trigger OnValidate()
            begin
                "Shipment Delivery Time":=("Departure Time"-"Cut-off Time")/(60*60*1000);
            end;
        }
        field(30;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(31;"Port of Discharge";Code[20])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));
        }
        field(32;"Place of Delivery";Text[30])
        {
        }
        field(33;"Via Route/Transist";Code[20])
        {
            TableRelation = "Via Destination"."Via Destination Code" WHERE (Airline Code=FIELD(Airline Code),
                                                                            Flight Code=FIELD(Via Route/Transist),
                                                                            FS Destination Code=FIELD(Destination Code));
        }
        field(34;"MAWB Date";Date)
        {
            Editable = false;
        }
        field(35;"Type of Delivery";Code[20])
        {
            TableRelation = "Delivery Type";
        }
        field(36;"Booking Date";Date)
        {
        }
        field(37;"Shipper Code";Code[20])
        {
            Editable = true;
        }
        field(38;"Division/Farm Code";Code[20])
        {
            TableRelation = "Shipper Farm"."Farm Code" WHERE (Shipper Code=FIELD(Shipper Code));
        }
        field(40;"Good Receipt No.";Code[20])
        {
        }
        field(41;"Source Airport";Code[50])
        {
            FieldClass = Normal;

            trigger OnLookup()
            begin
                ViaDestination.RESET;
                ViaDestination.SETRANGE(ViaDestination."Flight Code","Flight Code");
                IF ViaDestination.FIND('-') THEN
                BEGIN
                //SetLookUp(ViaDestination);
                END;
            end;
        }
        field(42;"Destination Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));
        }
        field(43;"Source Code";Code[50])
        {
        }
        field(44;"Connecting Airline";Code[10])
        {
            TableRelation = Airline.Code;
        }
        field(45;"Connecting Flight No.";Code[10])
        {
            TableRelation = Flight."Flight No." WHERE (Airline Code=FIELD(Connecting Airline));
        }
        field(46;"Connecting Flight Date";Date)
        {
        }
        field(47;"Departure Time";Time)
        {

            trigger OnValidate()
            begin
                ImportExportSetup.GET;
                 "Shipment Delivery Time":=ImportExportSetup."CutOff Time";
                 "Cut-off Time":="Departure Time"-(("Shipment Delivery Time")*60*60*1000);
            end;
        }
        field(48;"Shipment Delivery Time";Integer)
        {

            trigger OnValidate()
            begin
                 "Cut-off Time":="Departure Time"-("Shipment Delivery Time"*(60*60*1000));
            end;
        }
        field(50000;Comments;Text[250])
        {
        }
        field(50001;"Estimated Arrival Time";Time)
        {
            Caption = 'Estimated Arrival Time';
        }
        field(50003;"Connected Flight ETD";Time)
        {
        }
        field(50004;"Connected Flight ETA";Time)
        {
        }
        field(50005;"Send Email";Boolean)
        {
        }
        field(50006;"Email Sent";Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Booking Sheet No.","Line No.","Airline Code","Flight Code")
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
        DailyWeightDistByItem.RESET;
        DailyWeightDistByItem.SETRANGE("Booking Sheet No.","Booking Sheet No.");
        DailyWeightDistByItem.SETRANGE("Airline Code","Airline Code");
        DailyWeightDistByItem.SETRANGE("Flight Code","Flight Code");
        DailyWeightDistByItem.SETRANGE("Customer No.","Shipper Code");
        DailyWeightDistByItem.SETRANGE("Item No.","Item No.");
        IF DailyWeightDistByItem.FINDFIRST THEN BEGIN
          REPEAT
            DailyWeightDistByItem."Booking Sheet No.":='';
            DailyWeightDistByItem.MODIFY;
          UNTIL DailyWeightDistByItem.NEXT=0;
        END;

        BookingSheetULDAllocation.RESET;
        BookingSheetULDAllocation.SETRANGE("Booking Sheet No.","Booking Sheet No.");
        BookingSheetULDAllocation.SETRANGE("Airline Code","Airline Code");
        BookingSheetULDAllocation.SETRANGE("Flight Code","Flight Code");
        BookingSheetULDAllocation.SETRANGE("Shipper Code","Shipper Code");
        BookingSheetULDAllocation.SETRANGE("Item No.","Item No.");
        IF BookingSheetULDAllocation.FINDFIRST THEN BEGIN
          BookingSheetULDAllocation.DELETEALL;
        END;

        BSConsignee.RESET;
        BSConsignee.SETRANGE("Booking Sheet No.","Booking Sheet No.");
        BSConsignee.SETRANGE("Airline Code","Airline Code");
        BSConsignee.SETRANGE("Flight Code","Flight Code");
        BSConsignee.SETRANGE("Shipper Code","Shipper Code");
        BSConsignee.SETRANGE("Item No.","Item No.");
        IF BSConsignee.FINDFIRST THEN BEGIN
          BSConsignee.DELETEALL;
        END;

        BookingSheetNotifyParty.RESET;
        BookingSheetNotifyParty.SETRANGE("Booking Sheet No.","Booking Sheet No.");
        BookingSheetNotifyParty.SETRANGE("Airline Code","Airline Code");
        BookingSheetNotifyParty.SETRANGE("Flight Code","Flight Code");
        BookingSheetNotifyParty.SETRANGE("Shipper Code","Shipper Code");
        BookingSheetNotifyParty.SETRANGE("Item No.","Item No.");
        IF BookingSheetNotifyParty.FINDFIRST THEN BEGIN
          BookingSheetNotifyParty.DELETEALL;
        END;
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Booking Sheet No","Booking Sheet No.");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Item No","Item No.");
        //BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No","MAWB No."
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Airline Code","Airline Code");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Flight No","Flight Code");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Source Airport","Source Airport");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Destination Airport","Destination Airport");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code","Shipper Code");
        IF BookingSheetMAWBAllocation.FINDFIRST THEN
        BookingSheetMAWBAllocation.DELETEALL;
    end;

    trigger OnInsert()
    begin
        BookingSheetHeader.GET("Booking Sheet No.");
        NotifyParty.RESET;
        NotifyParty.SETRANGE(NotifyParty.Type,NotifyParty.Type::Operations);
        IF NotifyParty.FINDSET THEN BEGIN
         REPEAT
          BookingSheetNotifyParty.INIT;
          BookingSheetNotifyParty."Booking Sheet No.":=BookingSheetHeader."No." ;
          BookingSheetNotifyParty."Airline Code":=BookingSheetHeader."Airline Code";
          BookingSheetNotifyParty."Flight Code":=BookingSheetHeader."Flight Code";
          BookingSheetNotifyParty."Shipper Code":=BookingSheetHeader."Shipper Code";
          BookingSheetNotifyParty."Item No.":="Item No.";
          BookingSheetNotifyParty."Notify-Party No.":=NotifyParty."No.";
          BookingSheetNotifyParty."Notify-Party Name":=NotifyParty.Name;
          BookingSheetNotifyParty."Source Type":=NotifyParty.Type::Consignee;
          BookingSheetNotifyParty."Source Code":=NotifyParty."Type Code";
          BookingSheetNotifyParty.INSERT;
         UNTIL NotifyParty.NEXT=0;
        END;
    end;

    var
        HAWBReceipt: Record "50037";
        Item: Record "27";
        BookingSheetHeader: Record "50053";
        DailyWeightDistByCustomer: Record "50042";
        DailyWeightDistByItem: Record "50043";
        Shipper: Record "18";
        DailyWeightDistByAirline: Record "50041";
        BookingSheetULDAllocation: Record "50055";
        BSConsignee: Record "50056";
        GoodReceiptULDAllocation: Record "50046";
        Text001: Label 'You cannot delete Item No. %1 because it has entries associated with it';
        BookingSheetNotifyParty: Record "50057";
        GoodReceiptNotifyParty: Record "50049";
        NotifyParty: Record "50017";
        BookingSheetMAWBAllocation: Record "50070";
        ViaDestination: Record "50024";
        Flight: Record "50022";
        Farms: Record "50058";
        ImportExportSetup: Record "50010";

    [Scope('Internal')]
    procedure InsertGoodsReceiptFromBookingSheetLine(var GoodReceiptLine: Record "50051")
    var
        GoodReceiptHeader: Record "50052";
        GoodReceiptAllocationHeader: Record "50052";
        GoodReceiptAllocationLine: Record "50051";
        TempGoodReceiptLine: Record "50051";
        TransferOldExtLines: Codeunit "379";
        ItemTrackingMgt: Codeunit "6500";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        BookingSheetLine: Record "50054";
    begin
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Booking Sheet No","Booking Sheet No.");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Flight No","Flight Code");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Item No","Item No.");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Airline Code","Airline Code");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Source Airport","Source Airport");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Destination Airport","Destination Airport");
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code","Shipper Code");
        IF BookingSheetMAWBAllocation.FINDSET THEN
        BEGIN
         REPEAT
          BSConsignee.RESET;
          BSConsignee.SETRANGE(BSConsignee."Booking Sheet No.",BookingSheetMAWBAllocation."Booking Sheet No");
          BSConsignee.SETRANGE(BSConsignee."Airline Code",BookingSheetMAWBAllocation."Airline Code");
          BSConsignee.SETRANGE(BSConsignee."Shipper Code",BookingSheetMAWBAllocation."Shipper Code");
          BSConsignee.SETRANGE(BSConsignee."Source Airport",BookingSheetMAWBAllocation."Source Airport");
          BSConsignee.SETRANGE(BSConsignee."Destination Airport",BookingSheetMAWBAllocation."Destination Airport");
          BSConsignee.SETRANGE(BSConsignee."MAWB No.",BookingSheetMAWBAllocation."MAWB No");
          IF BSConsignee.FINDSET THEN
          BEGIN
            REPEAT
              Farms.RESET;
              Farms.SETRANGE(Farms."Booking Sheet No",BSConsignee."Booking Sheet No.");
              Farms.SETRANGE(Farms."Shipper Code",BSConsignee."Shipper Code");
              Farms.SETRANGE(Farms."Source Airport" ,BSConsignee."Source Airport");
              Farms.SETRANGE(Farms."Destination Airport",BSConsignee."Destination Airport");
              Farms.SETRANGE(Farms."Airline Code",BSConsignee."Airline Code");
              Farms.SETRANGE(Farms."MAWB No",BSConsignee."MAWB No.");
              Farms.SETRANGE(Farms."Consignee Code",BSConsignee."Consignee Code");
              IF Farms.FINDSET THEN
              BEGIN
                REPEAT
                  IF GoodReceiptLine.FIND('+') THEN
                  BEGIN
                    NextLineNo := GoodReceiptLine."Line No." +1000;
                  END ELSE
                    NextLineNo := 1000;

                  SETRANGE("Booking Sheet No.",Farms."Booking Sheet No");
                  SETRANGE("Flight Code",Farms."Flight Code");
                  SETRANGE("Shipper Code",Farms."Shipper Code");
                  SETRANGE("Item No.",Farms."Item No");
                  SETRANGE("Destination Airport",Farms."Destination Airport");
                  SETRANGE("Source Airport",Farms."Source Airport");
                  TempGoodReceiptLine := GoodReceiptLine;
                  REPEAT
                     BookingSheetMAWBAllocation.CALCFIELDS(BookingSheetMAWBAllocation."Weight Allocated");
                     GoodReceiptAllocationLine.INIT;
                     GoodReceiptAllocationLine."Good Receipt No.":=GoodReceiptAllocationLine."Good Receipt No.";
                     GoodReceiptAllocationLine."Line No." := GoodReceiptAllocationLine."Line No.";
                     GoodReceiptLine:= GoodReceiptAllocationLine;
                     GoodReceiptLine."Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                     GoodReceiptLine."Line No." := NextLineNo;
                     GoodReceiptLine.Type:=GoodReceiptLine.Type::Item;
                     GoodReceiptLine."Item No.":="Item No.";
                     GoodReceiptLine.Quantity:=Quantity;
                     IF Farms.Weight <> 0 THEN BEGIN
                      GoodReceiptLine."Booked Weight":=Farms.Weight;
                     END ELSE BEGIN
                      GoodReceiptLine."Booked Weight":=BookingSheetMAWBAllocation."Weight Allocated";
                     END;
                     GoodReceiptLine."Actual Weight":="Actual Weight";
                     GoodReceiptLine."MAWB No.":=BookingSheetMAWBAllocation."MAWB No";
                     GoodReceiptLine."Airline Code":=BookingSheetMAWBAllocation."Airline Code";
                     GoodReceiptLine."Flight Code":=BookingSheetMAWBAllocation."Flight No";
                     GoodReceiptLine."Consignee Code":=Farms."Consignee Code";
                     //MESSAGE(BookingSheetMAWBAllocation."Flight No");
                     GoodReceiptLine.Description:=Description;
                     GoodReceiptLine."Unit of Measure Code":="Unit of Measure Code";
                     GoodReceiptLine."Destination Code":="Destination Code";
                     GoodReceiptLine."Shipper Code":=Farms."Shipper Code";
                     GoodReceiptLine."Division/Farm Code":=Farms."Farm Code";
                     GoodReceiptLine."Location Code":="Location Code";
                     GoodReceiptLine."Cut-off Time":="Cut-off Time";
                     GoodReceiptLine."Division/Farm Code":=Farms."Farm Code";
                     "Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                     GoodReceiptLine."Type of Delivery":="Type of Delivery";
                     GoodReceiptLine."Clearing Agent Code":="Clearing Agent Code";
                     GoodReceiptLine."Source Airport":="Source Airport";
                     GoodReceiptLine."Destination Airport":="Destination Airport";
                     GoodReceiptLine."Source Code":="Source Code";
                     GoodReceiptLine."Destination Code":="Destination Code";
                     GoodReceiptLine.VALIDATE(GoodReceiptLine."Consignee Code",Farms."Consignee Code");
                     //"Good Receipt No.":=GoodReceiptAllocationLine."Good Receipt No.";
                     MODIFY;
                     BookingSheetNotifyParty.RESET;
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Booking Sheet No.",BSConsignee."Booking Sheet No.");
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Airline Code",BSConsignee."Airline Code");
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Flight Code",BSConsignee."Flight Code");
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Shipper Code",BSConsignee."Shipper Code");
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Source Airport",BSConsignee."Source Airport");
                     BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Destination Airport",BSConsignee."Destination Airport");
                     IF BookingSheetNotifyParty.FINDSET THEN
                     BEGIN
                       REPEAT
                       GoodReceiptNotifyParty."Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                       GoodReceiptNotifyParty."Shipper Code":=BookingSheetNotifyParty."Shipper Code";
                       GoodReceiptNotifyParty."Airline Code":=BookingSheetNotifyParty."Airline Code";
                       GoodReceiptNotifyParty."Flight Code":=BookingSheetNotifyParty."Flight Code";
                       GoodReceiptNotifyParty."Item No.":=BookingSheetNotifyParty."Item No.";
                       GoodReceiptNotifyParty."Notify-Party No.":=BookingSheetNotifyParty."Notify-Party No.";
                       GoodReceiptNotifyParty."Notify-Party Name":=BookingSheetNotifyParty."Notify-Party Name";
                       GoodReceiptNotifyParty."Source Type":=BookingSheetNotifyParty."Source Type";
                       GoodReceiptNotifyParty."Source Code":=BookingSheetNotifyParty."Source Code";
                       GoodReceiptNotifyParty."Line No.":=GoodReceiptNotifyParty."Line No."+1000;
                       GoodReceiptNotifyParty."Source Airport":=BookingSheetNotifyParty."Source Airport";
                       GoodReceiptNotifyParty."Destination Airport":=BookingSheetNotifyParty."Destination Airport";
                       GoodReceiptNotifyParty.FAM:=BookingSheetNotifyParty.FAM;
                       GoodReceiptNotifyParty.INSERT;
                     UNTIL BookingSheetNotifyParty.NEXT=0;
                    END;//END BookingSheetNotifyParty
                    GoodReceiptLine.INSERT;
                  UNTIL NEXT = 0;
                UNTIL Farms.NEXT = 0;
              END//FARMS
              ELSE
              BEGIN
               IF GoodReceiptLine.FIND('+') THEN
               BEGIN
                 NextLineNo := GoodReceiptLine."Line No." +1000;
               END ELSE
                 NextLineNo := 1000;

               SETRANGE("Booking Sheet No.",BSConsignee."Booking Sheet No.");
               SETRANGE("Flight Code",BSConsignee."Flight Code");
               SETRANGE("Shipper Code",BSConsignee."Shipper Code");
               SETRANGE("Item No.",BSConsignee."Item No.");
               SETRANGE("Destination Airport",BSConsignee."Destination Airport");
               SETRANGE("Source Airport",BSConsignee."Source Airport");
               TempGoodReceiptLine := GoodReceiptLine;
               REPEAT
              // MESSAGE(BSConsignee."Consignee Code");
                  BookingSheetMAWBAllocation.CALCFIELDS(BookingSheetMAWBAllocation."Weight Allocated");
                  "Good Receipt No.":=GoodReceiptAllocationLine."Good Receipt No.";
                  GoodReceiptAllocationLine.INIT;
                  GoodReceiptAllocationLine."Good Receipt No.":=GoodReceiptAllocationLine."Good Receipt No.";
                  GoodReceiptAllocationLine."Line No." := GoodReceiptAllocationLine."Line No.";
                  GoodReceiptLine:= GoodReceiptAllocationLine;
                  GoodReceiptLine."Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                  GoodReceiptLine."Line No." := NextLineNo;
                  GoodReceiptLine.Type:=GoodReceiptLine.Type::Item;
                  GoodReceiptLine."Item No.":="Item No.";
                  GoodReceiptLine.Quantity:=Quantity;
                  GoodReceiptLine."Booked Weight":=BookingSheetMAWBAllocation."Weight Allocated";
                  GoodReceiptLine."Actual Weight":="Actual Weight";
                  GoodReceiptLine."MAWB No.":=BookingSheetMAWBAllocation."MAWB No";
                  GoodReceiptLine."Airline Code":=BSConsignee."Airline Code";
                  GoodReceiptLine."Consignee Code":=BSConsignee."Consignee Code";
                  GoodReceiptLine.Description:=Description;
                  GoodReceiptLine."Unit of Measure Code":="Unit of Measure Code";
                  GoodReceiptLine."Flight Code":=BookingSheetMAWBAllocation."Flight No";//BSConsignee."Flight Code";
                  ///MESSAGE(BookingSheetMAWBAllocation."Flight No");
                  GoodReceiptLine."Destination Code":="Destination Code";
                  GoodReceiptLine."Shipper Code":=BSConsignee."Shipper Code";
                  //GoodReceiptLine."Division/Farm Code":=Farms."Farm Code";
                  GoodReceiptLine."Location Code":="Location Code";
                  GoodReceiptLine."Cut-off Time":="Cut-off Time";
                  GoodReceiptLine."Division/Farm Code":=Farms."Farm Code";
                  "Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                  GoodReceiptLine."Type of Delivery":="Type of Delivery";
                  GoodReceiptLine."Clearing Agent Code":="Clearing Agent Code";
                  GoodReceiptLine."Source Airport":="Source Airport";
                  GoodReceiptLine."Destination Airport":="Destination Airport";
                  GoodReceiptLine."Source Code":="Source Code";
                  GoodReceiptLine."Destination Code":="Destination Code";
                  GoodReceiptLine.VALIDATE(GoodReceiptLine."Consignee Code",BSConsignee."Consignee Code");
                  MODIFY;
                  BookingSheetNotifyParty.RESET;
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Booking Sheet No.",BSConsignee."Booking Sheet No.");
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Airline Code",BSConsignee."Airline Code");
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Flight Code",BSConsignee."Flight Code");
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Shipper Code",BSConsignee."Shipper Code");
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Source Airport",BSConsignee."Source Airport");
                  BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Destination Airport",BSConsignee."Destination Airport");
                  IF BookingSheetNotifyParty.FINDSET THEN
                  BEGIN
                    REPEAT
                    GoodReceiptNotifyParty."Good Receipt No.":=TempGoodReceiptLine."Good Receipt No.";
                    GoodReceiptNotifyParty."Shipper Code":=BookingSheetNotifyParty."Shipper Code";
                    GoodReceiptNotifyParty."Airline Code":=BookingSheetNotifyParty."Airline Code";
                    GoodReceiptNotifyParty."Flight Code":=BookingSheetNotifyParty."Flight Code";
                    GoodReceiptNotifyParty."Item No.":=BookingSheetNotifyParty."Item No.";
                    GoodReceiptNotifyParty."Notify-Party No.":=BookingSheetNotifyParty."Notify-Party No.";
                    GoodReceiptNotifyParty."Notify-Party Name":=BookingSheetNotifyParty."Notify-Party Name";
                    GoodReceiptNotifyParty."Source Type":=BookingSheetNotifyParty."Source Type";
                    GoodReceiptNotifyParty."Source Code":=BookingSheetNotifyParty."Source Code";
                    GoodReceiptNotifyParty."Line No.":=GoodReceiptNotifyParty."Line No."+1000;
                    GoodReceiptNotifyParty."Source Airport":=BookingSheetNotifyParty."Source Airport";
                    GoodReceiptNotifyParty."Destination Airport":=BookingSheetNotifyParty."Destination Airport";
                    GoodReceiptNotifyParty.FAM:=BookingSheetNotifyParty.FAM;
                    GoodReceiptNotifyParty.INSERT;
                  UNTIL BookingSheetNotifyParty.NEXT=0;
                 END;//END BookingSheetNotifyParty
                 GoodReceiptLine.INSERT;
               UNTIL NEXT = 0;
              END;//NO Farms
            UNTIL BSConsignee.NEXT = 0;
          END//BSConsignee
          ELSE BEGIN
          ERROR('No Consignee For the MAWB No.');
          END;//No BS Consignee
         UNTIL BookingSheetMAWBAllocation.NEXT = 0;
        END;//MAWBs
    end;

    local procedure GetFARMS(mawb: Record "50070") no: Integer
    var
        lines: Record "50054";
    begin
        lines.RESET;
        lines.SETRANGE(lines."Booking Sheet No.",BookingSheetMAWBAllocation."Booking Sheet No");
        lines.SETRANGE(lines."Airline Code",BookingSheetMAWBAllocation."Airline Code");
        lines.SETRANGE(lines."Flight Code",BookingSheetMAWBAllocation."Flight No");
        IF lines.FINDSET THEN
        BEGIN
          Farms.RESET;
          Farms.SETRANGE(Farms."Booking Sheet No",lines."Booking Sheet No.");
          Farms.SETRANGE(Farms."Item No",lines."Item No.");
          Farms.SETRANGE(Farms."Shipper Code",lines."Shipper Code");
          Farms.SETRANGE(Farms."Source Airport",lines."Source Airport");
          Farms.SETRANGE(Farms."Destination Airport",lines."Destination Airport" );
          IF Farms.FINDSET THEN
          BEGIN
          no:=0;
          REPEAT
          no+=1;
          UNTIL Farms.NEXT = 0;
          END;
          IF no > 0 THEN
          BEGIN
            EXIT(no);
          END ELSE BEGIN
          no:=1;
          EXIT(no);
          END;
        END;
    end;
}

