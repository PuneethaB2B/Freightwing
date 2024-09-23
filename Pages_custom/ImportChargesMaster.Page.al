page 50157 "Import Charges Master"
{
    PageType = List;
    SourceTable = Table50007;

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
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Import Charge"; "Import Charge")
                {
                }
                field(Currency; Currency)
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
                action("&Trird Party Handling Slab")
                {
                    Caption = '&Trird Party Handling Slab';
                    Ellipsis = false;
                    Image = ItemCosts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50151;
                    RunPageLink = Freight Charge Code=FIELD(Code);
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

