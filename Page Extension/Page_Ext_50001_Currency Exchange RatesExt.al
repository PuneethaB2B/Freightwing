pageextension 50001 CurrencyExchangeRatesExt extends "Currency Exchange Rates"
{
    actions
    {
        addfirst(navigation)
        {
            group("Invoice Exchange Rates1")
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
                    // RunObject = Page 50230;
                    // RunPageLink = Field1 = FIELD("Currency Code");  //B2BUPG
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

