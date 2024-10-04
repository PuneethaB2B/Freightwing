page 50161 "QR Code."
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "Sales Invoice Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Invoice Number"; Rec."Invoice Number")
            {
            }
            field("Deivice Code"; Rec."Deivice Code")
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

