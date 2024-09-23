page 50022 "Consignee Card"
{
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Banks,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = 50015;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Rec.Name)
                {
                }
                field("Internet Address"; Rec."Internet Address")
                {
                    Caption = 'Home Page';
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("CC/Email"; "CC/Email")
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
                    RunPageLink = "Activity Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group("Email Configuration")
            {
                action("Email Setup")
                {
                    Image = Email;
                    RunObject = Page 50088;
                    RunPageLink = Type = CONST(Consignee),
                                  "No." = FIELD("No.");
                }
            }
        }
    }
}

