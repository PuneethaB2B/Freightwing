page 50101 "Posted Loading Sheet"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table50060;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Loading Date"; "Loading Date")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                    Importance = Promoted;
                }
                field(Description; Description)
                {
                }
                field("MAWB No."; "MAWB No.")
                {
                    Caption = 'GRN MAWB No.';
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Loading Sheet MAWB No"; "Loading Sheet MAWB No")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
            }
            part(; 50110)
            {
                SubPageLink = Loading Sheet No.=FIELD(No.);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action(Post)
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    Visible = false;

                    trigger OnAction()
                    begin
                        TESTFIELD(Status, Status::Submitted);
                        PostLoadingSheet;
                    end;
                }
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
                        LoadingSheetHeader.RESET;
                        LoadingSheetHeader.SETRANGE("No.", "No.");
                        IF LoadingSheetHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50021, TRUE, FALSE, LoadingSheetHeader);
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
                action(Submit)
                {
                    Caption = 'Submit';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to Submit Loading Sheet For Posting?') THEN BEGIN
                            LoadingSheetUlDAlloc.RESET;
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."Loading Sheet No.", "No.");
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."FWL Docket No.", '');
                            IF LoadingSheetUlDAlloc.FINDFIRST THEN BEGIN
                                ERROR('The ULD %1 %2 Does not have a Docket No.', LoadingSheetUlDAlloc."ULD Type Code", LoadingSheetUlDAlloc."ULD No.");
                            END ELSE BEGIN
                                Status := Status::Submitted;
                                MODIFY;
                            END;
                        END;
                    end;
                }
                action(Reset)
                {
                    Image = ReverseLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    ShortCutKey = 'Ctrl+R';

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to Re-Open Loadiing Sheet?') THEN BEGIN
                            Shipped := FALSE;
                            Status := Status::Submitted;
                            MODIFY;
                            MAWBLine.RESET;
                            MAWBLine.SETRANGE(MAWBLine."MAWB No.", "MAWB No.");
                            IF MAWBLine.FIND('-') THEN BEGIN
                                MAWBLine.DELETEALL;
                            END;
                            HAWBLine.RESET;
                            HAWBLine.SETRANGE(HAWBLine."MAWB No.", "MAWB No.");
                            IF HAWBLine.FIND('-') THEN BEGIN
                                HAWBLine.DELETEALL;
                            END;
                            /*MAWBInv.RESET;
                            MAWBInv.SETRANGE(MAWBInv."MAWB No.","MAWB No.");
                            IF MAWBInv.FIND('-') THEN BEGIN
                              MAWBInv.DELETEALL;
                            END;*/
                            PostLoadingSheetReversal;
                            MESSAGE('Loading Sheet Reset!');
                            CurrPage.CLOSE;
                        END;

                    end;
                }
                action(Validate)
                {
                    Image = Calendar;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to validate Loading sheets?') THEN BEGIN
                            REPORT.RUN(50066, FALSE, FALSE, Rec);
                        END;
                    end;
                }
            }
        }
    }

    var
        LoadingSheetHeader: Record "50060";
        LoadingSheetLine: Record "50061";
        LoadingSheetUlDAlloc: Record "50063";
        ImportExportSetup: Record "50010";
        MAWBInv: Record "50073";
        JournalTemplate: Text[100];
        JournalBatch: Text[100];
        ItemJnLine: Record "83";
        MAWBLine: Record "50076";
        HAWBLine: Record "50074";
}

