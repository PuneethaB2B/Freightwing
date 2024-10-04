page 50093 "Gate Pass ULD Allocations"
{
    Editable = false;
    PageType = List;
    SourceTable = "Booking Sheet MAWB Allocation";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No"; Rec."Item No")
                {
                }
                field("Flight No"; Rec."Flight No")
                {
                }
                field("MAWB No"; Rec."MAWB No")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

