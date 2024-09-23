page 50005 "MAWB Base Charges"
{
    PageType = List;
    SourceTable = Table50005;

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

