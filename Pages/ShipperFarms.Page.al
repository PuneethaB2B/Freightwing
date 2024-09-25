page 50021 "Shipper Farms"
{
    PageType = List;
    SourceTable = 50014;

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

