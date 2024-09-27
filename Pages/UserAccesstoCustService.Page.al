page 50152 "User Access to Cust Service"
{
    Caption = 'User Access to Customer Service';
    PageType = List;
    SourceTable = 50050;
    ApplicationArea = All;

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

