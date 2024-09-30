page 50088 "Email Config"
{
    PageType = List;
    SourceTable = 50020;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Email; Rec.Email)
                {
                }
                field("Exclude From Invoice"; Rec."Exclude From Invoice")
                {
                }
                field("Exclude From Pre Alert"; Rec."Exclude From Pre Alert")
                {
                }
                field("Exclude From Post Alert"; Rec."Exclude From Post Alert")
                {
                }
            }
        }
    }

    actions
    {
    }
}

