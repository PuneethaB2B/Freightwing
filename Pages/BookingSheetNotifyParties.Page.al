page 50074 "Booking Sheet Notify Parties"
{
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = 50057;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Notify-Party No."; Rec."Notify-Party No.")
                {
                }
                field("Notify-Party Name"; Rec."Notify-Party Name")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Notification)
            {
                Caption = 'Notification';
                Image = Email;
                action("&Email")
                {
                    Caption = '&Email';
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SalesInvHeader: Record 112;
                    begin
                        /*BookingSheetNotifyParty := Rec;
                        CurrPage.SETSELECTIONFILTER(BookingSheetNotifyParty);
                        BookingSheetNotifyParty.EmailRecords(FALSE);*/

                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            BookingSheetNotifyParty.RESET;
                            BookingSheetNotifyParty.SETRANGE(BookingSheetNotifyParty."Booking Sheet No.", Rec."Booking Sheet No.");
                            IF BookingSheetNotifyParty.FINDSET THEN BEGIN
                                REPEAT
                                    BookingSheetNotifyParty2.RESET;
                                    BookingSheetNotifyParty2.COPY(BookingSheetNotifyParty);
                                    BookingSheetNotifyParty2.SETRANGE(BookingSheetNotifyParty2."Notify-Party No.", BookingSheetNotifyParty."Notify-Party No.");
                                    BookingSheetNotifyParty2.SETRANGE(BookingSheetNotifyParty2."Item No.", Rec."Item No.");
                                    IF BookingSheetNotifyParty2.FINDFIRST THEN BEGIN
                                        BookingSheetNotifyParty2.EmailRecords(FALSE, BookingSheetNotifyParty2);
                                    END;
                                UNTIL BookingSheetNotifyParty.NEXT = 0;
                            END;
                        END;

                    end;
                }
            }
        }
    }

    var
        BookingSheetNotifyParty: Record 50057;
        BookingSheetNotifyParty2: Record 50057;
        Text001: Label 'Do you want to send the email notifications?';
}

