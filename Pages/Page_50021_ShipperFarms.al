page 50021 "Shipper Farms"
{
    PageType = List;
    SourceTable = "Shipper Farm";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Farm Code"; Rec."Farm Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

