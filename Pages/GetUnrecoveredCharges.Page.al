page 50010 "Get Unrecovered Charges"
{
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("MAWB No"; "MAWB No")
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                field(Source; Source)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Line Amount"; "Line Amount")
                {
                }
                field(Recovered; Recovered)
                {
                }
                field("Document No."; "Document No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

