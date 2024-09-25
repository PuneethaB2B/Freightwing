page 50093 "Gate Pass ULD Allocations"
{
    Editable = false;
    PageType = List;
    SourceTable = 50070;

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

