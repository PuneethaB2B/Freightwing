page 50144 "Received Booking Sheet FAM"
{
    PageType = List;
    SourceTable = Table50058;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Farm Code"; "Farm Code")
                {
                }
                field("FAM Name"; "FAM Name")
                {
                    Editable = false;
                }
                field(Weight; Weight)
                {
                }
            }
        }
    }

    actions
    {
    }
}

