page 50026 "Notify Party List"
{
    CardPageID = "Notify Party Card";
    PageType = List;
    SourceTable = "Notify Party";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Home Page"; Rec."Home Page")
                {
                    Caption = 'Home Page';
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
    }

    actions
    {
    }
}

