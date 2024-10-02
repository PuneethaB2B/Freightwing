page 50094 "Operations Role Center"
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
                part(Page1; 9175)
                {
                }
            }
            group(fw1)
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
