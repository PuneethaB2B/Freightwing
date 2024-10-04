page 50089 "Gate Pass"
{
    PageType = Card;
    SourceTable = "Gate Pass Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Actual Departure Time"; Rec."Actual Departure Time")
                {
                    Editable = false;
                }
                field("Gate-Pass Date"; Rec."Gate-Pass Date")
                {
                    Editable = true;
                }
                field("Loading Sheet No."; Rec."Loading Sheet No.")
                {
                    Visible = false;
                }
                field("Loading Sheet Date"; Rec."Loading Sheet Date")
                {
                    Visible = false;
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                    Visible = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    Caption = 'Tractor No';
                    ShowMandatory = true;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ShowMandatory = true;
                }
                field("Escort Vehicle No."; Rec."Escort Vehicle No.")
                {
                    ShowMandatory = true;
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                    Caption = 'Security Supervisor on Duty';
                    ShowMandatory = true;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Prepared Date"; Rec."Prepared Date")
                {
                    Editable = false;
                }
                field("Created Time"; Rec."Created Time")
                {
                }
            }
            part(Page; "Gate Pass Subform")
            {
                SubPageLink = "Gate-Pass No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(fw)
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
                        Rec.TESTFIELD("Vehicle No.");
                        Rec.TESTFIELD("Driver Name");
                        Rec.TESTFIELD("Escort Vehicle No.");
                        GatePassHeader.RESET;
                        GatePassHeader.SETRANGE("No.", Rec."No.");
                        IF GatePassHeader.FINDFIRST THEN
                            IF CONFIRM('Do you want to release the shippment?') THEN BEGIN
                                REPORT.RUNMODAL(Report::"Gate Pass", TRUE, FALSE, GatePassHeader);
                                ReleaseShipment(Rec."No.");
                            END ELSE BEGIN
                                REPORT.RUNMODAL(Report::"Gate Pass", TRUE, FALSE, GatePassHeader);
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
                        SalesPostPrint: Codeunit Microsoft.Sales.Posting."Sales-Post + Print";
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
                            ReleaseShipment(Rec."No.");
                            CloseMAWB(Rec."No.");
                            CurrPage.CLOSE;
                        END;
                    end;
                }
            }
        }
    }

    var
        GatePassHeader: Record "Gate Pass Header";
        GPLine: Record "Gate Pass Line";


    procedure ReleaseShipment(GPno: Code[50])
    var
        GPline: Record "Gate Pass Line";
        LoadingSheetULD: Record "Loading Sheet ULD Allocation";
        GPHeader: Record "Gate Pass Header";
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
        Rec.Status := Rec.Status::Released;
        Rec.MODIFY;
    end;


    procedure CloseMAWB(GPNO: Code[50])
    var
        LoadingSheetULD: Record "Loading Sheet ULD Allocation";
        MAWBHeader: Record "MAWB Header 2";
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

