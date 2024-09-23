page 50122 "MAWB Invoice Notify Parties"
{
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = Table50072;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No."; "Invoice No.")
                {
                }
                field("Notify-Party No."; "Notify-Party No.")
                {
                }
                field("Notify-Party Name"; "Notify-Party Name")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("HAWB No."; "HAWB No.")
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
                        MAWBInvoiceNotifyParty := Rec;
                        CurrPage.SETSELECTIONFILTER(MAWBInvoiceNotifyParty);
                        MAWBInvoiceNotifyParty.EmailRecords(FALSE);
                    end;
                }
            }
        }
    }

    var
        MAWBInvoiceNotifyParty: Record "50072";
}

