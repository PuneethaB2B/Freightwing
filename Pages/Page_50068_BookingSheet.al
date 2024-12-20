page 50068 "Booking Sheet"
{
    PageType = Card;
    SourceTable = "Booking Sheet Header";
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
            part(BookingSheetSubform; "Booking Sheet Subform")
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
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = PostPrint;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    BookingSheetHeader.RESET;
                    BookingSheetHeader.SETRANGE("No.", Rec."No.");
                    IF BookingSheetHeader.FINDFIRST THEN BEGIN
                        REPORT.RUN(Report::"Booking Sheet", TRUE, FALSE, BookingSheetHeader);
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
                    SalesPostPrint: Codeunit Microsoft.Sales.Posting."Sales-Post + Print";
                begin
                    //SalesPostPrint.PostAndEmail(Rec);
                    IF CONFIRM(' Do you want to email ') THEN BEGIN
                        MESSAGE('Emailed;');
                    END;
                end;
            }
            action(Submit)
            {
                Image = SendTo;
                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Submit?') THEN BEGIN
                        BookingSheetLine.RESET;
                        BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.", Rec."No.");
                        IF BookingSheetLine.FINDSET THEN BEGIN
                            REPEAT
                                BookingSheetLine.TESTFIELD(BookingSheetLine."Type of Delivery");
                                MAWBAlloc.RESET;
                                MAWBAlloc.SETRANGE(MAWBAlloc."Booking Sheet No", BookingSheetLine."Booking Sheet No.");
                                MAWBAlloc.SETRANGE(MAWBAlloc."Flight No", BookingSheetLine."Flight Code");
                                MAWBAlloc.SETRANGE(MAWBAlloc."Source Airport", BookingSheetLine."Source Airport");
                                MAWBAlloc.SETRANGE(MAWBAlloc."Destination Airport", BookingSheetLine."Destination Airport");
                                IF MAWBAlloc.FIND('-') THEN BEGIN
                                    MAWBAlloc.TESTFIELD(MAWBAlloc."MAWB No");
                                    BSConsignee.RESET;
                                    BSConsignee.SETRANGE(BSConsignee."MAWB No.", MAWBAlloc."MAWB No");
                                    IF BSConsignee.FINDFIRST THEN BEGIN
                                        //===============Send Pre Alert=============>
                                        /*IF CONFIRM('Do you want to Email Pre - Alerts?') THEN
                                        BEGIN
                                          IF CustomMail.SendBookingSheetPreAlert("No.") THEN
                                          MESSAGE('Pre Alert Sent');
                                          CurrPage.CLOSE;
                                        END; */
                                        //<========================
                                        Rec.Status := Rec.Status::Submitted;
                                        Rec."Submitted on" := TODAY;
                                        Rec."Submitted at" := TIME;
                                        Rec.MODIFY;
                                        CurrPage.CLOSE;
                                    END ELSE BEGIN
                                        ERROR('THE MAWB No. %1 For %2 From %3 To %4 Has no Consignee', MAWBAlloc."MAWB No", MAWBAlloc."Airline Code", MAWBAlloc."Source Airport", MAWBAlloc."Destination Airport");
                                    END;
                                END ELSE BEGIN
                                    ERROR('Booking Sheet Lines are missing MAWB Nos %1,%2,%3', BookingSheetLine."Flight Code", BookingSheetLine."Source Airport", BookingSheetLine."Destination Airport");
                                END;
                            UNTIL BookingSheetLine.NEXT = 0;
                        END;
                    END;

                end;
            }
            action(Test)
            {
                // Promoted = true;
                Visible = false;
            }
            action("MAWB Status")
            {
                Image = "Action";

                trigger OnAction()
                begin
                    PAGE.RUNMODAL(Page::"MAWB Test");
                end;
            }

            group(Email)
            {
                action("Send Pre Alert")
                {
                    Image = Email;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Submitted);
                        IF CONFIRM('Do you want to Email Pre - Alerts?') THEN BEGIN
                            IF CustomMail.SendBookingSheetPreAlert2(Rec."No.") THEN
                                MESSAGE('Pre Alert Sent');
                            CurrPage.CLOSE;
                        END;
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(print; "&Print")
                {

                }
                actionref(print_email; "Print and Email")
                {

                }
                actionref(Submit_; Submit)
                {

                }
                actionref(MawbStatus_; "MAWB Status")
                {

                }
            }
            group(Category_Category10)
            {
                Caption = 'Email';
                actionref(sendprealert_; "Send Pre Alert")
                {

                }
            }
        }
    }

    var
        BookingSheetHeader: Record "Booking Sheet Header";
        BookingSheetLine: Record "Booking Sheet Line";
        MAWBAlloc: Record "Booking Sheet MAWB Allocation";
        BSConsignee: Record "Booking Sheet HAWB Allocation";
        GRNLine: Record "Good Receipt Header";
        CustomMail: Codeunit "Custom Mail";
}

