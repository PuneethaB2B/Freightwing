page 50072 "Booking Sheet ULD Allocations"
{
    PageType = List;
    SourceTable = "Booking Sheet ULD Allocation";
    ApplicationArea = All;

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

