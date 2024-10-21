page 50036 "Freight Charge By Item"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Freight Charges,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Freight Charge By Item";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
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
                    RunObject = Page "Freight Item Charges";
                    RunPageLink = "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Item No." = FIELD("No."),
                                  "Source Airport" = FIELD("Source Airport"),
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

