page 50134 "Goods Receipt Notify Parties"
{
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = Table50049;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                }
                field("Notify-Party No."; "Notify-Party No.")
                {
                }
                field("Notify-Party Name"; "Notify-Party Name")
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
                        SalesInvHeader: Record "112";
                    begin
                        GoodReceiptNotifyParty := Rec;
                        CurrPage.SETSELECTIONFILTER(GoodReceiptNotifyParty);
                        GoodReceiptNotifyParty.EmailRecords(FALSE);
                    end;
                }
            }
        }
    }

    var
        GoodReceiptNotifyParty: Record "50049";
}

