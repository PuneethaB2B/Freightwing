page 50132 "Goods Receipts"
{
    CardPageID = "Goods Receipt";
    Editable = false;
    PageType = List;
    SourceTable = Table50052;
    SourceTableView = WHERE(Received = FILTER(No),
                            Status = FILTER(Open | Submitted));

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
                field("Prepared By"; "Prepared By")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

