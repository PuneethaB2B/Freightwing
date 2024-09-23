page 50085 "Loading Sheet ULD Allocations"
{
    PageType = List;
    SourceTable = Table50063;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type Code"; "ULD Type Code")
                {
                }
                field("ULD No."; "ULD No.")
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
                field("FWL Docket No."; "FWL Docket No.")
                {
                    ShowMandatory = true;
                }
                field("No. Of Boxes"; "No. Of Boxes")
                {
                }
                field(Dimension; Dimension)
                {
                }
            }
        }
    }

    actions
    {
    }
}

