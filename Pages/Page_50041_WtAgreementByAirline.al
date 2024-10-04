page 50041 "Wt. Agreement By Airline"
{
    Caption = 'Weight Agreement By Airline';
    PageType = Card;
    SourceTable = "Weight Agreement By Airline";
    ApplicationArea = All;

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
            part(Page; "Wt. Agreement By Dest. Subform")
            {
                SubPageLink = "Airline Code" = FIELD("Airline Code");
            }
        }
    }

    actions
    {
    }
}

