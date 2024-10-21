page 50152 "User Access to Cust Service"
{
    Caption = 'User Access to Customer Service';
    PageType = List;
    SourceTable = "User Access to Cust Service";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("S.No"; Rec."S.No")
                {
                }
                field(UserID; Rec.UserID)
                {
                }
                field(UserName; Rec.UserName)
                {
                }
            }
        }
    }

    actions
    {
    }
}

