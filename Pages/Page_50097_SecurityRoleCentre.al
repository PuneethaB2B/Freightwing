page 50097 "Security Role Centre"
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
                systempart(My_Notes; MyNotes)
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

