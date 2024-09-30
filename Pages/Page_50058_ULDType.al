page 50058 "ULD Type"
{
    PageType = Card;
    SourceTable = 50031;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
            part(Page; 50059)
            {
                SubPageLink = "ULD Type Code" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

