page 50063 "Wk. Customer Req. By Day List"
{
    Caption = 'Customer Weight Requirement By Day';
    PageType = List;
    SourceTable = Table50049;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Notify-Party No."; "Notify-Party No.")
                {
                }
                field("Notify-Party Name"; "Notify-Party Name")
                {
                }
                field("Item No."; "Item No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

