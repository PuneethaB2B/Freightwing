page 50039 "Import Activities"
{
    PageType = List;
    SourceTable = 50009;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Code"; Rec."Activity Code")
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

