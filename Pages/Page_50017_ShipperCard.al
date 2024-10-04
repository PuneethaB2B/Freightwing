page 50017 "Shipper Card"
{
    PageType = Card;
    PromotedActionCategories = ' New,Posting,Reports,Agents,Farms,Items,Notify Parties,Consignees,C9,C10';
    SourceTable = Customer;
    ApplicationArea = All;

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
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
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
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Email/CC"; Rec."Email/CC")
                {
                }
                field("Home Page"; Rec."Home Page")
                {
                }
                field("Contact Person"; Rec."Contact Person")
                {
                }
                field("Blocked."; Rec."Blocked.")
                {
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    NotBlank = true;
                }
                field("Copy Sell-to Addr. to Qte From"; Rec."Copy Sell-to Addr. to Qte From")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Importance = Promoted;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    Importance = Promoted;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Importance = Promoted;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Importance = Promoted;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                }
                field("Margin %"; Rec."Margin %")
                {
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Application Method"; Rec."Application Method")
                {
                }
                field("Partner Type"; Rec."Partner Type")
                {
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Importance = Promoted;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    Importance = Promoted;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    Importance = Promoted;
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                }
                field("Print Statements"; Rec."Print Statements")
                {
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                }
                field("Preferred Bank Account Code"; Rec."Preferred Bank Account Code")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Location Code"; Rec."Location Code")
                {
                    Importance = Promoted;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                }
                field(Reserve; Rec.Reserve)
                {
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    Importance = Promoted;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Importance = Promoted;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    Importance = Promoted;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    DrillDown = false;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Language Code"; Rec."Language Code")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
            }
        }
        area(factboxes)
        {
            part(Page1; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Page2; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Page3; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part(Page4; "Dimensions FactBox")
            {
                SubPageLink = "Table ID" = CONST(18),
                             "No." = FIELD("No.");
                Visible = false;
            }
            part(Page; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            part(Page5; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            systempart(fw; Links)
            {
                Visible = true;
            }
            systempart(fw1; Notes)
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
            group("Email Configuration")
            {
                Caption = 'Email Configuration';
                Image = Email;
                action(Email)
                {
                    Image = Email;
                    RunObject = Page "Email Config";
                    RunPageLink = Type = CONST(Shipper),
                                  "No." = FIELD("No.");
                }
            }
        }
    }
}

