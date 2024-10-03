page 50140 "Customer Service Role Center_"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;

    layout
    {
        area(rolecenter)
        {
            group(General)
            {
                part(SmallBusinessOwnerAct; "Small Business Owner Act.")
                {
                }
                part(CopyProfile; 9175)
                {
                }
            }
            group(General1)
            {
                 part(FinancePerformance; "Finance Performance")
                {
                    Visible = false;
                }
               
                part(SalesPerformance; "Sales Performance")
                {
                    Visible = false;
                }
               
                part(TrailingSalesOrdersChart; "Trailing Sales Orders Chart")
                {
                    Visible = false;
                }
                part(ReportInboxPart; "Report Inbox Part")
                {
                    Visible = false;
                }
                part(MyCustomers; "My Customers")
                {
                    Visible = false;
                }
                part(MyVendors; "My Vendors")
                {
                    Visible = false;
                }
                part(MyJobQueue; "My Job Queue")
                {
                    Visible = false;
                }
                part(MyItems; "My Items")
                {
                    Visible = false;
                }
                systempart(MyNotes; MyNotes)
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
            separator(General2)
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

