table 50069 "Gate Pass Line"
{

    fields
    {
        field(1; "Gate-Pass No."; Code[20])
        {
            TableRelation = "Gate Pass Header"."No.";
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
        field(11; "ULD No."; Code[50])
        {
            TableRelation = "Loading Sheet ULD Allocation"."ULD No." WHERE("MWAB No." = FIELD("MAWB No."),
                                                                            Released = FILTER(false));
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
            TableRelation = "MAWB Header 2"."No." WHERE("Gate Pass Prepared" = FILTER(false),
                                                       Status = FILTER(Archived | Submitted));

            trigger OnValidate()
            begin
                MAWBs.RESET;
                MAWBs.SETRANGE(MAWBs."No.", "MAWB No.");
                IF MAWBs.FINDFIRST THEN BEGIN
                    IF MAWBs."Has Houses" THEN BEGIN
                    END
                    ELSE BEGIN
                        "Phyto Certificate" := MAWBs."Phyto Certificate";
                        "Custom Entry No" := MAWBs."Custom Entry No";
                    END;
                END;
            end;
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
            TableRelation = "Loading Sheet Header"."No." WHERE(Status = FILTER(Closed));
        }
        field(21; "HAWB No"; Code[50])
        {
            TableRelation = "HAWB Line"."HAWB No." WHERE("MAWB No." = FIELD("MAWB No."));

            trigger OnValidate()
            begin
                HAWBLine.RESET;
                HAWBLine.SETRANGE(HAWBLine."MAWB No.", "MAWB No.");
                HAWBLine.SETRANGE(HAWBLine."HAWB No.", "HAWB No");
                IF HAWBLine.FINDFIRST THEN BEGIN
                    "Custom Entry No" := HAWBLine."Custom Enrty No";
                    "Phyto Certificate" := HAWBLine.Phyto;
                    LoadingSheetULDAlloc.RESET;
                    LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc."ULD No.", "ULD No.");
                    LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc."MWAB No.", "MAWB No.");
                    LoadingSheetULDAlloc.SETRANGE(LoadingSheetULDAlloc.Released, FALSE);
                    IF LoadingSheetULDAlloc.FINDFIRST THEN
                        "Loading Sheet No." := LoadingSheetULDAlloc."Loading Sheet No.";
                END;
            end;
        }
        field(23; "Certificate Of Origin"; Code[20])
        {
            Description = 'Certificate of Origin';
        }
        field(29; "Custom Entry No"; Code[50])
        {
        }
        field(30; "Phyto Certificate"; Code[50])
        {
        }
        field(31; Remarks; Text[250])
        {
        }
        field(32; Offloaded; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Gate-Pass No.", "MAWB No.", "Line No.", "HAWB No", "ULD No.")
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
        "Line No." += 1000;
    end;

    var
        Item: Record 27;
        LoadingSheetLine: Record 50061;
        GatePassHeader: Record 50068;
        GatePassULDAllocation: Record 50070;
        HAWBLine: Record 50074;
        HAWBHeader: Record 50075;
        LoadingSheetULDAlloc: Record 50063;
        MAWBs: Record 50077;
}

