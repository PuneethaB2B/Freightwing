page 50028 "Freight Charges"
{
    Caption = 'Charges';
    PageType = List;
    SourceTable = 50018;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    Caption = 'Sales Account';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Purchase A/C Code"; Rec."Purchase A/C Code")
                {
                    Caption = 'Purchase Account';
                }
                field("Freight Cost"; Rec."Freight Cost")
                {
                }
                field("Handling Charge"; Rec."Handling Charge")
                {
                }
                field("Margin Applicable"; Rec."Margin Applicable")
                {
                }
                field("Delivery Type"; Rec."Delivery Type")
                {
                    ShowMandatory = true;
                }
                field("Split Charge Based On"; Rec."Split On")
                {
                }
                field("Export Mandatory"; Rec."Export Mandatory")
                {
                }
                field("Group Charge"; Rec.Group)
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
                    RunPageLink = "Freight Charge Code" = FIELD(Code);

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
        HandlingSlabMatrix: Record 50045;
}

