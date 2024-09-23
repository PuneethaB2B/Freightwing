page 50102 "Posted Loading Sheets"
{
    CardPageID = "Posted Loading Sheet";
    Editable = false;
    PageType = List;
    SourceTable = Table50060;
    SourceTableView = WHERE (Shipped = FILTER (Yes));

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
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field(Status; Status)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Posted By"; "Posted By")
                {
                }
                field("Posted Time"; "Posted Time")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Run Batch")
            {
                AccessByPermission = TableData 79 = I;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50067;
            }
        }
    }
}

