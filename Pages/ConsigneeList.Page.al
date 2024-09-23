page 50023 "Consignee List"
{
    CardPageID = "Consignee Card";
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Banks,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table50015;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field("Internet Address"; "Internet Address")
                {
                    Caption = 'Home Page';
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field(City; City)
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field(Blocked; Blocked)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Banks)
            {
                Caption = 'Banks';
                Image = Print;
                action("&Bank")
                {
                    Caption = '&Bank';
                    Ellipsis = false;
                    Image = Bank;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50024;
                    RunPageLink = Activity Code=FIELD(No.);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

