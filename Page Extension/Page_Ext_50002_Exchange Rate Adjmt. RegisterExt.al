pageextension 50002 ExchangeRateAdjmtRegisterExt extends "Exchange Rate Adjmt. Register"
{
    layout
    {
        addafter("Currency Code")
        {
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = all;
                Caption = 'Currency Factor';
            }
        }
    }
}