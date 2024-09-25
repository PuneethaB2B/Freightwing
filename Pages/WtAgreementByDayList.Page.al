page 50043 "Wt. Agreement By Day List"
{
    Caption = 'Weight Agreement By Day';
    MultipleNewLines = false;
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Weight,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 50035;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Day of Week"; Rec."Day of Week")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Weight By Item")
            {
                Caption = 'Weight By Item';
                Image = Print;
                action("&Weight By Item")
                {
                    Caption = '&Weight By Item';
                    Ellipsis = false;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50044;
                    RunPageLink = "Airline Code" = FIELD("Airline Code"),
                                  "Source Code" = FIELD("Source Code"),
                                  "Destination Code" = FIELD("Destination Code"),
                                  "Day of Week" = FIELD("Day of Week"),
                                  "Destination Airport" = FIELD("Destination Airport"),
                                  "Source Airport" = FIELD("Source Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

