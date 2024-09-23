page 50120 "MAWB Invoice Charges"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50073;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Freight Charge Code"; "Freight Charge Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Unit Of Measure"; "Unit Of Measure")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                    Editable = false;
                }
                field("Contract Rate"; "Contract Rate")
                {
                    Editable = false;
                }
                field("Agreed Rate"; "Agreed Rate")
                {
                }
                field("Cost Amount"; "Cost Amount")
                {
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Base Unit Price"; "Base Unit Price")
                {
                }
            }
        }
    }

    actions
    {
    }
}

