page 50150 "Received Booking Sheet"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table50053;

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
                field("Booking Date"; "Booking Date")
                {
                }
                field("Booking Day"; "Booking Day")
                {
                    Editable = false;
                }
                field("Shipper Code"; "Shipper Code")
                {
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
                field("Prepared By"; "Prepared By")
                {
                }
                field(Comments; Comments)
                {
                }
            }
            part(; 50001)
            {
                SubPageLink = Booking Sheet No.=FIELD(No.),
                              Booking Date=FIELD(Booking Date);
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
                        BookingSheetHeader.RESET;
                        BookingSheetHeader.SETRANGE("No.","No.");
                        IF BookingSheetHeader.FINDFIRST THEN
                        BEGIN
                          REPORT.RUN(50019,TRUE,FALSE, BookingSheetHeader);
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
                        IF CONFIRM(' Do you want to email ') THEN
                        BEGIN
                          MESSAGE('Emailed;');
                        END;
                    end;
                }
                action(Test)
                {
                    Promoted = true;
                    Visible = false;
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
            group(Email)
            {
                action("Send Post Alert")
                {
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TESTFIELD(Status,Status::Submitted);
                        IF CONFIRM('Do you want to Email Pre - Alerts?') THEN
                        BEGIN
                          IF CustomMail.SendBookingSheetPreAlert("No.") THEN
                          MESSAGE('Pre Alert Sent');
                          CurrPage.CLOSE;
                        END;
                    end;
                }
                action(Reopen)
                {

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to reopen Booking Sheet ') THEN BEGIN
                          Status:=Status::Open;
                          MODIFY();

                        END;
                    end;
                }
            }
        }
    }

    var
        BookingSheetHeader: Record "50053";
        BookingSheetLine: Record "50054";
        MAWBAlloc: Record "50070";
        BSConsignee: Record "50056";
        GRNLine: Record "50052";
        CustomMail: Codeunit "50030";
}

