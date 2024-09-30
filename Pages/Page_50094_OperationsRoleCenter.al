page 50094 "Operations Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(fw)
            {
                part(Page; 9073)
                {
                }
                part(Page1; 9175)
                {
                }
            }
            group(fw1)
            {
                part(; 762)
                {
                    Visible = false;
                }
                part(; 762)
                {
                    Visible = false;
                }
                part(; 770)
                {
                    Visible = false;
                }
                part(; 770)
                {
                    Visible = false;
                }
                part(; 760)
                {
                    Visible = false;
                }
                part(; 681)
                {
                    Visible = false;
                }
                part(; 9150)
                {
                    Visible = false;
                }
                part(; 9151)
                {
                    Visible = false;
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 9152)
                {
                    Visible = false;
                }
                systempart(; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Goods Receipts")
            {
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50132;
            }
            action("Loading Sheet")
            {
                Image = NewOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50083;
            }
            action("Booking Sheet")
            {
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50071;
                RunPageView = WHERE(Status = FILTER(Submitted));
                Visible = true;
            }
            action("Print Loading Sheet")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50021;
            }
            action("Print Goods Receipt")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50018;
            }
            action("Print Booking Sheet")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50019;
            }
        }
    }
}

