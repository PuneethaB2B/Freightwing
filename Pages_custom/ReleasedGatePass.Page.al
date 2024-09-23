page 50066 "Released Gate Pass"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                }
                field("Loading Sheet No."; "Loading Sheet No.")
                {
                    Visible = false;
                }
                field("Loading Sheet Date"; "Loading Sheet Date")
                {
                    Visible = false;
                }
                field("Created Time"; "Created Time")
                {
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
                field("Released By"; "Released By")
                {
                }
            }
            part(; 50067)
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
                        IF GatePassHeader.FINDFIRST THEN BEGIN
                            REPORT.RUNMODAL(50016, TRUE, FALSE, GatePassHeader);
                            ReleaseShipment("No.");
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
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to release the shippment?') THEN BEGIN
                            ReleaseShipment("No.");
                            CurrPage.CLOSE;
                        END;
                    end;
                }
            }
        }
    }

    var
        GatePassHeader: Record "50068";

    local procedure ReleaseShipment(GPno: Code[50])
    var
        GPline: Record "50069";
        LoadingSheetULD: Record "50063";
        GPHeader: Record "50068";
    begin
        GPline.RESET;
        GPline.SETRANGE(GPline."Gate-Pass No.", GPno);
        IF GPline.FINDSET THEN BEGIN
            REPEAT
                LoadingSheetULD.RESET;
                //LoadingSheetULD.SETRANGE(LoadingSheetULD."Loading Sheet No.",GPline."Loading Sheet No.");
                LoadingSheetULD.SETRANGE(LoadingSheetULD."MWAB No.", GPline."MAWB No.");
                LoadingSheetULD.SETRANGE(LoadingSheetULD."ULD No.", GPline."ULD No.");
                IF LoadingSheetULD.FINDFIRST THEN BEGIN
                    LoadingSheetULD.Released := TRUE;

                    LoadingSheetULD.MODIFY;
                    //MESSAGE('Closed');
                END ELSE BEGIN
                    MESSAGE('Not Found');
                END;
            UNTIL GPline.NEXT = 0;
            GPHeader.GET(GPno);
            GPHeader.Status := GPHeader.Status::Released;
            GPHeader."Released By" := USERID;
            GPHeader."Actual Departure Time" := TIME;
            GPHeader.MODIFY;
        END;
    end;
}

