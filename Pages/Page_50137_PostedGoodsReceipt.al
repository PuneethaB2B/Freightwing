page 50137 "Posted Goods Receipt"
{
    Editable = false;
    PageType = Card;
    SourceTable = 50052;
    SourceTableView = WHERE(Received = FILTER(true));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field("Booking Sheet No."; Rec."Booking Sheet No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Booked Weight"; Rec."Booked Weight")
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                }
                field("Weight Difference"; Rec."Weight Difference")
                {
                }
                field(Loaded; Rec.Loaded)
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
            }
            part(Page1; 50138)
            {
                SubPageLink = "Good Receipt No." = FIELD("No.");
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
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", Rec."No.");
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
                        SalesPostPrint: Codeunit Microsoft.Sales.Posting."Sales-Post + Print";
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
                        GoodReceiptLine.SETRANGE(GoodReceiptLine."Good Receipt No.", Rec."No.");
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
                        Rec.PostGoodReceiptReversal;
                        Rec.Status := Rec.Status::Open;
                        Rec.Received := FALSE;
                        Rec.Loaded := FALSE;
                        Rec.MODIFY;
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        GoodReceiptHeader: Record 50052;
        LoadingSheetHeader: Record 50060;
        GoodReceiptLine: Record 50051;
}

