page 50135 "Goods Receipt ULD Allocations"
{
    PageType = List;
    SourceTable = Table50046;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Visible = false;
                }
                field("ULD Type Code"; "ULD Type Code")
                {
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("FWL Docket Weight"; "FWL Docket Weight")
                {
                }
                field(Remarks; Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

