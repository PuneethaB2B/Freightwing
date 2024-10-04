page 50059 "ULD Subform"
{
    PageType = ListPart;
    SourceTable = ULD;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD No."; Rec."ULD No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

