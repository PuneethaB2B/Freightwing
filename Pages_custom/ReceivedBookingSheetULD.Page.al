page 50136 "Received Booking Sheet ULD"
{
    PageType = List;
    SourceTable = Table50055;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field("ULD Type Code"; "ULD Type Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Remarks; Remarks)
                {
                }
                field("MAVB No."; "MAVB No.")
                {
                    Caption = 'Linked MAWB No.';
                }
            }
        }
    }

    actions
    {
    }
}

