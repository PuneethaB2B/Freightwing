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
                part(Page1; "Copy Profile")
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
                RunObject = Page "Archived MAWBs";
            }
            action("Gate Passes")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Gate Passes";
            }
            action("Posted Loading Sheets")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Posted Loading Sheets";
            }
            action("Gate Pass")
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Report "Gate Pass";
            }
        }
    }
}

