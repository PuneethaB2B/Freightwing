page 50064 "Wk. Customer Wgt. Requirements"
{
    Caption = 'Weekly Customer Weight  Requirements';
    CardPageID = "Wk. Customer Wgt. Requirement";
    PageType = List;
    SourceTable = Table50047;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Destination Name"; "Destination Name")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
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

