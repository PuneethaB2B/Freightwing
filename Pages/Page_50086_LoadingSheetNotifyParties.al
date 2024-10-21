page 50086 "Loading Sheet Notify Parties"
{
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable =
    "Loading Sheet Notify Party";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field("Notify-Party No."; Rec."Notify-Party No.")
                {
                }
                field("Notify-Party Name"; Rec."Notify-Party Name")
                {
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
                        SalesInvHeader: Record "Sales Invoice Header";
                    begin
                        /*BookingSheetNotifyParty := Rec;
                        CurrPage.SETSELECTIONFILTER(BookingSheetNotifyParty);
                        BookingSheetNotifyParty.EmailRecords(FALSE);
                         */

                    end;
                }
            }
        }
    }

    var
        BookingSheetNotifyParty: Record "Booking Sheet Notify Party";
}

