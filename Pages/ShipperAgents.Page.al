page 50019 "Shipper Agents"
{
    PageType = List;
    SourceTable = 50011;

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

