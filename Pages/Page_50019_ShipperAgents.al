page 50019 "Shipper Agents"
{
    PageType = List;
    SourceTable = "Shipper Agent";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Agent Code"; Rec."Agent Code")
                {
                }
                field("Agent Name"; Rec."Agent Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

