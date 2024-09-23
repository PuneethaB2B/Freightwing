page 50003 "MAWB Line Charges"
{
    Editable = true;
    PageType = List;
    SourceTable = Table50004;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("G/L Account"; "G/L Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}

