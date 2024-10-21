page 50030 Airlines
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Flights,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Airline;
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
                field(Name; Rec.Name)
                {
                }
                field(Shade; Rec.Shade)
                {
                }
                field("Prefix Code"; Rec."Prefix Code")
                {
                }
                field("AWB Fee"; Rec."AWB Fee")
                {
                }
                field("Default Vendor No"; Rec."Default Vendor No")
                {
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Flights)
            {
                Caption = 'Flights';
                Image = Print;
                action("&Flight")
                {
                    Caption = '&Flight';
                    Ellipsis = false;
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page Flights;
                    RunPageLink = "Airline Code" = FIELD(Code);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

