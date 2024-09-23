page 50123 "Shipper Items"
{
    PageType = List;
    SourceTable = Table50012;

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
            }
        }
    }

    actions
    {
    }
}

