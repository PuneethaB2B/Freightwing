page 50164 "Cr. QR Code."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Sales Cr.Memo Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Invoice Number"; Rec."Invoice Number")
            {
            }
            field("Deivice Code"; Rec."Device Code")
            {
            }
            field("QR Code"; Rec."QR Code")
            {
            }
        }
    }

    actions
    {
    }
}

