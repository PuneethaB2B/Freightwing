page 50141 Beneficiary
{
    PageType = List;
    SourceTable = 50003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                }
                field("Bank Name"; Rec."Bank Name")
                {
                }
                field("Account Number"; Rec."Account Number")
                {
                }
                field("Beneficiary Name"; Rec."Beneficiary Name")
                {
                }
                field(Branch; Rec.Branch)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

