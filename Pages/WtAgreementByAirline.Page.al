page 50041 "Wt. Agreement By Airline"
{
    Caption = 'Weight Agreement By Airline';
    PageType = Card;
    SourceTable = Table50033;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Airline Code"; "Airline Code")
                {
                }
                field("Airline Name"; "Airline Name")
                {
                }
                field("Total Capacity"; "Total Capacity")
                {
                }
                field(Description; Description)
                {
                }
                field(From; From)
                {
                }
                field("To"; "To")
                {
                }
            }
            part(; 50042)
            {
                SubPageLink = Airline Code=FIELD(Airline Code);
            }
        }
    }

    actions
    {
    }
}

