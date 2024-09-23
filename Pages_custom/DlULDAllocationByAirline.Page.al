page 50054 "Dl. ULD Allocation By Airline"
{
    Caption = 'Daily ULD Allocation By Airline';
    PageType = List;
    SourceTable = Table50044;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type"; "ULD Type")
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

