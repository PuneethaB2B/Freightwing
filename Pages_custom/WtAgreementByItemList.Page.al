page 50044 "Wt. Agreement By Item List"
{
    Caption = 'Weight Agreement By Item';
    PageType = List;
    SourceTable = Table50036;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field("Min. Chargeable Weight"; "Min. Chargeable Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

