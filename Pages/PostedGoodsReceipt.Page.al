page 50137 "Posted Goods Receipt"
{
    Editable = false;
    PageType = Card;
    SourceTable = Table50052;
    SourceTableView = WHERE(Received = FILTER(Yes));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Receipt Date"; "Receipt Date")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field("Booking Sheet No."; "Booking Sheet No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Booked Weight"; "Booked Weight")
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
                }
                field("Weight Difference"; "Weight Difference")
                {
                }
                field(Loaded; Loaded)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Posted By"; "Posted By")
                {
                }
            }
            part(; 50138)
            {
                SubPageLink = Good Receipt No.=FIELD(No.);
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
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", "No.");
                        IF GoodReceiptHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50018, TRUE, FALSE, GoodReceiptHeader);
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
                action(Reopen)
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        GoodReceiptLine.RESET;
                        GoodReceiptLine.SETRANGE(GoodReceiptLine."Good Receipt No.", "No.");
                        IF GoodReceiptLine.FINDSET THEN BEGIN
                            REPEAT
                                LoadingSheetHeader.RESET;
                                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."MAWB No.", GoodReceiptLine."MAWB No.");
                                LoadingSheetHeader.SETRANGE(LoadingSheetHeader."Shipper Code", GoodReceiptLine."Shipper Code");
                                IF LoadingSheetHeader.FINDFIRST THEN BEGIN
                                    IF LoadingSheetHeader.Shipped THEN BEGIN
                                        ERROR('The Goods Receipt has a MAWB %1 Which has been Shipped. Please Reset Loading Sheet %2 to Proceed', GoodReceiptLine."MAWB No.", LoadingSheetHeader."No.");
                                    END;
                                    ERROR('The Goods Receipt has a MAWB %1 Which has been Loaded. Please Reset Loading Sheet %2 to Proceed', GoodReceiptLine."MAWB No.", LoadingSheetHeader."No.");
                                END;
                            UNTIL GoodReceiptLine.NEXT = 0;
                        END;
                        PostGoodReceiptReversal;
                        Status := Status::Open;
                        Received := FALSE;
                        Loaded := FALSE;
                        MODIFY;
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        GoodReceiptHeader: Record "50052";
        LoadingSheetHeader: Record "50060";
        GoodReceiptLine: Record "50051";
}

