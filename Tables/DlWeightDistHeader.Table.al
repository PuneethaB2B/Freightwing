table 50040 "Dl. Weight Dist. Header"
{

    fields
    {
        field(3; "Distribution Date"; Date)
        {

            trigger OnValidate()
            begin
                Dist.RESET;
                Dist.SETRANGE(Dist."Distribution Date", "Distribution Date");
                IF Dist.FINDFIRST THEN BEGIN
                    //ERROR('The Distribution for this date already Exists');
                END ELSE BEGIN
                    "Day of Week" := FORMAT("Distribution Date", 0, '<Weekday Text>');
                    Description := Text001 + ',' + "Day of Week" + ' ' + FORMAT("Distribution Date");

                END;
                "Week No" := DATE2DWY("Distribution Date", 2);
            end;
        }
        field(4; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                ImportExportSetup.GET;
                IF "No." = '' THEN
                    NoSeriesMgt.InitSeries(ImportExportSetup."Daily Analysis Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                VALIDATE("Distribution Date", TODAY);
                "Created By" := USERID;
                VALIDATE("Day of Week");
            end;
        }
        field(5; "No. Series"; Code[20])
        {
        }
        field(6; "Day of Week"; Text[30])
        {
            Editable = false;
        }
        field(7; Description; Text[100])
        {
        }
        field(8; "Created By"; Code[50])
        {
        }
        field(9; "Week No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Day of Week", "Distribution Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        DailyWeightDistByAirline.RESET;
        DailyWeightDistByAirline.SETRANGE("Daily No.", "No.");
        IF DailyWeightDistByAirline.FINDFIRST THEN
            DailyWeightDistByAirline.DELETEALL;
    end;

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No." = '' THEN
            NoSeriesMgt.InitSeries(ImportExportSetup."Daily Analysis Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        VALIDATE("Distribution Date", TODAY);
        "Created By" := USERID;
    end;

    trigger OnModify()
    begin
        DailyWeightDistByItem.RESET;
        DailyWeightDistByItem.SETRANGE(DailyWeightDistByItem."Daily No.", "No.");
        IF DailyWeightDistByItem.FINDSET THEN BEGIN
            REPEAT
                //DailyWeightDistByItem.VALIDATE("Item No.");
                DailyWeightDistByItem.MODIFY;
            UNTIL DailyWeightDistByItem.NEXT = 0;
        END;
    end;

    var
        ImportExportSetup: Record 50010;
        NoSeriesMgt: Codeunit 396;
        Country: Record "9";
        DailyWeightDistByItem: Record 50043;
        Text001: Label 'Daily weight distribution to';
        DailyWeightDistByAirline: Record 50041;
        Text002: Label 'You cannot delete Daily Distribution %1 because it has entries associated with it';
        DailyWeightDistHeader: Record 50040;
        Dist: Record 50040;


    procedure AssistEdit(OldDailyWeightDistHeader: Record 50040): Boolean
    begin
        DailyWeightDistHeader := Rec;
        ImportExportSetup.GET;
        ImportExportSetup.TESTFIELD("Daily Analysis Nos.");
        IF NoSeriesMgt.SelectSeries(ImportExportSetup."Daily Analysis Nos.", OldDailyWeightDistHeader."No. Series", DailyWeightDistHeader."No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Daily Analysis Nos.");
            NoSeriesMgt.SetSeries(DailyWeightDistHeader."No.");
            Rec := OldDailyWeightDistHeader;
            EXIT(TRUE);
        END;
    end;
}

