page 50036 "Freight Charge By Item"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Freight Charges,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table50027;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Description; Description)
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
                action("&Freight Charge")
                {
                    Caption = '&Freight Charge';
                    Ellipsis = false;
                    Image = ItemCosts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50037;
                    RunPageLink = Airline Code=FIELD(Airline Code),
                                  Flight Code=FIELD(Flight Code),
                                  Item No.=FIELD(No.),
                                  Source Airport=FIELD(Source Airport),
                                  Destination Airport=FIELD(Destination Airport),
                                  Effective Start Date=FIELD(Effective Start Date),
                                  Effective End Date=FIELD(Effective End Date);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

