table 50074 "HAWB Line"
{

    fields
    {
        field(1; "HAWB No."; Code[20])
        {
            TableRelation = "HAWB Receipt"."HAWB No." WHERE(Assigned = FILTER(No));

            trigger OnValidate()
            begin
                IF HAWBReceipt.GET("HAWB No.") THEN BEGIN
                    //HAWBReceipt.TESTFIELD(Assigned,TRUE);
                    HAWBReceipt.Assigned := TRUE;
                    HAWBReceipt.Prepared := TRUE;
                    HAWBReceipt.MODIFY;
                END;
            end;
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item.No.;

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                Description := Item.Description;
            end;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Gross Weight"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
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
            Editable = true;
        }
        field(8; "Invoice No."; Code[20])
        {
        }
        field(9; "Line Amount"; Decimal)
        {
        }
        field(10; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(11; "Line No."; Integer)
        {
        }
        field(12; "Division/Farm Code"; Code[20])
        {
            TableRelation = Division/Farm.Code;
        }
        field(14;"Airline Code";Code[20])
        {
            TableRelation = Airline;
        }
        field(15;"Consignee Code";Code[20])
        {
            TableRelation = Consignee;
        }
        field(16;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE (Airline Code=FIELD(Airline Code));
        }
        field(17;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(18;"Flight Date";Date)
        {
        }
        field(19;"Unit of Measure Code";Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(20;Type;Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(21;"Shipper Code";Code[20])
        {
            TableRelation = Customer;
        }
        field(22;"MAWB No.";Code[20])
        {
        }
        field(23;"MAWB Prepared";Boolean)
        {
        }
        field(24;"Actual Weight";Decimal)
        {
        }
        field(25;"Total Quantity";Decimal)
        {
        }
        field(26;"Split Factor";Decimal)
        {
            Editable = false;
        }
        field(32;Comments;Text[250])
        {
        }
        field(33;"Custom Enrty No";Code[50])
        {
        }
        field(34;Phyto;Code[50])
        {
        }
        field(35;Lendth;Decimal)
        {
        }
        field(36;Width;Decimal)
        {
        }
        field(37;Height;Decimal)
        {
        }
        field(38;"Commercial Invoice No";Code[50])
        {
        }
        field(39;Currency;Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(40;Amount;Decimal)
        {
        }
        field(41;"Certifiate of Origin";Code[50])
        {

            trigger OnValidate()
            begin
                IF ((STRPOS('GSP',"Certifiate of Origin")=0) AND (STRPOS('EURO',"Certifiate of Origin")=0)) AND
                (STRPOS('COO',"Certifiate of Origin")=0) AND (STRPOS('COMESA',"Certifiate of Origin")=0) AND (STRPOS('EAC',"Certifiate of Origin")=0) AND (STRPOS('N/A',"Certifiate of Origin")=0) THEN
                BEGIN
                  MESSAGE('Please fill a Certificate Type');
                END;
            end;
        }
        field(42;"Shipment Date";Date)
        {
        }
    }

    keys
    {
        key(Key1;"Line No.","MAWB No.","HAWB No.","Shipper Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"HAWB No.",Description,"MAWB No.")
        {
        }
    }

    trigger OnDelete()
    begin
        BookingSheetHAWBAllocation.RESET;
        BookingSheetHAWBAllocation.SETRANGE("MAWB No.","MAWB No.");
        BookingSheetHAWBAllocation.SETRANGE("MAWB No.","MAWB No.");
        BookingSheetHAWBAllocation.SETRANGE("Item No.","Item No.");
        IF BookingSheetHAWBAllocation.FINDFIRST THEN BEGIN
          BookingSheetHAWBAllocation."HAWB Prepared":=FALSE;
          BookingSheetHAWBAllocation.MODIFY;
        END;
    end;

    var
        Item: Record "27";
        BookingSheetHAWBAllocation: Record "50056";
        BookingSheetLine: Record "50054";
        TotalQuantity: Decimal;
        RoundDirection: Text;
        RoundPrecision: Decimal;
        ImportExport: Record "50010";
        NxtLineNo: Integer;
        HawbLine: Record "50074";
        GrossWeight: Decimal;
        BookedWeight: Decimal;
        HAWBReceipt: Record "50037";

    [Scope('Internal')]
    procedure InsertMAWBFromHAWBLine(MAWBLine: Record "50076")
    var
        MAWBAllocationLine: Record "50076";
        TempMAWBLine: Record "50076";
        TransferOldExtLines: Codeunit "379";
        ItemTrackingMgt: Codeunit "6500";
        NextLineNo: Integer;
        ExtTextLine: Boolean;
        BookingSheetLine: Record "50054";
    begin
        SETRANGE("MAWB No.","MAWB No.");
        SETRANGE("HAWB No.","HAWB No.");
        SETRANGE("Shipper Code","Shipper Code");
        SETRANGE("Item No.","Item No.");
        SETRANGE("MAWB Prepared",FALSE);

        TempMAWBLine := MAWBLine;

        //*********INSERT MAWB LINES TO  FROM HAWB LINES*******
        IF MAWBLine.FIND('+') THEN BEGIN

         NxtLineNo := MAWBLine."Line No." +1000;

        END ELSE
          NxtLineNo := 1000;

        REPEAT

          MAWBAllocationLine.INIT;
          MAWBAllocationLine."MAWB No.":=MAWBAllocationLine."MAWB No.";
          MAWBAllocationLine."Line No." := MAWBAllocationLine."Line No.";

          MAWBLine:= MAWBAllocationLine;
          MAWBLine."MAWB No.":=TempMAWBLine."MAWB No.";
          MAWBLine."HAWB No.":="HAWB No.";
          MAWBLine."Line No." := NxtLineNo;
          MAWBLine.Type:=MAWBLine.Type::Item;
          MAWBLine."Item No.":="Item No.";
          MAWBLine.Quantity:=Quantity;
          MAWBLine."Gross Weight":="Gross Weight";
          MAWBLine."Chargeable Weight":="Chargeable Weight";
          MAWBLine."MAWB No.":="MAWB No.";
          MAWBLine."Airline Code":="Airline Code";
          MAWBLine."Consignee Code":="Consignee Code";
          MAWBLine.Description:=Description;
          MAWBLine."Unit of Measure Code":="Unit of Measure Code";
          MAWBLine."Flight Code":="Flight Code";
          MAWBLine."Flight Date":="Flight Date";
          MAWBLine."Destination Code":="Destination Code";
          MAWBLine."Shipper Code":="Shipper Code";
          MAWBLine."Division/Farm Code":="Division/Farm Code";
          MAWBLine."Custom Enrty No":= "Custom Enrty No";
          MAWBLine."Certificate of Origin":="Certifiate of Origin";
          MAWBLine.Phyto:= Phyto;
          MAWBLine.INSERT;
          "MAWB No.":=TempMAWBLine."MAWB No.";
          "MAWB Prepared":=TRUE;
          MODIFY;
          NxtLineNo := NxtLineNo + 10000;


        UNTIL (NEXT = 0);
    end;
}

