page 50060 "ULD Types"
{
    CardPageID = "ULD Type";
    PageType = List;
    SourceTable = "ULD Type";
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
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

