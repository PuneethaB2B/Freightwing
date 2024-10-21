page 50136 "Received Booking Sheet ULD"
{
    PageType = List;
    SourceTable = "Booking Sheet ULD Allocation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("ULD Type Code"; Rec."ULD Type Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("MAVB No."; Rec."MAVB No.")
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

