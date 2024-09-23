page 50071 "Booking Sheets"
{
    CardPageID = "Booking Sheet";
    Editable = false;
    PageType = List;
    SourceTable = Table50053;
    SourceTableView = WHERE (Status = FILTER (Open | Submitted));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Booking Date"; "Booking Date")
                {
                }
                field(Description; Description)
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Submitted on"; "Submitted on")
                {
                }
                field("Submitted at"; "Submitted at")
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

