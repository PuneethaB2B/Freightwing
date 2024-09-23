page 50075 "Booking Sheet FAM Allocation"
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

