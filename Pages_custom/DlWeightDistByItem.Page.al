page 50053 "Dl. Weight Dist. By Item"
{
    Caption = 'Daily Weight Distribution By Item';
    PageType = List;
    SourceTable = Table50043;

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
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Shipped Weight"; "Shipped Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

