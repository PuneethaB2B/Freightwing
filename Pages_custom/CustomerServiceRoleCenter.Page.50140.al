page 50140 "Customer Service Role Center_"
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
            action("Daily Weight Distributions")
            {
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50055;
            }
            action(Airlines)
            {
                Image = NewChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50030;
            }
            action(Airports)
            {
                Image = NewResource;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50029;
            }
            action(Items)
            {
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 31;
            }
            action(Shippers)
            {
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50017;
            }
            action(Farms)
            {
                Image = NewDepreciationBook;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50020;
            }
            action("Booking Sheet")
            {
                Image = NewExchangeRate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50071;
            }
            action("MAWB Receipt")
            {
                Image = NewItemNonStock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50049;
            }
            separator()
            {
            }
            group(Reports)
            {
                action("Booking Sheets")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report 50019;
                }
                action("Wight Distribution")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report 50020;
                    Scope = Page;
                }
            }
        }
    }
}

