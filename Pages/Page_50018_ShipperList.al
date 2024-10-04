page 50018 "Shipper List"
{
    CardPageID = "Shipper Card";
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Agents,Farms,Items,Notify Parties,Consignees,C9,C10';
    SourceTable = Customer;
    ApplicationArea = All;

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
                field("Customer Type"; Rec."Customer Type")
                {
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
                field(County; Rec.County)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Home Page"; Rec."Home Page")
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Agents)
            {
                Caption = 'Agents';
                Image = Print;
                action("&Agent")
                {
                    Caption = '&Agent';
                    Ellipsis = false;
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Shipper Agents";
                    RunPageLink = "Shipper Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Farms)
            {
                Caption = 'Farms';
                Image = Print;
                action("&Farm")
                {
                    Caption = '&Farm';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    RunObject = Page "Shipper Farms";
                    RunPageLink = "Shipper Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Items)
            {
                Caption = 'Items';
                Image = Print;
                action("&Item")
                {
                    Caption = '&Item';
                    Image = ItemLines;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    RunObject = Page "Shipper Items";
                    RunPageLink = "Shipper Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group("Notify Parties")
            {
                Caption = 'Notify Parties';
                Image = Print;
                action("&Notify Party")
                {
                    Caption = '&Notify Party';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    RunObject = Page "Shipper Notify Parties";
                    RunPageLink = "Shipper Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Consignees)
            {
                Caption = 'Consignees';
                Image = Print;
                action("&Consignee")
                {
                    Caption = '&Consignee';
                    Image = EditCustomer;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    RunObject = Page "Shipper Consignees";
                    RunPageLink = "Shipper Code" = FIELD("No.");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

