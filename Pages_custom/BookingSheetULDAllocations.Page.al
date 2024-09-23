page 50072 "Booking Sheet ULD Allocations"
{
    PageType = List;
    SourceTable = Table50055;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type Code"; "ULD Type Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Remarks; Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

