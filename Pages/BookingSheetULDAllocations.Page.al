page 50072 "Booking Sheet ULD Allocations"
{
    PageType = List;
    SourceTable = 50055;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type Code"; Rec."ULD Type Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

