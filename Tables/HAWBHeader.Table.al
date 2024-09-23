table 50075 "HAWB Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
            TableRelation = "HAWB Receipt"."HAWB No." WHERE (Assigned = FILTER (No));
        }
        field(2; "Shipper Code"; Code[20])
        {
            TableRelation = Customer.No.;

            trigger OnValidate()
            begin
                Shipper.GET("Shipper Code");
                "Shipper Name":=Shipper.Name;
                "Shipper Address":=Shipper.Address;
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
            TableRelation = "Loading Sheet Line"."Consignee Code" WHERE (Shipper Code=FIELD(Shipper Code),
                                                                         MAWB No.=FIELD(MAWB No.));

            trigger OnValidate()
            begin
                IF Consignees.GET("Consignee Code") THEN BEGIN
                "Consignee Name":=Consignees.Name;
                END;
                HAWBLine1.RESET;
                HAWBLine1.SETRANGE(HAWBLine1."MAWB No.","MAWB No.");
                HAWBLine1.SETRANGE(HAWBLine1."Shipper Code","Shipper Code");
                HAWBLine1.SETRANGE(HAWBLine1."Consignee Code","Consignee Code");
                IF HAWBLine1.FIND('-') THEN BEGIN
                  HAWBLine1.DELETEALL;
                  NextLineNo:=1000
                END;

                LoadingSheet.RESET;
                LoadingSheet.SETRANGE(LoadingSheet."MAWB No.","MAWB No.");
                LoadingSheet.SETRANGE(LoadingSheet."Shipper Code","Shipper Code");
                LoadingSheet.SETRANGE(LoadingSheet."Consignee Code","Consignee Code");
                IF LoadingSheet.FINDSET THEN
                BEGIN
                  REPEAT
                    LoadingSheet.CALCFIELDS(LoadingSheet."FWL Docket Weight");
                    LoadingSheet.CALCFIELDS(LoadingSheet.Quantity);
                    //MESSAGE('%1',NextLineNo  );
                    HAWBLine.INIT;
                    HAWBLine."HAWB No." := '';
                    HAWBLine."Line No." :=NextLineNo ;// NextLineNo;
                    NextLineNo+=1000;
                    HAWBLine.Type:=HAWBLine.Type::Item;
                    HAWBLine."Item No.":=LoadingSheet."Item No.";
                    HAWBLine."MAWB No.":=LoadingSheet."MAWB No.";
                    HAWBLine."Airline Code":=LoadingSheet."Airline Code";
                    HAWBLine."Consignee Code":=LoadingSheet."Consignee Code";
                    HAWBLine."Division/Farm Code":=LoadingSheet."Division/Farm Code";
                    HAWBLine.Description:=LoadingSheet.Description;
                    HAWBLine."Unit of Measure Code":=LoadingSheet."Unit of Measure Code";
                    HAWBLine."Flight Code":=LoadingSheet."Flight Code";
                    HAWBLine."Destination Code":=LoadingSheet."Destination Code";
                    HAWBLine."Flight Date":=BookingSheetLine."Booking Date";
                    HAWBLine."Shipper Code":=LoadingSheet."Shipper Code";
                    HAWBLine."Actual Weight":=LoadingSheet."FWL Docket Weight";
                    HAWBLine."Gross Weight":=LoadingSheet."FWL Docket Weight";
                    HAWBLine.Quantity:=LoadingSheet.Quantity;
                    HAWBLine.Lendth:=LoadingSheet.Length;
                    HAWBLine.Width:= LoadingSheet.Width;
                    HAWBLine.Height:= LoadingSheet.Height;
                    HAWBLine.INSERT;
                 UNTIL LoadingSheet.NEXT=0;
                END;
            end;
        }
        field(6;"Consignee Name";Text[30])
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
        }
        field(11;"Destination Airport";Code[20])
        {
            TableRelation = Airport.Code;
        }
        field(12;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE (Airline Code=FIELD(Airline Code));
        }
        field(13;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(14;"Flight Date";Date)
        {
        }
        field(15;"MAWB No.";Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE (Assigned=FILTER(Yes),
                                                             Prepared=FILTER(No));

            trigger OnValidate()
            begin
                IF ImpExpSetup.GET THEN
                  BEGIN
                    "Source Airport" := ImpExpSetup."Source Airport";
                    "Carrier Agent Code" := ImpExpSetup."Carrier Agent Code";
                    "Agent's IATA Code" :=  ImpExpSetup."Agent's IATA Code";
                  END;
            end;
        }
        field(16;Invoiced;Boolean)
        {
        }
        field(17;"Euro Form No.";Code[20])
        {
        }
        field(18;"Customer Entry No.";Code[20])
        {
        }
        field(19;"Phyto Certificate No.";Code[20])
        {
        }
        field(20;"Booking Sheet No.";Code[20])
        {
            Editable = false;
            TableRelation = "Booking Sheet Header" WHERE (Shipper Code=FIELD(Shipper Code),
                                                          Status=FILTER(Received));
        }
        field(21;Status;Option)
        {
            OptionCaption = 'New,Submitted,Archived';
            OptionMembers = New,Submitted,Archived;
        }
        field(26;Comments;Text[250])
        {
        }
        field(27;"Total Weight";Decimal)
        {
            CalcFormula = Sum("HAWB Line"."Gross Weight" WHERE (HAWB No.=FIELD(No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28;"Commercial Invoice No";Code[30])
        {
        }
        field(29;Currency;Code[10])
        {
        }
        field(30;Amount;Decimal)
        {
        }
        field(31;Line;Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1;"No.","MAWB No.","Shipper Code","Consignee Code",Line)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*GetHAWB.RESET;
        GetHAWB.SETRANGE(GetHAWB."HAWB No.","No.");
        GetHAWB.SETRANGE(GetHAWB."HAWB Prepared",FALSE);
        IF GetHAWB.FIND('-')THEN BEGIN
          ExportGetHAWBItem.SetHAWBHeader(Rec);
          ExportGetHAWBItem.CreateHAWBLines(GetHAWB);
        END; */

    end;

    var
        BookingSheetHAWBAllocation: Record "50056";
        HAWBLine: Record "50074";
        BookingSheetLine: Record "50054";
        Shipper: Record "18";
        Consignee: Record "50015";
        HAWBReceipt: Record "50037";
        HAWBLine2: Record "50074";
        TotalQuantity: Decimal;
        BookingSheetHAWBAlloc: Record "50056";
        HAWBLine3: Record "50074";
        NextLineNo: Decimal;
        ImpExpSetup: Record "50010";
        BookingSheetMAWBAlloc: Record "50070";
        LoadingSheet: Record "50061";
        loadingSheetHeader: Record "50060";
        Consignees: Record "50015";
        HAWBHeader: Record "50075";
        HAWBLine1: Record "50074";
}

