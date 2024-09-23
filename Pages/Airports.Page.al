page 50029 Airports
{
    PageType = List;
    SourceTable = 50019;

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
                field(Location; Location)
                {
                }
            }
        }
    }

    actions
    {
    }
}

