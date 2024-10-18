page 50130 "Goods Receipt"
{
    PageType = Card;
    SourceTable = "Good Receipt Header";
    SourceTableView = WHERE(Received = FILTER(false));
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
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                    ShowMandatory = true;
                }
                field("Shipper Name"; Rec."Shipper Name")
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
                field("Offloading Start Time"; Rec."Offloading Start Time")
                {
                }
                field("Offloading End Time"; Rec."Offloading End Time")
                {
                }
                field("Delivery No."; Rec."Delivery No.")
                {
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                }
                field("Seal No."; Rec."Seal No.")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ShowMandatory = true;
                }
                field("Vehicle Arrival Time"; Rec."Vehicle Arrival Time")
                {
                    ShowMandatory = true;
                }
                field("Screener Name"; Rec."Screener Name")
                {
                    ShowMandatory = true;
                }
                field("Offloading Place"; Rec."Offloading Place")
                {
                    Visible = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ShowMandatory = true;
                }
                field("Escort Vehicle No."; Rec."Escort Vehicle No.")
                {
                    Visible = false;
                }
                field("Acceptance Checklist Serial Number"; Rec."External Doc No.")
                {
                    Caption = 'Acceptance Checklist Serial Number';
                    ShowMandatory = true;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    Editable = false;
                }
            }
            part(Page; "Goods Receipt Subform")
            {
                SubPageLink = "Good Receipt No." = FIELD("No.");
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

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Submitted);
                        IF Rec."Shipper Code" <> 'C000083' THEN BEGIN
                            IF Rec."Shipper Code" = 'C000068' THEN BEGIN
                                //MESSAGE('');
                            END ELSE BEGIN

                                Rec.TESTFIELD("Shipper Code");
                                Rec.TESTFIELD("Vehicle No.");
                                Rec.TESTFIELD("Vehicle Arrival Time");
                            END;
                        END;
                        Rec.PostGoodReceipt;
                        BookingSheet.RESET;
                        BookingSheet.SETRANGE(BookingSheet."No.", Rec."Booking Sheet No.");
                        IF BookingSheet.FINDFIRST THEN BEGIN
                            BookingSheet.Status := BookingSheet.Status::Received;
                            BookingSheet.MODIFY;
                            Rec.Status := Rec.Status::Submitted;
                            Rec."Posted By" := USERID;
                            Rec.MODIFY;
                            MESSAGE('GRN Posted Successfully');
                            CurrPage.CLOSE;
                        END;
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
                        Rec.TESTFIELD("Vehicle No.");
                        Rec.TESTFIELD("Vehicle Arrival Time");
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", Rec."No.");
                        IF GoodReceiptHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(Report::"Goods Receipt Note", TRUE, FALSE, GoodReceiptHeader);
                    end;
                }
                action("&Print Acceptance Checklist")
                {
                    Caption = '&Print Acceptance Checklist';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Vehicle No.");
                        Rec.TESTFIELD("Vehicle Arrival Time");
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", Rec."No.");
                        IF GoodReceiptHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(Report::"Acceptance Checklist", TRUE, FALSE, GoodReceiptHeader);
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
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);

                        GoodsReceiptLine.RESET;
                        GoodsReceiptLine.SETRANGE("Good Receipt No.", Rec."No.");
                        IF GoodsReceiptLine.FINDSET THEN
                            REPEAT
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Arrival Temperature");
                            UNTIL GoodsReceiptLine.NEXT = 0;

                        IF (Rec."Shipper Code" <> 'C000083') THEN BEGIN
                            IF Rec."Shipper Code" = 'C000068' THEN BEGIN
                                //MESSAGE('');
                            END ELSE BEGIN
                                Rec.TESTFIELD("Vehicle No.");
                                Rec.TESTFIELD("Driver Name");
                                Rec.TESTFIELD("Screener Name");
                                Rec.TESTFIELD("External Doc No.");
                                Rec.TESTFIELD("Vehicle Arrival Time");
                            END;
                        END ELSE BEGIN
                        END;

                        GoodsReceiptLine.RESET;
                        GoodsReceiptLine.SETRANGE(GoodsReceiptLine."Good Receipt No.", Rec."No.");
                        IF GoodsReceiptLine.FINDSET THEN BEGIN
                            REPEAT
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Location Code");
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Actual Weight");
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine.Quantity);
                            UNTIL GoodsReceiptLine.NEXT = 0;
                            Rec.Status := Rec.Status::Submitted;
                            Rec.MODIFY;
                            BSline.RESET;
                            BSline.SETFILTER(BSline."Good Receipt No.", '<>%1', '');
                            IF BSline.FINDSET THEN BEGIN
                                REPEAT
                                    GoodReceiptHeader.CloseBookingSheet(BSline."Booking Sheet No.");
                                UNTIL BSline.NEXT = 0;
                            END;
                            MESSAGE('Submitted');
                            CurrPage.CLOSE;
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
                        PAGE.RUNMODAL(Page::"MAWB Test");
                    end;
                }
            }
        }
    }

    var
        GoodReceiptHeader: Record "Good Receipt Header";
        BookingSheet: Record "Booking Sheet Header";
        GoodsReceiptLine: Record "Good Receipt Line";
        BSline: Record "Booking Sheet Line";
}

