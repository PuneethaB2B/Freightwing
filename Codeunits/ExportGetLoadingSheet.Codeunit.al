codeunit 50005 "Export.-Get Loading Sheet"
{
    TableNo = 50069;

    trigger OnRun()
    begin
        GatePassHeader.GET(Rec."Gate-Pass No.");

        LoadingSheetLine.SETRANGE("Loading Sheet No.", GatePassHeader."Loading Sheet No.");
        //LoadingSheetLine.SETRANGE("MAWB No.",GatePassHeader."MAWB No.");
        LoadingSheetLine.SETFILTER("Gate-Pass No.", '%1', '');
        GetLoadingSheet.SETTABLEVIEW(LoadingSheetLine);
        GetLoadingSheet.LOOKUPMODE := TRUE;
        GetLoadingSheet.SetGatePassHeader(GatePassHeader);
        GetLoadingSheet.RUNMODAL;
    end;

    var
        Text000: Label 'The %1 on the %2 %3 and the %4 %5 must be the same.';
        GatePassHeader: Record "50068";
        GatePassLine: Record "50069";
        LoadingSheetHeader: Record "50060";
        LoadingSheetLine: Record "50061";
        GetLoadingSheet: Page "50092";


    procedure CreateGatePassLines(var LoadingSheetLine2: Record "50061")
    var
        TransferLine: Boolean;
    begin

        IF LoadingSheetLine2.FIND('-') THEN BEGIN
            GatePassLine.LOCKTABLE;
            GatePassLine.SETRANGE("Gate-Pass No.", GatePassHeader."No.");
            GatePassLine."Gate-Pass No." := GatePassHeader."No.";
            REPEAT
                TransferLine := TRUE;
                IF TransferLine THEN BEGIN
                    LoadingSheetLine := LoadingSheetLine2;
                    LoadingSheetLine.InsertGatePassFromLoadingSheet(GatePassLine);
                END;
            UNTIL LoadingSheetLine2.NEXT = 0;
        END;
    end;


    procedure SetGatePassHeader(var GatePassHeader2: Record "50068")
    begin
        GatePassHeader.GET(GatePassHeader2."No.");
    end;
}

