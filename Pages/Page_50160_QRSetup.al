page 50160 "QR Setup."
{
    PageType = Card;
    SourceTable = "QR Setup.";
    ApplicationArea = All;
    UsageCategory=Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Invoice Url"; Rec."Invoice Url")
                {
                }
                field("Credit Note Url"; Rec."Credit Note Url")
                {
                }
                field("QR Location"; Rec."QR Location")
                {
                }
            }
        }
    }

    actions
    {
    }
}

