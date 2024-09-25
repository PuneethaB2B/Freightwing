page 50097 "Security Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

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
                part(Page3; 762)
                {
                    Visible = false;
                }
                part(Page4; 762)
                {
                    Visible = false;
                }
                part(Page5; 770)
                {
                    Visible = false;
                }
                part(Page6; 770)
                {
                    Visible = false;
                }
                part(Page7; 760)
                {
                    Visible = false;
                }
                part(Page8; 681)
                {
                    Visible = false;
                }
                part(Page9; 9150)
                {
                    Visible = false;
                }
                part(Page10; 9151)
                {
                    Visible = false;
                }
                part(Page11; 675)
                {
                    Visible = false;
                }
                part(Page12; 9152)
                {
                    Visible = false;


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

