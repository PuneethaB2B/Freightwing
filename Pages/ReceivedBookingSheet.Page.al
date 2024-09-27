page 50150 "Received Booking Sheet"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 50053;
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
                field("Booking Date"; Rec."Booking Date")
                {
                }
                field("Booking Day"; Rec."Booking Day")
                {
                    Editable = false;
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
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
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
            }
            part(Page; 50001)
            {
                SubPageLink = "Booking Sheet No." = FIELD("No."),
                              "Booking Date" = FIELD("Booking Date");
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
                        BookingSheetHeader.RESET;
                        BookingSheetHeader.SETRANGE("No.", Rec."No.");
                        IF BookingSheetHeader.FINDFIRST THEN BEGIN
                            REPORT.RUN(50019, TRUE, FALSE, BookingSheetHeader);
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
                        SalesPostPrint: Codeunit "Sales-Post + Print";
                    begin
                        //SalesPostPrint.PostAndEmail(Rec);
                        IF CONFIRM(' Do you want to email ') THEN BEGIN
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
                        Rec.TESTFIELD(Status, Rec.Status::Submitted);
                        IF CONFIRM('Do you want to Email Pre - Alerts?') THEN BEGIN
                            IF CustomMail.SendBookingSheetPreAlert(Rec."No.") THEN
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
                            Rec.Status := Rec.Status::Open;
                            Rec.MODIFY();

                        END;
                    end;
                }
            }
        }
    }

    var
        BookingSheetHeader: Record 50053;
        BookingSheetLine: Record 50054;
        MAWBAlloc: Record 50070;
        BSConsignee: Record 50056;
        GRNLine: Record 50052;
        CustomMail: Codeunit 50030;
}

