page 50083 "Loading Sheets"
{
    CardPageID = "Loading Sheet";
    Editable = false;
    PageType = List;
    SourceTable = Table50060;
    SourceTableView = SORTING(No.)
                      ORDER(Descending)
                      WHERE(Shipped = FILTER(No),
                            Status = FILTER(<> Closed));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Loading Date"; "Loading Date")
                {
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Prepared By"; "Prepared By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

