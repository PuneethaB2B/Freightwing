page 50071 "Booking Sheets"
{
    CardPageID = "Booking Sheet";
    Editable = false;
    PageType = List;
    SourceTable = 50053;
    SourceTableView = WHERE(Status = FILTER(Open | Submitted));
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
                field("Booking Date"; Rec."Booking Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Submitted on"; Rec."Submitted on")
                {
                }
                field("Submitted at"; Rec."Submitted at")
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
        gRecUserAccess: Record 50050;
}

