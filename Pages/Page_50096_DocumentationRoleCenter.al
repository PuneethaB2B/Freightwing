page 50096 "Documentation Role Center"
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
                part(; 9175)
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

