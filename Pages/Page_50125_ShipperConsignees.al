page 50125 "Shipper Consignees"
{
    PageType = List;
    SourceTable = "Shipper Consignee";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Consignee No."; Rec."Consignee No.")
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

