page 50122 "MAWB Invoice Notify Parties"
{
    PageType = List;
    PromotedActionCategories = ' New,Process,Reports,Notification,C5,C6,C7,C8,C9,C10';
    SourceTable = "MAWB Invoice Notify Party";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoice No."; Rec."Invoice No.")
                {
                }
                field("Notify-Party No."; Rec."Notify-Party No.")
                {
                }
                field("Notify-Party Name"; Rec."Notify-Party Name")
                {
                }
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Source Type"; Rec."Source Type")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("HAWB No."; Rec."HAWB No.")
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
                        MAWBInvoiceNotifyParty := Rec;
                        CurrPage.SETSELECTIONFILTER(MAWBInvoiceNotifyParty);
                        MAWBInvoiceNotifyParty.EmailRecords(FALSE);
                    end;
                }
            }
        }
    }

    var
        MAWBInvoiceNotifyParty: Record "MAWB Invoice Notify Party";
}

