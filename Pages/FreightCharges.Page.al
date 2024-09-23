page 50028 "Freight Charges"
{
    Caption = 'Charges';
    PageType = List;
    SourceTable = Table50018;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("G/L Account"; "G/L Account")
                {
                    Caption = 'Sales Account';
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Purchase A/C Code"; "Purchase A/C Code")
                {
                    Caption = 'Purchase Account';
                }
                field("Freight Cost"; "Freight Cost")
                {
                }
                field("Handling Charge"; "Handling Charge")
                {
                }
                field("Margin Applicable"; "Margin Applicable")
                {
                }
                field("Delivery Type"; "Delivery Type")
                {
                    ShowMandatory = true;
                }
                field("Split Charge Based On"; "Split On")
                {
                }
                field("Export Mandatory"; "Export Mandatory")
                {
                }
                field("Group Charge"; Group)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Freight Charges")
            {
                Caption = 'Freight Charges';
                Image = Print;
                action(" Handling Slab")
                {
                    Caption = ' Handling Slab';
                    Ellipsis = false;
                    Image = ItemCosts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50151;
                    RunPageLink = Freight Charge Code=FIELD(Code);

                    trigger OnAction()
                    begin
                        //IF "Handling Charge" =TRUE THEN
                        ///  PAGE.RUN(50151,HandlingSlabMatrix)
                        //ELSE
                        //  EXIT;
                    end;
                }
            }
        }
    }

    var
        Text000: Label 'Handling Slab applicable only for Handling Charges';
        HandlingSlabMatrix: Record "50045";
}

