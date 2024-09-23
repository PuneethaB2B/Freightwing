page 50045 "Wt. Agreement By Airlines"
{
    Caption = 'Weight Agreement By Airlines';
    CardPageID = "Wt. Agreement By Airline";
    PageType = List;
    SourceTable = Table50033;

    layout
    {
        area(content)
        {
            repeater(Group)
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

