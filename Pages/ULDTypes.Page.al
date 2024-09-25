page 50060 "ULD Types"
{
    CardPageID = "ULD Type";
    PageType = List;
    SourceTable = 50031;

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

