page 50085 "Loading Sheet ULD Allocations"
{
    PageType = List;
    SourceTable = 50063;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type Code"; Rec."ULD Type Code")
                {
                }
                field("ULD No."; Rec."ULD No.")
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
                field("FWL Docket No."; Rec."FWL Docket No.")
                {
                    ShowMandatory = true;
                }
                field("No. Of Boxes"; Rec."No. Of Boxes")
                {
                }
                field(Dimension; Rec.Dimension)
                {
                }
            }
        }
    }

    actions
    {
    }
}

