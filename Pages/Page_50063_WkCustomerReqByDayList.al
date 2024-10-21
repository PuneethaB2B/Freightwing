page 50063 "Wk. Customer Req. By Day List"
{
    Caption = 'Customer Weight Requirement By Day';
    PageType = List;
    SourceTable = "Good Receipt Notify Party";
    ApplicationArea = All;
    UsageCategory = Lists;

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

