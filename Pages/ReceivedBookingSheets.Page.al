page 50129 "Received Booking Sheets"
{
    CardPageID = "Received Booking Sheet";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50053;
    SourceTableView = WHERE(Status = FILTER(Received));

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
        //SETFILTER("Prepared By",USERID);
    end;
}

