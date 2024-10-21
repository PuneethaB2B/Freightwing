page 50120 "MAWB Invoice Charges"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "MAWB Invoice Charge";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Freight Charge Code"; Rec."Freight Charge Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                    Editable = false;
                }
                field("Contract Rate"; Rec."Contract Rate")
                {
                    Editable = false;
                }
                field("Agreed Rate"; Rec."Agreed Rate")
                {
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Base Unit Price"; Rec."Base Unit Price")
                {
                }
            }
        }
    }

    actions
    {
    }
}

