page 50113 "Offloaded Gatepass Subform"
{
    PageType = ListPart;
    SourceTable = 50065;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type"; Rec."ULD Type")
                {
                    Editable = false;
                }
                field("ULD No."; Rec."ULD No.")
                {
                    Editable = false;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                    Editable = false;
                }
                field("HAWB No"; Rec."HAWB No")
                {
                    Editable = false;
                }
                field("Certificate Of Origin"; Rec."Certificate Of Origin")
                {
                    Editable = false;
                }
                field("Custom Entry No"; Rec."Custom Entry No")
                {
                    Editable = false;
                }
                field("Boxes Loaded"; Rec.Quantity)
                {
                    Editable = false;
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                    Editable = false;
                }
                field("Offloaded Boxes"; Rec."Offloaded Boxes")
                {
                }
                field("Offloaded Weight"; Rec."Offloaded Weight")
                {
                }
                field(Diffrence; Rec.Diffrence)
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = False;
                }
                field("Ship With Same AWB"; Rec."Ship With Same AWB")
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

