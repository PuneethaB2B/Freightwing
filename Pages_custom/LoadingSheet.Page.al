page 50080 "Loading Sheet"
{
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table50060;
    SourceTableView = WHERE (Shipped = FILTER (No));

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
                    Editable = true;
                }
                field("Flight Code"; "Flight Code")
                {
                    Editable = true;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = true;
                }
                field("Loading Sheet MAWB No"; "Loading Sheet MAWB No")
                {
                    Editable = false;
                }
                field("Prepared By"; "Prepared By")
                {
                }
            }
            part(; 50081)
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

                    trigger OnAction()
                    begin
                        LoadingSheetLine.RESET;
                        LoadingSheetLine.SETRANGE("Loading Sheet No.", "No.");
                        IF LoadingSheetLine.FINDSET THEN
                            REPEAT
                                LoadingSheetLine.CALCFIELDS("FWL Docket Weight");
                                LoadingSheetLine.TESTFIELD("Departure Temperature");
                                LoadingSheetLine.TESTFIELD("FWL Docket Weight");
                            UNTIL LoadingSheetLine.NEXT = 0;

                        TESTFIELD(Status, Status::Submitted);
                        LoadingSheetLine.RESET;
                        LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", "No.");
                        IF LoadingSheetLine.FINDSET THEN BEGIN
                            REPEAT
                                LoadingSheetUlDAlloc.RESET;
                                LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."Loading Sheet No.", LoadingSheetLine."Loading Sheet No.");
                                LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."MWAB No.", LoadingSheetLine."MAWB No.");
                                IF LoadingSheetUlDAlloc.FIND('-') THEN BEGIN

                                END
                                ELSE BEGIN
                                    ERROR('MAWB No %1 is Lacking ULDs', LoadingSheetLine."MAWB No.");
                                END;
                            UNTIL LoadingSheetLine.NEXT = 0;
                        END;
                        PostLoadingSheet;
                        "Posted Time" := TIME;
                        MODIFY;
                        CurrPage.CLOSE;
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

                    trigger OnAction()
                    begin
                        TESTFIELD(Status, Status::Open);
                        LoadingSheetLine.RESET;
                        LoadingSheetLine.SETRANGE("Loading Sheet No.", "No.");
                        IF LoadingSheetLine.FINDSET THEN
                            REPEAT
                                LoadingSheetLine.CALCFIELDS("FWL Docket Weight");
                                LoadingSheetLine.TESTFIELD("Departure Temperature");
                                LoadingSheetLine.TESTFIELD("FWL Docket Weight");
                                LoadingSheetLine.TESTFIELD(Length);
                                LoadingSheetLine.TESTFIELD(Width);
                                LoadingSheetLine.TESTFIELD(Height);
                            UNTIL LoadingSheetLine.NEXT = 0;

                        IF CONFIRM('Do you want to Submit Loading Sheet For Posting?') THEN BEGIN
                            LoadingSheetUlDAlloc.RESET;
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."Loading Sheet No.", "No.");
                            LoadingSheetUlDAlloc.SETRANGE(LoadingSheetUlDAlloc."FWL Docket No.", '');
                            IF LoadingSheetUlDAlloc.FINDFIRST THEN BEGIN
                                ERROR('The ULD %1 %2 Does not have a Docket No.', LoadingSheetUlDAlloc."ULD Type Code", LoadingSheetUlDAlloc."ULD No.");
                            END ELSE BEGIN
                                LoadingSheetLine.RESET;
                                LoadingSheetLine.SETRANGE(LoadingSheetLine."Loading Sheet No.", "No.");
                                IF LoadingSheetLine.FINDSET THEN BEGIN
                                    REPEAT
                                        SubmitLS(LoadingSheetLine);
                                    UNTIL LoadingSheetLine.NEXT = 0;
                                    GRNHeader.GET(LoadingSheetLine."GRN No.");
                                    GRNHeader.Loaded := TRUE;
                                    GRNHeader.MODIFY;
                                END;
                                Status := Status::Submitted;
                                MODIFY;
                                MESSAGE('Loading Sheet Submitted');
                                CurrPage.CLOSE;
                            END;
                        END;
                    end;
                }
                action("MAWB Status")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PAGE.RUNMODAL(50127);
                    end;
                }
            }
        }
    }

    var
        LoadingSheetHeader: Record "50060";
        LoadingSheetLine: Record "50061";
        LoadingSheetUlDAlloc: Record "50063";
        GRn: Record "50051";
        GRNHeader: Record "50052";

    local procedure SubmitLS(LoadingSheetLine1: Record "50061")
    var
        GRNLine: Record "50051";
        LoadingSheetLine2: Record "50061";
        Shippedqty: Decimal;
    begin
        GRNLine.RESET;
        GRNLine.SETRANGE(GRNLine."MAWB No.", LoadingSheetLine."MAWB No.");
        GRNLine.SETRANGE(GRNLine."Item No.", LoadingSheetLine."Item No.");
        GRNLine.SETRANGE(GRNLine."Shipper Code", LoadingSheetLine."Shipper Code");
        GRNLine.SETRANGE(GRNLine."Flight Code", LoadingSheetLine."Flight Code");
        IF GRNLine.FINDFIRST THEN BEGIN
            LoadingSheetLine2.RESET;
            LoadingSheetLine2.SETRANGE(LoadingSheetLine2."MAWB No.", LoadingSheetLine1."MAWB No.");
            IF LoadingSheetLine2.FINDSET THEN BEGIN
                REPEAT
                    LoadingSheetLine2.CALCFIELDS(LoadingSheetLine2.Quantity);
                    Shippedqty += LoadingSheetLine2.Quantity;
                UNTIL LoadingSheetLine2.NEXT = 0;
            END;
            IF Shippedqty = GRNLine.Quantity THEN BEGIN
                GRNLine."Loading Sheet No." := LoadingSheetLine."Loading Sheet No.";
                GRNLine.MODIFY;
            END ELSE BEGIN
                MESSAGE('MAWB Still Open. Not shipped in Full');
            END;
        END;
    end;
}

