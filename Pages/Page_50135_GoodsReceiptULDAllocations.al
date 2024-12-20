page 50135 "Goods Receipt ULD Allocations"
{
    PageType = List;
    SourceTable = "Good Receipt ULD Allocation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                }
                field("ULD Type Code"; Rec."ULD Type Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                field("FWL Docket Weight"; Rec."FWL Docket Weight")
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

