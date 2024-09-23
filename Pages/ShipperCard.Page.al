page 50017 "Shipper Card"
{
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Agents,Farms,Items,Notify Parties,Consignees,C9,C10';
    SourceTable = Table18;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
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
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(City; City)
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
                field("Email/CC"; "Email/CC")
                {
                }
                field("Home Page"; "Home Page")
                {
                }
                field("Contact Person"; "Contact Person")
                {
                }
                field("Blocked."; "Blocked.")
                {
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Invoice Copies"; "Invoice Copies")
                {
                }
                field("Invoice Disc. Code"; "Invoice Disc. Code")
                {
                    NotBlank = true;
                }
                field("Copy Sell-to Addr. to Qte From"; "Copy Sell-to Addr. to Qte From")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Importance = Promoted;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    Importance = Promoted;
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                    Importance = Promoted;
                }
                field("Customer Disc. Group"; "Customer Disc. Group")
                {
                    Importance = Promoted;
                }
                field("Allow Line Disc."; "Allow Line Disc.")
                {
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                }
                field("Prepayment %"; "Prepayment %")
                {
                }
                field("Margin %"; "Margin %")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Application Method"; "Application Method")
                {
                }
                field("Partner Type"; "Partner Type")
                {
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    Importance = Promoted;
                }
                field("Reminder Terms Code"; "Reminder Terms Code")
                {
                    Importance = Promoted;
                }
                field("Fin. Charge Terms Code"; "Fin. Charge Terms Code")
                {
                    Importance = Promoted;
                }
                field("Cash Flow Payment Terms Code"; "Cash Flow Payment Terms Code")
                {
                }
                field("Print Statements"; "Print Statements")
                {
                }
                field("Last Statement No."; "Last Statement No.")
                {
                }
                field("Block Payment Tolerance"; "Block Payment Tolerance")
                {
                }
                field("Preferred Bank Account"; "Preferred Bank Account")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Location Code"; "Location Code")
                {
                    Importance = Promoted;
                }
                field("Combine Shipments"; "Combine Shipments")
                {
                }
                field(Reserve; Reserve)
                {
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    Importance = Promoted;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    Importance = Promoted;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    Importance = Promoted;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                }
                field("Shipping Time"; "Shipping Time")
                {
                }
                field("Base Calendar Code"; "Base Calendar Code")
                {
                    DrillDown = false;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Language Code"; "Language Code")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
            }
        }
        area(factboxes)
        {
            part(; 9080)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = true;
            }
            part(;9081)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = false;
            }
            part(;9082)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = true;
            }
            part(;9083)
            {
                SubPageLink = Table ID=CONST(18),
                              No.=FIELD(No.);
                Visible = false;
            }
            part(;9085)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = false;
            }
            part(;9086)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = true;
            }
            systempart(;Notes)
            {
                Visible = true;
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
            group("Email Configuration")
            {
                Caption = 'Email Configuration';
                Image = Email;
                action(Email)
                {
                    Image = Email;
                    RunObject = Page 50088;
                                    RunPageLink = Type=CONST(Shipper),
                                  No.=FIELD(No.);
                }
            }
        }
    }
}

