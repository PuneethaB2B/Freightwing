page 50129 "Received Booking Sheets"
{
    CardPageID = "Received Booking Sheet";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50053;
    SourceTableView = WHERE(Status = FILTER(Received));
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
        //SETFILTER("Prepared By",USERID);
    end;
}

