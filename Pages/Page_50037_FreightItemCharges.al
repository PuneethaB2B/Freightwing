page 50037 "Freight Item Charges"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Matrix,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Freight Item Charge";
    ApplicationArea = All;
    UsageCategory = Lists;

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
                field(Source; Rec.Source)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Freight Charge Matrix")
            {
                Caption = 'Freight Charge Matrix';
                Image = Print;
                action("&Freight Charge Matrix")
                {
                    Caption = '&Freight Charge Matrix';
                    Ellipsis = false;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Freight Item Charge Matrix";
                    RunPageLink = "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Freight Charge Code" = FIELD(Code),
                                  "Source airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport"),
                                  "Effective Start Date" = FIELD("Effective Start Date"),
                                  "Effective End Date" = FIELD("Effective End Date");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

