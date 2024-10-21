page 50064 "Wk. Customer Wgt. Requirements"
{
    Caption = 'Weekly Customer Weight  Requirements';
    CardPageID = "Wk. Customer Wgt. Requirement";
    PageType = List;
    SourceTable = "Wk. Customer Wgt. Req. Header";
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
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Destination Name"; Rec."Destination Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        gRecUserAccess.RESET;
        gRecUserAccess.SETRANGE(gRecUserAccess.UserID, USERID);
        IF NOT gRecUserAccess.FINDFIRST THEN
            ERROR('You do not have access');
    end;

    var
        gRecUserAccess: Record "User Access to Cust Service";
}

