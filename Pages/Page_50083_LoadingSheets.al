page 50083 "Loading Sheets"
{
    CardPageID = "Loading Sheet";
    Editable = false;
    PageType = List;
    SourceTable = "Loading Sheet Header";
    SourceTableView = SORTING("No.")
                      ORDER(Descending)
                      WHERE(Shipped = FILTER(false),
                            Status = FILTER(<> Closed));
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
                field("Loading Date"; Rec."Loading Date")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

