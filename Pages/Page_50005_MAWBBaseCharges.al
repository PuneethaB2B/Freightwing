page 50005 "MAWB Base Charges"
{
    PageType = List;
    SourceTable = "MAWB Base Charge";
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

