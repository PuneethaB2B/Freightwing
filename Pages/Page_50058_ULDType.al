page 50058 "ULD Type"
{
    PageType = Card;
    SourceTable = "ULD Type";
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
            part(Page; "ULD Subform")
            {
                SubPageLink = "ULD Type Code" = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

