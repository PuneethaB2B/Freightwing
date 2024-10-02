page 50029 Airports
{
    PageType = List;
    SourceTable = 50019;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Country Code"; Rec."Country Code")
                {
                }
                field(Location; Rec.Location)
                {
                }
            }
        }
    }

    actions
    {
    }
}
