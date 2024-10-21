page 50027 Countries
{
    Caption = 'Countries';
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Airports,C5,C6,C7,C8,C9,C10';
    SourceTable = "Country/Region";
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
            }
        }
        area(factboxes)
        {
            systempart(Link; Links)
            {
                Visible = false;
            }
            systempart(Note; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Airports)
            {
                Caption = 'Airports';
                Image = Print;
                action("&Airport")
                {
                    Caption = '&Airport';
                    Ellipsis = false;
                    Image = Travel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page Airports;
                    RunPageLink = "Country Code" = FIELD(Code);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

