page 50049 "MAWB By Airlines"
{
    CardPageID = "MAWB By Airline";
    PageType = List;
    SourceTable = "MAWB By Airline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
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

