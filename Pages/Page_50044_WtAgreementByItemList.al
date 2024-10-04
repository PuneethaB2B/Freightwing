page 50044 "Wt. Agreement By Item List"
{
    Caption = 'Weight Agreement By Item';
    PageType = List;
    SourceTable = "Weight Agreement By Item";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Min. Chargeable Weight"; Rec."Min. Chargeable Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

