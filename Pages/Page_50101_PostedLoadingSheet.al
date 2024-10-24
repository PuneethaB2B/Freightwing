page 50101 "Posted Loading Sheet"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Loading Sheet Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Loading Date"; Rec."Loading Date")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                    Caption = 'GRN MAWB No.';
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Loading Sheet MAWB No"; Rec."Loading Sheet MAWB No")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
            }
            part(Page; "Posted Loading Sheet Subform")
            {
                SubPageLink = "Loading Sheet No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup)
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
                        Rec.TESTFIELD(Status, Rec.Status::Submitted);
                        Rec.PostLoadingSheet;
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
                        LoadingSheetHeader.SETRANGE("No.", Rec."No.");
                        IF LoadingSheetHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(Report::"Loading Sheet", TRUE, FALSE, LoadingSheetHeader);
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
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."Loading Sheet No.", Rec."No.");
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."FWL Docket No.", '');
                            IF LoadingSheetUlDAlloc.FINDFIRST THEN BEGIN
                                ERROR('The ULD %1 %2 Does not have a Docket No.', LoadingSheetUlDAlloc."ULD Type Code", LoadingSheetUlDAlloc."ULD No.");
                            END ELSE BEGIN
                                Rec.Status := Rec.Status::Submitted;
                                Rec.MODIFY;
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
                            Rec.Shipped := FALSE;
                            Rec.Status := Rec.Status::Submitted;
                            Rec.MODIFY;
                            MAWBLine.RESET;
                            MAWBLine.SETRANGE(MAWBLine."MAWB No.", Rec."MAWB No.");
                            IF MAWBLine.FIND('-') THEN BEGIN
                                MAWBLine.DELETEALL;
                            END;
                            HAWBLine.RESET;
                            HAWBLine.SETRANGE(HAWBLine."MAWB No.", Rec."MAWB No.");
                            IF HAWBLine.FIND('-') THEN BEGIN
                                HAWBLine.DELETEALL;
                            END;
                            /*MAWBInv.RESET;
                            MAWBInv.SETRANGE(MAWBInv."MAWB No.","MAWB No.");
                            IF MAWBInv.FIND('-') THEN BEGIN
                              MAWBInv.DELETEALL;
                            END;*/
                            Rec.PostLoadingSheetReversal;
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
                            REPORT.RUN(Report::"Update Loading Sheet Lines", FALSE, FALSE, Rec);
                        END;
                    end;
                }
            }
        }
    }

    var
        LoadingSheetHeader: Record "Loading Sheet Header";
        LoadingSheetLine: Record "Loading Sheet Line";
        LoadingSheetUlDAlloc: Record "Loading Sheet ULD Allocation";
        ImportExportSetup: Record "Import/Export Setup";
        MAWBInv: Record "MAWB Invoice Charge";
        JournalTemplate: Text[100];
        JournalBatch: Text[100];
        ItemJnLine: Record "Item Journal Line";
        MAWBLine: Record "MAWB Line";
        HAWBLine: Record "HAWB Line";
}

