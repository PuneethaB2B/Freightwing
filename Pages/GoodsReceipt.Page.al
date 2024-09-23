page 50130 "Goods Receipt"
{
    PageType = Card;
    SourceTable = Table50052;
    SourceTableView = WHERE(Received = FILTER(No));

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
                field("Receipt Date"; "Receipt Date")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                    ShowMandatory = true;
                }
                field("Shipper Name"; "Shipper Name")
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
                field("Offloading Start Time"; "Offloading Start Time")
                {
                }
                field("Offloading End Time"; "Offloading End Time")
                {
                }
                field("Delivery No."; "Delivery No.")
                {
                }
                field("Delivery Date"; "Delivery Date")
                {
                }
                field("Seal No."; "Seal No.")
                {
                }
                field("Vehicle No."; "Vehicle No.")
                {
                    ShowMandatory = true;
                }
                field("Vehicle Arrival Time"; "Vehicle Arrival Time")
                {
                    ShowMandatory = true;
                }
                field("Screener Name"; "Screener Name")
                {
                    ShowMandatory = true;
                }
                field("Offloading Place"; "Offloading Place")
                {
                    Visible = false;
                }
                field("Driver Name"; "Driver Name")
                {
                    ShowMandatory = true;
                }
                field("Escort Vehicle No."; "Escort Vehicle No.")
                {
                    Visible = false;
                }
                field("Acceptance Checklist Serial Number"; "External Doc No.")
                {
                    Caption = 'Acceptance Checklist Serial Number';
                    ShowMandatory = true;
                }
                field("Prepared By"; "Prepared By")
                {
                    Editable = false;
                }
            }
            part(; 50131)
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
                        TESTFIELD(Status, Status::Submitted);
                        IF "Shipper Code" <> 'C000083' THEN BEGIN
                            IF "Shipper Code" = 'C000068' THEN BEGIN
                                //MESSAGE('');
                            END ELSE BEGIN

                                TESTFIELD("Shipper Code");
                                TESTFIELD("Vehicle No.");
                                TESTFIELD("Vehicle Arrival Time");
                            END;
                        END;
                        PostGoodReceipt;
                        BookingSheet.RESET;
                        BookingSheet.SETRANGE(BookingSheet."No.", "Booking Sheet No.");
                        IF BookingSheet.FINDFIRST THEN BEGIN
                            BookingSheet.Status := BookingSheet.Status::Received;
                            BookingSheet.MODIFY;
                            Status := Status::Submitted;
                            "Posted By" := USERID;
                            MODIFY;
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
                        TESTFIELD("Vehicle No.");
                        TESTFIELD("Vehicle Arrival Time");
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", "No.");
                        IF GoodReceiptHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50018, TRUE, FALSE, GoodReceiptHeader);
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
                        TESTFIELD("Vehicle No.");
                        TESTFIELD("Vehicle Arrival Time");
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE("No.", "No.");
                        IF GoodReceiptHeader.FINDFIRST THEN
                            REPORT.RUNMODAL(50003, TRUE, FALSE, GoodReceiptHeader);
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
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TESTFIELD(Status, Status::Open);

                        GoodsReceiptLine.RESET;
                        GoodsReceiptLine.SETRANGE("Good Receipt No.", "No.");
                        IF GoodsReceiptLine.FINDSET THEN
                            REPEAT
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Arrival Temperature");
                            UNTIL GoodsReceiptLine.NEXT = 0;

                        IF ("Shipper Code" <> 'C000083') THEN BEGIN
                            IF "Shipper Code" = 'C000068' THEN BEGIN
                                //MESSAGE('');
                            END ELSE BEGIN
                                TESTFIELD("Vehicle No.");
                                TESTFIELD("Driver Name");
                                TESTFIELD("Screener Name");
                                TESTFIELD("External Doc No.");
                                TESTFIELD("Vehicle Arrival Time");
                            END;
                        END ELSE BEGIN
                        END;

                        GoodsReceiptLine.RESET;
                        GoodsReceiptLine.SETRANGE(GoodsReceiptLine."Good Receipt No.", "No.");
                        IF GoodsReceiptLine.FINDSET THEN BEGIN
                            REPEAT
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Location Code");
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine."Actual Weight");
                                GoodsReceiptLine.TESTFIELD(GoodsReceiptLine.Quantity);
                            UNTIL GoodsReceiptLine.NEXT = 0;
                            Status := Status::Submitted;
                            MODIFY;
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
                        PAGE.RUNMODAL(50127);
                    end;
                }
            }
        }
    }

    var
        GoodReceiptHeader: Record "50052";
        BookingSheet: Record "50053";
        GoodsReceiptLine: Record "50051";
        BSline: Record "50054";
}

