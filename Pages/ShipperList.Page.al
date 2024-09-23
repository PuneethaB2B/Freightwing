page 50018 "Shipper List"
{
    CardPageID = "Shipper Card";
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Agents,Farms,Items,Notify Parties,Consignees,C9,C10';
    SourceTable = Table18;

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
                field("Customer Type"; "Customer Type")
                {
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
                field(County; County)
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Home Page"; "Home Page")
                {
                }
                field("Contact Person"; "Contact Person")
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
                    RunObject = Page 50019;
                    RunPageLink = Shipper Code=FIELD(No.);

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
                    RunObject = Page 50021;
                                    RunPageLink = Shipper Code=FIELD(No.);

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
                    RunObject = Page 50123;
                                    RunPageLink = Shipper Code=FIELD(No.);

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
                    RunObject = Page 50124;
                                    RunPageLink = Shipper Code=FIELD(No.);

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
                    RunObject = Page 50125;
                                    RunPageLink = Shipper Code=FIELD(No.);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

