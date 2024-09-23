page 50055 "Dl. Weight Distributions"
{
    Caption = 'Daily Weight Distributions';
    CardPageID = "Dl. Weight Distribution";
    PageType = List;
    ShowFilter = false;
    SourceTable = Table50040;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Distribution Date"; "Distribution Date")
                {
                }
                field("Day of Week"; "Day of Week")
                {
                }
                field("Created By"; "Created By")
                {
                    Editable = false;
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


        SETFILTER("Week No", '=%1', DATE2DWY(TODAY, 2));
    end;

    var
        gRecUserAccess: Record "50050";
}

