page 50088 "Email Config"
{
    PageType = List;
    SourceTable = "Mailing Configuration";
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

