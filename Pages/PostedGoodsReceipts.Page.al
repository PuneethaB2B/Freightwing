page 50139 "Posted Goods Receipts"
{
    CardPageID = "Posted Goods Receipt";
    Editable = false;
    PageType = List;
    SourceTable = Table50052;
    SourceTableView = WHERE(Received = FILTER(Yes));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Receipt Date"; "Receipt Date")
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
                field(Loaded; Loaded)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Posted By"; "Posted By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

