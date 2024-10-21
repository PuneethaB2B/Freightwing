page 50045 "Wt. Agreement By Airlines"
{
    Caption = 'Weight Agreement By Airlines';
    CardPageID = "Wt. Agreement By Airline";
    PageType = List;
    SourceTable = "Weight Agreement By Airline";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
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

