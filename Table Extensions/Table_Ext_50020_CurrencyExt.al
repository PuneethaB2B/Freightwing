tableextension 50020 CurrencyExt extends Currency
{
    fields
    {
        field(50000; "Currency Numeric Description"; Code[30])
        {
            Caption = 'Currency Numeric Description';
        }
        field(50001; "Currency Decimal Description"; Code[30])
        {
            Caption = 'Currency Decimal Description';
        }
    }
}

