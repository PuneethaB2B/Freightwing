page 50095 "Customer Service Role Center"
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
                    Visible = false;
                }
                part(CopyProfile; "Copy Profile")
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
                RunObject = Page "Dl. Weight Distributions";
            }
            action("Booking Sheet")
            {
                Image = NewExchangeRate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Booking Sheets";
            }
            action("MAWB Receipt")
            {
                Image = NewItemNonStock;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "MAWB By Airlines";
            }
            action(Airlines)
            {
                Image = NewChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Airlines;
            }
            action(Airports)
            {
                Image = NewResource;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page Airports;
            }
            action(Items)
            {
                Image = NewItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Item List";
            }
            action(Shippers)
            {
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Shipper List";
            }
            action(Farms)
            {
                Image = NewDepreciationBook;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Divisions/Farms";
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
                    RunObject = Report "Booking Sheet";
                }
                action("Wight Distribution")
                {
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Daily Weight Distribution";
                    Scope = Page;
                }
            }
        }
    }
}

