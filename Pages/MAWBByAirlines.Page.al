page 50049 "MAWB By Airlines"
{
    CardPageID = "MAWB By Airline";
    PageType = List;
    SourceTable = Table50038;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Airline Code"; "Airline Code")
                {
                }
                field("Airline Name"; "Airline Name")
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
        gRecUserAccess: Record "50050";
}

