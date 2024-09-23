pageextension 70000034 pageextension70000034 extends "Currency Exchange Rates"
{
    actions
    {
        addfirst(navigation)
        {
            group("Invoice Exchange Rates")
            {
                Caption = 'Invoice Exchange Rates';
                Image = Print;
                action("Invoice Exchange Rates")
                {
                    Caption = 'Invoice Exchange Rates';
                    Ellipsis = false;
                    Image = ItemCosts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50230;
                    RunPageLink = Field1 = FIELD (Currency Code);
                }
            }
        }
    }
}

