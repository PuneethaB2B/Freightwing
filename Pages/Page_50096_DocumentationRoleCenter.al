page 50096 "Documentation Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

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
            action("Master Airway Bills")
            {
                Image = NewExchangeRate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50100;
            }
            action("House Airway Bills")
            {
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50108;
            }
            action("Posted Loading Sheets")
            {
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50102;
            }
        }
    }
}

