table 50071 "Offloaded Gatepass Header"
{

    fields
    {
        field(1; "ULD Type"; Code[50])
        {
            Editable = false;
        }
        field(2; "ULD No"; Code[50])
        {
            NotBlank = true;
            TableRelation = "Gate Pass Line"."ULD No." WHERE("Gate-Pass No." = FIELD("Gate Pass No"),
                                                              Offloaded = FILTER(false));

            trigger OnValidate()
            begin
                //Offload.SETRANGE("ULD No","ULD No");
                GatePassLine.RESET;
                GatePassLine.SETRANGE(GatePassLine."Gate-Pass No.", "Gate Pass No");
                IF GatePassLine.FINDFIRST THEN BEGIN
                    LoadingSheetULD.RESET;
                    LoadingSheetULD.SETRANGE(LoadingSheetULD."ULD No.", "ULD No");
                    LoadingSheetULD.SETRANGE(LoadingSheetULD.Released, TRUE);
                    IF LoadingSheetULD.FINDFIRST THEN BEGIN
                        "MAWB No" := LoadingSheetULD."MWAB No.";
                        "Loading Sheet No" := LoadingSheetULD."Loading Sheet No.";
                        "ULD Type" := LoadingSheetULD."ULD Type Code";
                        "No Of Boxes" := LoadingSheetULD.Quantity;
                        "FWL Docket Weight" := LoadingSheetULD."FWL Docket Weight";
                        VALIDATE("Division Code", LoadingSheetULD.FAM);
                        VALIDATE("Item Code", LoadingSheetULD."Item No.");
                        IF LoadingSheet.GET(LoadingSheetULD."Loading Sheet No.") THEN BEGIN
                            VALIDATE("Shipper Code", LoadingSheet."Shipper Code");
                            VALIDATE("Consignee Code", LoadingSheet."Consignee Code");
                            VALIDATE(Airline, LoadingSheet."Airline Code");
                        END;
                        "Created By" := USERID;
                        "Created On" := TODAY;
                    END;
                END;
            end;
        }
        field(3; "Gate Pass No"; Code[50])
        {
            TableRelation = "Gate Pass Header"."No." WHERE(Status = FILTER(Released));

            trigger OnValidate()
            begin
                ImportExportSetup.GET;
                IF No = '' THEN BEGIN
                    NoSeriesMgt.InitSeries(ImportExportSetup."Offload Nos.", xRec."No. Series", 0D, No, "No. Series");
                END;
                "Created On" := TODAY;
                "Created By" := USERID;
                Status := Status::Open;
                Description := 'Offload of Gate Pass Number-' + "Gate Pass No";
                GatePassLine.RESET;
                GatePassLine.SETRANGE(GatePassLine."Gate-Pass No.", "Gate Pass No");
                IF GatePassLine.FINDSET THEN BEGIN
                    REPEAT
                        LoadingSheetULD.RESET;
                        LoadingSheetULD.SETRANGE(LoadingSheetULD."MWAB No.", GatePassLine."MAWB No.");
                        LoadingSheetULD.SETRANGE(LoadingSheetULD."ULD No.", GatePassLine."ULD No.");
                        LoadingSheetULD.FINDFIRST;
                        OffloadedLines.INIT;
                        OffloadedLines.No := No;
                        OffloadedLines."Gate-Pass No." := GatePassLine."Gate-Pass No.";
                        OffloadedLines."MAWB No." := GatePassLine."MAWB No.";
                        OffloadedLines."Line No." := OffloadedLines."Line No." + 1000;
                        OffloadedLines."HAWB No" := GatePassLine."HAWB No";
                        OffloadedLines."ULD No." := GatePassLine."ULD No.";
                        OffloadedLines."Item No." := LoadingSheetULD."Item No.";
                        //MESSAGE(LoadingSheetULD."Item No.");
                        OffloadedLines."Unit of Measure Code" := GatePassLine."Unit of Measure Code";
                        OffloadedLines.Quantity := GatePassLine.Quantity;
                        OffloadedLines."Vehicle No." := GatePassLine."Vehicle No.";
                        OffloadedLines."Driver Name" := GatePassLine."Driver Name";
                        OffloadedLines."ULD Type" := GatePassLine."ULD Type";
                        OffloadedLines."Certificate Of Origin" := GatePassLine."Certificate Of Origin";
                        OffloadedLines."Custom Entry No" := GatePassLine."Custom Entry No";
                        OffloadedLines."Phyto Certificate" := GatePassLine."Phyto Certificate";
                        OffloadedLines."HAWB No" := GatePassLine."HAWB No";
                        OffloadedLines.VALIDATE(OffloadedLines."ULD No.");
                        OffloadedLines.INSERT;
                    UNTIL GatePassLine.NEXT = 0;
                END;
            end;
        }
        field(4; "MAWB No"; Code[50])
        {
        }
        field(5; "Loading Sheet No"; Code[50])
        {
        }
        field(6; No; Code[30])
        {

            trigger OnValidate()
            begin
                ImportExportSetup.GET;
                IF No = '' THEN BEGIN
                    NoSeriesMgt.InitSeries(ImportExportSetup."Offload Nos.", xRec."No. Series", 0D, No, "No. Series");
                END;
            end;
        }
        field(7; "Created By"; Code[50])
        {
        }
        field(8; "Created On"; Date)
        {
        }
        field(9; "No Of Boxes"; Decimal)
        {
        }
        field(10; "Consignee Code"; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF Consignees.GET("Consignee Code") THEN
                    "Consignee Name" := Consignees.Name;
            end;
        }
        field(11; "Shipper Code"; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Shippers.GET("Shipper Code");
                "Shipper Name" := Shippers.Name;
            end;
        }
        field(12; "Shipper Name"; Text[30])
        {
            Editable = false;
        }
        field(13; "Consignee Name"; Text[30])
        {
            Editable = false;
        }
        field(14; Airline; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                Airlines.GET(Airline);
                "Airline Shade" := Airlines.Shade;
            end;
        }
        field(15; "Airline Shade"; Text[30])
        {
            Editable = false;
        }
        field(16; "FWL Docket Weight"; Decimal)
        {
        }
        field(17; Processed; Boolean)
        {
            Editable = false;
        }
        field(18; "Item Code"; Code[50])
        {

            trigger OnValidate()
            begin
                Items.GET("Item Code");
                "Item Name" := Items.Description;
            end;
        }
        field(19; "Item Name"; Text[50])
        {
        }
        field(20; "Division Code"; Code[50])
        {

            trigger OnValidate()
            begin
                IF Fams.GET("Division Code") THEN
                    "Division Name" := Fams.Description;
            end;
        }
        field(21; "Division Name"; Text[50])
        {
        }
        field(22; "Prepared On"; Date)
        {
        }
        field(23; "Prepared By"; Code[50])
        {
        }
        field(24; "No. Series"; Code[50])
        {
        }
        field(25; "Total Loaded Boxes"; Decimal)
        {
            CalcFormula = Sum("Offloaded Gatepass Line".Quantity WHERE("Gate-Pass No." = FIELD("Gate Pass No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; "Total Loaded Docket Weight"; Decimal)
        {
            CalcFormula = Sum("Offloaded Gatepass Line"."Loaded Weight" WHERE("Gate-Pass No." = FIELD("Gate Pass No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; "Total Offloaded Boxes"; Decimal)
        {
            CalcFormula = Sum("Offloaded Gatepass Line"."Offloaded Boxes" WHERE("Gate-Pass No." = FIELD("Gate Pass No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Total Offloaded Weight"; Decimal)
        {
            CalcFormula = Sum("Offloaded Gatepass Line"."Offloaded Weight" WHERE("Gate-Pass No." = FIELD("Gate Pass No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; Status; Option)
        {
            OptionCaption = ',Open,Submitted,Posted';
            OptionMembers = ,Open,Submitted,Posted;
        }
        field(30; Description; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TESTFIELD(Processed, FALSE);
    end;

    trigger OnModify()
    begin
        TESTFIELD(Processed, FALSE);
    end;

    trigger OnRename()
    begin
        TESTFIELD(Processed, FALSE);
    end;

    var
        LoadingSheetULD: Record "Loading Sheet ULD Allocation";
        GatePassLine: Record "Gate Pass Line";
        Shippers: Record Customer;
        LoadingSheet: Record "Loading Sheet Header";
        Consignees: Record Consignee;
        Airlines: Record Airline;
        NextNo: Integer;
        Items: Record Item;
        Fams: Record "Division/Farm";
        Offload: Record "Offloaded Gatepass Header";
        OffloadedLines: Record "Offloaded Gatepass Line";
        ImportExportSetup: Record "Import/Export Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JournalTemplate: Code[50];
        JournalBatch: Code[50];
        ItemJnLine: Record "Item Journal Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        MAWBLine: Record "MAWB Line";
        OffloadedLines2: Record "Offloaded Gatepass Line";
        Chargeable: Decimal;


    procedure Process()
    begin
        ImportExportSetup.GET();
        JournalTemplate := ImportExportSetup."Item Journal Template";
        JournalBatch := ImportExportSetup."Item Journal Batch";
        ItemJnLine.RESET;
        ItemJnLine.SETRANGE(ItemJnLine."Journal Template Name", JournalTemplate);
        ItemJnLine.SETRANGE(ItemJnLine."Journal Batch Name", JournalBatch);
        ItemJnLine.DELETEALL;
        OffloadedLines.RESET;
        OffloadedLines.SETFILTER(OffloadedLines."Offloaded Boxes", '<>%1', 0);
        OffloadedLines.SETRANGE(OffloadedLines."Gate-Pass No.", "Gate Pass No");
        OffloadedLines.SETRANGE(OffloadedLines."Ship With Same AWB", FALSE);
        OffloadedLines.SETRANGE(OffloadedLines.No, No);
        IF OffloadedLines.FIND('-') THEN BEGIN
            REPEAT
                //MESSAGE('P');
                ItemJnLine."Journal Template Name" := ImportExportSetup."Item Journal Template";
                ItemJnLine."Journal Batch Name" := ImportExportSetup."Item Journal Batch";
                ItemJnLine."Line No." := ItemJnLine."Line No." + 1000;
                ItemJnLine."Entry Type" := ItemJnLine."Entry Type"::"Positive Adjmt.";
                ItemJnLine."Source Code" := 'ITEMJNL';
                ItemJnLine."Document No." := No;
                ItemJnLine."Item No." := OffloadedLines."Item No.";
                ItemJnLine.VALIDATE("Item No.");
                ItemJnLine."Posting Date" := TODAY;
                ItemJnLine.Description := Description;
                ItemJnLine."Unit of Measure Code" := OffloadedLines."Unit of Measure Code";
                ItemJnLine.Quantity := OffloadedLines."Offloaded Boxes";
                ItemJnLine.VALIDATE(Quantity);
                ItemJnLine.VALIDATE("Unit Amount");
                ItemJnLine."Shipper Code" := OffloadedLines."Shipper Code";
                ItemJnLine.Weight := OffloadedLines."Offloaded Weight";
                ItemJnLine."Location Code" := 'FWL';
                ItemJnLine.INSERT;
            UNTIL OffloadedLines.NEXT = 0;
        END;

        ItemJnLine.RESET;
        ItemJnLine.SETRANGE(ItemJnLine."Journal Template Name", JournalTemplate);
        ItemJnLine.SETRANGE(ItemJnLine."Journal Batch Name", JournalBatch);
        IF ItemJnLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", ItemJnLine);

            ItemLedgerEntry.RESET;
            ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", No);
            IF ItemLedgerEntry.FINDFIRST THEN
                //Offloaded:=TRUE;
                Status := Status::Posted;
            MODIFY;
        END
    end;
}

