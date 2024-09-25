page 50003 "MAWB Line Charges"
{
    Editable = true;
    PageType = List;
    SourceTable = 50004;

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
                field(Amount; Rec.Amount)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                }
            }
        }
    }

    actions
    {
    }
}

