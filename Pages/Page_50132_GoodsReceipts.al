page 50132 "Goods Receipts"
{
    CardPageID = "Goods Receipt";
    Editable = false;
    PageType = List;
    SourceTable = "Good Receipt Header";
    SourceTableView = WHERE(Received = FILTER(false),
                            Status = FILTER(Open | Submitted));
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field(Status; Rec.Status)
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

