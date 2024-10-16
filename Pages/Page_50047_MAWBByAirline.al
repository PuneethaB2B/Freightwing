page 50047 "MAWB By Airline"
{
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Charges,C5,C6,C7,C8,C9,C10';
    SourceTable = "MAWB By Airline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
            }
            part(Page; "MAWB Receipts Subform")
            {
                SubPageLink = "Airline Code" = FIELD("Airline Code");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Base Charges")
            {
                Caption = 'Base Charges';
                Image = Print;
                action("&Base Charges")
                {
                    Caption = '&Base Charges';
                    Ellipsis = false;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    /* RunObject = Page 50228;
                    RunPageLink = Field5 = FIELD("Airline Code"); */ //B2BUPG due to Page 50228 is not found in client db

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

