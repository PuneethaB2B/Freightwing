page 50023 "Consignee List"
{
    CardPageID = "Consignee Card";
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Banks,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Consignee;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
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
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field(Blocked; Rec.Blocked)
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
                    RunObject = Page "Shipment Update Subform";
                    RunPageLink = "Activity Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

