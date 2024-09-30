page 50139 "Posted Goods Receipts"
{
    CardPageID = "Posted Goods Receipt";
    Editable = false;
    PageType = List;
    SourceTable = 50052;
    SourceTableView = WHERE(Received = FILTER(true));
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
                field("Receipt Date"; Rec."Receipt Date")
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
                field(Loaded; Rec.Loaded)
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

