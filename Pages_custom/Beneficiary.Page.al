page 50141 Beneficiary
{
    PageType = List;
    SourceTable = Table50003;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                field("Account Number"; "Account Number")
                {
                }
                field("Beneficiary Name"; "Beneficiary Name")
                {
                }
                field(Branch; Branch)
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

