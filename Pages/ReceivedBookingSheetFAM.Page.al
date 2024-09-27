page 50144 "Received Booking Sheet FAM"
{
    PageType = List;
    SourceTable = 50058;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Farm Code"; Rec."Farm Code")
                {
                }
                field("FAM Name"; Rec."FAM Name")
                {
                    Editable = false;
                }
                field(Weight; Rec.Weight)
                {
                }
            }
        }
    }

    actions
    {
    }
}

