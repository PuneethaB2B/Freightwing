table 50065 "Offloaded Gatepass Line"
{

    fields
    {
        field(1; "Gate-Pass No."; Code[20])
        {
            TableRelation = "Offloaded Gatepass Header"."Gate Pass No";
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                Description := Item.Description;
            end;
        }
        field(3; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(4; Quantity; Decimal)
        {
        }
        field(5; "Vehicle No."; Code[20])
        {
        }
        field(6; "Driver Name"; Text[50])
        {
        }
        field(7; "Escort Vehicle No."; Code[20])
        {
        }
        field(8; "Supervisor Name"; Text[50])
        {
        }
        field(9; Description; Text[50])
        {
        }
        field(10; "ULD Type"; Code[20])
        {
            TableRelation = "ULD Type".Code;
        }
        field(11; "ULD No."; Code[20])
        {

            trigger OnValidate()
            begin
                LoadingSheetULDAlloc.RESET;
                LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc."MWAB No.", "MAWB No.");
                //LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc."ULD Type Code","ULD Type");
                LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc."ULD No.", "ULD No.");
                IF LoadingSheetULDAlloc.FINDFIRST THEN BEGIN
                    Quantity := LoadingSheetULDAlloc."No. Of Boxes";
                    "Loaded Weight" := LoadingSheetULDAlloc."FWL Docket Weight";
                    "ULD Type" := LoadingSheetULDAlloc."ULD Type Code";
                    LoadingSheetLine.RESET;
                    LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", LoadingSheetULDAlloc."Loading Sheet No.");
                    IF LoadingSheetLine.FINDFIRST THEN BEGIN
                        "Shipper Code" := LoadingSheetLine."Shipper Code";
                        "Consignee Code" := LoadingSheetLine."Consignee Code";
                        Shippers.GET("Shipper Code");
                        "Shipper Name" := Shippers.Name;
                    END;
                    VALIDATE("Offloaded Weight");
                    //MESSAGE('%1',LoadingSheetULDAlloc."No. Of Boxes");
                END ELSE BEGIN
                    MESSAGE('Not Found');
                END;
            end;
        }
        field(12; "Line No."; Integer)
        {
        }
        field(13; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            InitValue = Item;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(14; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(15; "MAWB No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
        }
        field(16; "Airline Code"; Code[20])
        {
            Editable = false;
        }
        field(17; "Flight Code"; Code[20])
        {
            Editable = false;
        }
        field(18; "Consignee Code"; Code[250])
        {
            Editable = false;
        }
        field(19; "Shipper Code"; Code[20])
        {
            TableRelation = "Loading Sheet Header"."Shipper Code";
        }
        field(20; "Loading Sheet No."; Code[20])
        {
            TableRelation = "Loading Sheet Header".No. WHERE(Status = FILTER(Closed));
        }
        field(21; "HAWB No"; Code[50])
        {
            TableRelation = "HAWB Line"."HAWB No." WHERE(MAWB No.=FIELD(MAWB No.));
        }
        field(23;"Certificate Of Origin";Code[20])
        {
            Description = 'Certificate of Origin';
        }
        field(29;"Custom Entry No";Code[50])
        {
        }
        field(30;"Phyto Certificate";Code[50])
        {
        }
        field(31;Remarks;Text[250])
        {
        }
        field(32;Offloaded;Boolean)
        {
        }
        field(33;"Shipper Name";Text[30])
        {
        }
        field(34;"Offloaded Boxes";Decimal)
        {
        }
        field(35;"Offloaded Weight";Decimal)
        {

            trigger OnValidate()
            begin
                Diffrence:="Loaded Weight"-"Offloaded Weight"
            end;
        }
        field(36;Diffrence;Decimal)
        {
        }
        field(37;"Loaded Weight";Decimal)
        {
        }
        field(39;"Boxes Diff";Decimal)
        {
        }
        field(40;"Ship With Same AWB";Boolean)
        {
        }
        field(41;No;Code[30])
        {
            TableRelation = "Offloaded Gatepass Header".No;
        }
    }

    keys
    {
        key(Key1;"Gate-Pass No.",No,"Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //GatePassHeader.GET("Gate-Pass No.");
    end;

    trigger OnInsert()
    begin
        "Line No."+=1000;
    end;

    var
        Item: Record "27";
        LoadingSheetLine: Record "50061";
        GatePassHeader: Record "50068";
        GatePassULDAllocation: Record "50070";
        HAWBLine: Record "50074";
        HAWBHeader: Record "50075";
        LoadingSheetULDAlloc: Record "50063";
        Style: Boolean;
        Shippers: Record "18";
}

