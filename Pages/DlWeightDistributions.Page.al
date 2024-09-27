page 50055 "Dl. Weight Distributions"
{
    Caption = 'Daily Weight Distributions';
    CardPageID = "Dl. Weight Distribution";
    PageType = List;
    ShowFilter = false;
    SourceTable = 50040;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Distribution Date"; Rec."Distribution Date")
                {
                }
                field("Day of Week"; Rec."Day of Week")
                {
                }
                field("Created By"; Rec."Created By")
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


        Rec.SETFILTER("Week No", '=%1', DATE2DWY(TODAY, 2));
    end;

    var
        gRecUserAccess: Record 50050;
}

