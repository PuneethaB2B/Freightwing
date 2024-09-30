page 50063 "Wk. Customer Req. By Day List"
{
    Caption = 'Customer Weight Requirement By Day';
    PageType = List;
    SourceTable = 50049;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Notify-Party No."; Rec."Notify-Party No.")
                {
                }
                field("Notify-Party Name"; Rec."Notify-Party Name")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

