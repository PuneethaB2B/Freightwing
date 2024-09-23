page 50089 "Gate Pass"
{
    PageType = Card;
    SourceTable = Table50068;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Actual Departure Time"; "Actual Departure Time")
                {
                    Editable = false;
                }
                field("Gate-Pass Date"; "Gate-Pass Date")
                {
                    Editable = true;
                }
                field("Loading Sheet No."; "Loading Sheet No.")
                {
                    Visible = false;
                }
                field("Loading Sheet Date"; "Loading Sheet Date")
                {
                    Visible = false;
                }
                field("Shipper Code"; "Shipper Code")
                {
                    Visible = false;
                }
                field("Vehicle No."; "Vehicle No.")
                {
                    Caption = 'Tractor No';
                    ShowMandatory = true;
                }
                field("Driver Name"; "Driver Name")
                {
                    ShowMandatory = true;
                }
                field("Escort Vehicle No."; "Escort Vehicle No.")
                {
                    ShowMandatory = true;
                }
                field("Supervisor Name"; "Supervisor Name")
                {
                    Caption = 'Security Supervisor on Duty';
                    ShowMandatory = true;
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Prepared Date"; "Prepared Date")
                {
                    Editable = false;
                }
                field("Created Time"; "Created Time")
                {
                }
            }
            part(; 50090)
            {
                SubPageLink = Gate-Pass No.=FIELD(No.);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        TESTFIELD("Vehicle No.");
                        TESTFIELD("Driver Name");
                        TESTFIELD("Escort Vehicle No.");
                        GatePassHeader.RESET;
                        GatePassHeader.SETRANGE("No.", "No.");
                        IF GatePassHeader.FINDFIRST THEN
                            IF CONFIRM('Do you want to release the shippment?') THEN BEGIN
                                REPORT.RUNMODAL(50016, TRUE, FALSE, GatePassHeader);
                                ReleaseShipment("No.");
                            END ELSE BEGIN
                                REPORT.RUNMODAL(50016, TRUE, FALSE, GatePassHeader);
                            END;
                    end;
                }
                action("Print and Email")
                {
                    Caption = 'Print and Email';
                    Ellipsis = true;
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "82";
                    begin
                        //SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action(Release)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to release the shippment?') THEN BEGIN
                            ReleaseShipment("No.");
                            CloseMAWB("No.");
                            CurrPage.CLOSE;
                        END;
                    end;
                }
            }
        }
    }

    var
        GatePassHeader: Record "50068";
        GPLine: Record "50069";

    [Scope('Internal')]
    procedure ReleaseShipment(GPno: Code[50])
    var
        GPline: Record "50069";
        LoadingSheetULD: Record "50063";
        GPHeader: Record "50068";
    begin
        GPline.RESET;
        GPline.SETRANGE(GPline."Gate-Pass No.", GPno);
        IF GPline.FINDSET THEN BEGIN
            REPEAT
                //MESSAGE('%1 GP ULD %2',GPline."ULD No.");
                LoadingSheetULD.RESET;
                LoadingSheetULD.SETRANGE(LoadingSheetULD."ULD No.", GPline."ULD No.");
                LoadingSheetULD.SETRANGE(LoadingSheetULD."MWAB No.", GPline."MAWB No.");
                LoadingSheetULD.SETRANGE(LoadingSheetULD.Released, FALSE);
                IF LoadingSheetULD.FINDFIRST THEN BEGIN
                    //MESSAGE('');
                    LoadingSheetULD.Released := TRUE;
                    LoadingSheetULD.MODIFY;
                END;

            UNTIL GPline.NEXT = 0;
        END;
        //CloseMAWB("No.");
        Status := Status::Released;
        MODIFY;
    end;

    [Scope('Internal')]
    procedure CloseMAWB(GPNO: Code[50])
    var
        LoadingSheetULD: Record "50063";
        MAWBHeader: Record "50077";
    begin
        GPLine.RESET;
        GPLine.SETRANGE(GPLine."Gate-Pass No.", GPNO);
        IF GPLine.FINDSET THEN BEGIN
            REPEAT
                LoadingSheetULD.RESET;
                LoadingSheetULD.SETRANGE(LoadingSheetULD."MWAB No.", GPLine."MAWB No.");
                LoadingSheetULD.SETRANGE(LoadingSheetULD.Released, FALSE);
                IF LoadingSheetULD.FINDFIRST THEN BEGIN
                    MESSAGE('The MAWB has ULDs pending');

                END ELSE BEGIN
                    MAWBHeader.GET(GPLine."MAWB No.");
                    MAWBHeader."Gate Pass Prepared" := TRUE;
                    MAWBHeader.MODIFY;
                END;

            UNTIL GPLine.NEXT = 0;
        END;
    end;
}

