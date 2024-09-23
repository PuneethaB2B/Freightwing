page 50088 "Email Config"
{
    PageType = List;
    SourceTable = Table50020;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Email; Email)
                {
                }
                field("Exclude From Invoice"; "Exclude From Invoice")
                {
                }
                field("Exclude From Pre Alert"; "Exclude From Pre Alert")
                {
                }
                field("Exclude From Post Alert"; "Exclude From Post Alert")
                {
                }
            }
        }
    }

    actions
    {
    }
}

