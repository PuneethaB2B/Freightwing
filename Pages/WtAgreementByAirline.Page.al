page 50041 "Wt. Agreement By Airline"
{
    Caption = 'Weight Agreement By Airline';
    PageType = Card;
    SourceTable = 50033;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
                field("Total Capacity"; Rec."Total Capacity")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
            }
            part(Page; 50042)
            {
                SubPageLink = "Airline Code" = FIELD("Airline Code");
            }
        }
    }

    actions
    {
    }
}

