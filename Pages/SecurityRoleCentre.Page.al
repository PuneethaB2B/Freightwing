page 50097 "Security Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9073)
                {
                }
                part(; 9175)
                {
                }
            }
            group()
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
            action("Archived Master Airway Bills")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50077;
            }
            action("Gate Passes")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50091;
            }
            action("Posted Loading Sheets")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50102;
            }
            action("Gate Pass")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report 50016;
            }
        }
    }
}

