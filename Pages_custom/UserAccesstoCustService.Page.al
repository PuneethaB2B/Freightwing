page 50152 "User Access to Cust Service"
{
    Caption = 'User Access to Customer Service';
    PageType = List;
    SourceTable = Table50050;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("S.No"; "S.No")
                {
                }
                field(UserID; UserID)
                {
                }
                field(UserName; UserName)
                {
                }
            }
        }
    }

    actions
    {
    }
}

