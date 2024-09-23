page 50075 "Booking Sheet FAM Allocation"
{
    PageType = List;
    SourceTable = 50058;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Farm Code"; Rec."Farm Code")
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

