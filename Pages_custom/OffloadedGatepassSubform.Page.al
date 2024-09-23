page 50113 "Offloaded Gatepass Subform"
{
    PageType = ListPart;
    SourceTable = Table50065;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type"; "ULD Type")
                {
                    Editable = false;
                }
                field("ULD No."; "ULD No.")
                {
                    Editable = false;
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                    Editable = false;
                }
                field("HAWB No"; "HAWB No")
                {
                    Editable = false;
                }
                field("Certificate Of Origin"; "Certificate Of Origin")
                {
                    Editable = false;
                }
                field("Custom Entry No"; "Custom Entry No")
                {
                    Editable = false;
                }
                field("Boxes Loaded"; Quantity)
                {
                    Editable = false;
                }
                field("Shipper Name"; "Shipper Name")
                {
                    Editable = false;
                }
                field("Offloaded Boxes"; "Offloaded Boxes")
                {
                }
                field("Offloaded Weight"; "Offloaded Weight")
                {
                }
                field(Diffrence; Diffrence)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = False;
                }
                field("Ship With Same AWB"; "Ship With Same AWB")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Stylexpr: Boolean;
}

