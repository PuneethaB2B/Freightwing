page 50114 "MAWB Invoice"
{
    Caption = 'MAWB Invoice';
    PageType = Document;
    PromotedActionCategories = ' New,Process,Reports,Documents & Charges,C5,C6,C7,C8,C9,C10';
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            Posted = FILTER(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Visible = false;
                }
                field("HAWB No."; Rec."HAWB No.")
                {
                    Visible = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Caption = 'Shipper Code';
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.SelltoCustomerNoOnAfterValidate;
                    end;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Caption = 'Shipper Name';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Caption = 'Shipper Address';
                    Importance = Additional;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Caption = 'Shipper Address 2';
                    Importance = Additional;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidate;
                    end;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                }
                field("Total Weight"; Rec."Total Weight")
                {
                }
                field("Agreed Rate"; Rec."Agreed Rate")
                {
                }
                field(Commodity; Rec.Commodity)
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Shipper Post Code';
                    Importance = Additional;
                    Visible = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Caption = 'Shipper City';
                    Visible = false;
                }
                field("CC/PP"; Rec."CC/PP")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Product Code"; Rec."Product Code")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
            }
            part(SalesLines; 50115)
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Importance = Additional;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Importance = Additional;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Importance = Additional;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Importance = Promoted;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Importance = Additional;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("Credit Card No."; "Credit Card No.")
                {
                }
                field(GetCreditcardNumber; GetCreditcardNumber)
                {
                    Caption = 'Cr. Card Number (Last 4 Digits)';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Importance = Additional;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Importance = Additional;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Importance = Additional;
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    Importance = Additional;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Exit Point"; Rec."Exit Point")
                {
                }
                field(Area;Area)
        {
        }
    }
}
        area(factboxes)
        {
            part(Page; ApplicationArea = All;
9080)
            {
                SubPageLink = "No."=FIELD("Sell-to Customer No.");
                Visible = false;
            }
            part(Page1;9081)
            {
                SubPageLink = "No."=FIELD("Bill-to Customer No.");
                Visible = false;
            }
            part(Page2;9082)
            {
                SubPageLink = "No."=FIELD("Bill-to Customer No.");
                Visible = true;
            }
            part(Page3;9084)
            {
                SubPageLink = "No."=FIELD("Sell-to Customer No.");
                Visible = true;
            }
            part(Page4;9087)
            {
                Provider = SalesLines;
                SubPageLink = "Document Type"=FIELD("Document Type"),
                              "Document No."=FIELD("Document No."),
                              "Line No."=FIELD("Line No.");
                Visible = false;
            }
            part(Page5;9089)
            {
                Provider = SalesLines;
                SubPageLink = "No."=FIELD("No.");
                Visible = true;
            }
            part(Page6;9092)
            {
                SubPageLink = "Table ID"=CONST(36),
                              "Document Type"=FIELD("Document Type"),
                              "Document No."=FIELD("No.");
                Visible = false;
            }
            part(Page7;9108)
            {
                Provider = SalesLines;
                SubPageLink = "No."=FIELD("No.");
                Visible = false;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
            systempart(;Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        COMMIT;
                        PAGE                            ApplicationArea = All;
.RUNMODAL(PAGE    ApplicationArea = All;
::"Sales Statistics",Rec);
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(Customer)
                {
                    Caption = 'Customer';
                    Image = Customer;
                    RunObject = Page 21;
                                    RunPageLink = "No."=    ApplicationArea = All;
FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page 658;
                                             ApplicationArea = All;
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
                        ApprovalEntries.RUN;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 67;
                                    RunPageLink = "Document Type"=    ApplicationArea = All;
FIELD("Document Type"),
                                  "No."=FIELD("No."),
                                  "Document Line No."=CONST(0);
                }
                separator()
                {
                }
                action("Documents/Certificates")
                {
                    Caption = 'Documents/Certificates';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50119;
                                    RunPageLink = "MAWB No"=    ApplicationArea = All;
FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("MAWB Charges")
                {
                    Caption = 'MAWB Charges';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50120;
                                    RunPageLink = "MAWB No."=    ApplicationArea = All;
FIELD("MAWB No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("Notify Parties")
                {
                    Caption = 'Notify Parties';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50122;
                                    RunPageLink = "Invoice No."=    ApplicationArea = All;
FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = CreditCardLog;
                action("Credit Cards Transaction Lo&g Entries")
                {
                    Caption = 'Credit Cards Transaction Lo&g Entries';
                    Image = CreditCardLog;
                    RunObject = Page 829;
                                    RunPageLink = "Document Type"=    ApplicationArea = All;
FIELD("Document Type"),
                                  "Document No."=FIELD("No."),
                                  "Customer No."=FIELD("Bill-to Customer No.");
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("MAWB Status")
                {
                    Image = "Action";
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        PAGE                            ApplicationArea = All;
.RUNMODAL(50127);
                    end;
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit 414;
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
                separator()
                {
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData 19=R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                        SalesCalcDiscountByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                separator()
                {
                }
                action("Re Calculate Charges")
                {
                    Caption = 'Re Calculate Charges';
                    Image = CalculateInvoiceDiscount;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Check.CalculateMAWBCharges("MAWB No.");
                        Check.CalculateHandlingFees("MAWB No.");
                    end;
                }
                separator()
                {
                }
                separator()
                {
                }
                action(SplitMAWBInvoice)
                {
                    Caption = 'Split &MAWB';
                    Ellipsis = true;
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Check.CheckAllCharges("MAWB No.","No.");
                        SplitMAWBInvoice;
                        // _________________ CALC Split factor _________________________________
                        TBLHNo := 0;
                        TBLMAWBLine.RESET;
                        TBLMAWBLine.SETRANGE("MAWB No.","MAWB No.");
                        TBLMAWBLine.SETFILTER("HAWB No.",'<>%1','');
                        IF TBLMAWBLine.FINDSET THEN
                          REPEAT
                            TBLHNo := TBLHNo + 1;
                          UNTIL TBLMAWBLine.NEXT = 0;

                        // ****************************** Calculating agreed rate ********************
                        TBLAgreedRate := 0;
                        TBLMAWBInvoiceCharge.RESET;
                        TBLMAWBInvoiceCharge.SETRANGE("MAWB No.","MAWB No.");
                        IF TBLMAWBInvoiceCharge.FINDSET THEN;
                          REPEAT
                           TBLAgreedRate := TBLAgreedRate + TBLMAWBInvoiceCharge."Agreed Rate";
                          UNTIL TBLMAWBInvoiceCharge.NEXT = 0;

                        // ****************************** Modifications for third party customers *****************
                        TBLCustomer.GET("Bill-to Customer No.");
                        TBLSalesLine.RESET;
                        TBLSalesLine.SETRANGE("Document No.","No.");
                        IF TBLSalesLine.FINDSET THEN REPEAT
                          IF TBLHNo = 0 THEN
                            TBLSalesLine."Split Factor" := 1
                          ELSE
                          TBLSalesLine."Split Factor" := TBLHNo;

                          IF (TBLCustomer."Customer Type" = 2) AND (Status = 0) THEN BEGIN
                            IF (TBLSalesLine."Freight Charge Code" = '14') THEN BEGIN
                              TBLSalesLine."Freight Charge Code" := '82';
                              TBLSalesLine.Description := 'Freight Charges TP';
                              TBLSalesLine."Margin %" := TBLCustomer."Margin %";
                              TBLSalesLine."Shortcut Dimension 2 Code" := 'THIRD PARTY';
                              // _________________ Calculating Cost amount ____
                              TBLMAWBLine.RESET;
                              TBLMAWBLine.SETRANGE("MAWB No.","MAWB No.");
                              TBLMAWBLine.SETRANGE("HAWB No.",TBLSalesLine."HAWB No.");
                              IF TBLMAWBLine.FINDFIRST THEN BEGIN
                                TBLSalesLine."Split Weight" := TBLMAWBLine."Chargeable Weight";
                                TBLFlightCode := TBLMAWBLine."Flight Code";
                              END;
                              TBLFreightItemCharge.RESET;
                              TBLFreightItemCharge.SETRANGE("Flight Code",TBLFlightCode);
                              TBLFreightItemCharge.SETRANGE("Freight Charge Code",'82');
                              IF TBLFreightItemCharge.FINDFIRST THEN
                                TBLSalesLine."Cost Amount" := (TBLSalesLine."Split Weight" * TBLAgreedRate);// / TBLSalesLine."Split Factor";
                                // _________________________ Calculating amounts ________
                              TBLSalesLine."Margin Amount" := (TBLSalesLine."Margin %" / 100) * TBLSalesLine."Cost Amount";
                              TBLSalesLine."Amount Including VAT" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount" + TBLSalesLine."VAT Amount";
                              TBLSalesLine."Line Amount" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount";
                              TBLSalesLine.MODIFY;
                            END // if freight charge code is 14
                            ELSE IF (TBLSalesLine."Freight Charge Code" = '17') THEN BEGIN
                              TBLSalesLine."Freight Charge Code" := '118';
                              TBLSalesLine.Description := 'Handling Fees Sales TP';
                              TBLSalesLine."Shortcut Dimension 2 Code" := 'THIRD PARTY';
                                 // _________________ Calculating Cost amount ____
                              TBLMAWBLine.RESET;
                              TBLMAWBLine.SETRANGE("MAWB No.","MAWB No.");
                              TBLMAWBLine.SETRANGE("HAWB No.",TBLSalesLine."HAWB No.");
                              IF TBLMAWBLine.FINDFIRST THEN BEGIN
                                TBLSalesLine."Split Weight" := TBLMAWBLine."Chargeable Weight";
                                TBLFlightCode := TBLMAWBLine."Flight Code";
                              END;
                        //      TBLFreightItemCharge.RESET;
                        //      TBLFreightItemCharge.SETRANGE("Flight Code",TBLFlightCode);
                        //      TBLFreightItemCharge.SETRANGE("Freight Charge Code",'118');
                        //      IF TBLFreightItemCharge.FINDSET THEN
                        //        TBLSalesLine."Cost Amount" := (TBLSalesLine."Split Weight" * TBLAgreedRate) / TBLSalesLine."Split Factor";
                                //Calculating Cost Amount based on Slabs
                                gRecHandlingSlab.RESET;
                                gRecHandlingSlab.SETRANGE("Freight Charge Code",TBLSalesLine."Freight Charge Code");
                                gRecHandlingSlab.SETFILTER(gRecHandlingSlab."From Weight",'<=%1',TBLSalesLine."Split Weight");
                                gRecHandlingSlab.SETFILTER(gRecHandlingSlab."To Weight",'>=%1',TBLSalesLine."Split Weight");
                                IF gRecHandlingSlab.FINDFIRST  THEN
                                  TBLSalesLine."Cost Amount" := gRecHandlingSlab."Rate Amount"/TBLSalesLine."Split Factor";
                                //Calculating VAT
                                IF gRecFreightCharges.GET(TBLSalesLine."Freight Charge Code") THEN
                                  TBLSalesLine.VALIDATE("VAT Prod. Posting Group",gRecFreightCharges."VAT Prod. Posting Group");

                              // _________________________ Calculating amounts ________
                              TBLSalesLine."Margin Amount" := (TBLSalesLine."Margin %" / 100) * TBLSalesLine."Cost Amount";
                              TBLSalesLine."Amount Including VAT" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount" + TBLSalesLine."VAT Amount";
                              TBLSalesLine."Line Amount" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount";
                              TBLSalesLine.MODIFY;
                            END // if freight charge code is 17
                            ELSE IF (TBLSalesLine."Freight Charge Code" = '34') THEN BEGIN
                              TBLSalesLine."Freight Charge Code" := '88';
                              TBLSalesLine.Description := 'K.A.A Fee(Exports) TP';
                              TBLSalesLine."Shortcut Dimension 2 Code" := 'THIRD PARTY';
                              // _________________ Calculating Cost amount ____
                              TBLMAWBLine.RESET;
                              TBLMAWBLine.SETRANGE("MAWB No.","MAWB No.");
                              TBLMAWBLine.SETRANGE("HAWB No.",TBLSalesLine."HAWB No.");
                              IF TBLMAWBLine.FINDSET THEN BEGIN
                                TBLSalesLine."Split Weight" := TBLMAWBLine."Chargeable Weight";
                                TBLFlightCode := TBLMAWBLine."Flight Code";
                              END;
                              TBLFreightItemCharge.RESET;
                              TBLFreightItemCharge.SETRANGE("Flight Code",TBLFlightCode);
                              TBLFreightItemCharge.SETRANGE("Freight Charge Code",'88');
                              IF TBLFreightItemCharge.FINDFIRST THEN
                                TBLSalesLine."Cost Amount" := (TBLSalesLine."Split Weight" * TBLAgreedRate) / TBLSalesLine."Split Factor";
                              // _________________________ Calculating amounts ________
                              TBLSalesLine."Margin Amount" := (TBLSalesLine."Margin %" / 100) * TBLSalesLine."Cost Amount";
                              TBLSalesLine."Amount Including VAT" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount" + TBLSalesLine."VAT Amount";
                              TBLSalesLine."Line Amount" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount";
                              TBLSalesLine.MODIFY;
                            END; // if freight charge code is 34
                          END // if customer is third party // ________________________ CALC Amnt Excl VAT _______
                          ELSE IF (TBLCustomer."Customer Type" <> 2) AND (Status = 0) THEN BEGIN
                            IF TBLCustomer."Customer Type" = TBLCustomer."Customer Type"::Group THEN BEGIN//Calculate Handling charges based on customer type
                              IF (TBLSalesLine."Freight Charge Code" IN ['118','17']) THEN BEGIN
                                IF TBLSalesLine."Freight Charge Code" = '118' THEN BEGIN
                                  TBLSalesLine."Freight Charge Code" := '17';
                                  TBLSalesLine.Description := 'Handling Fees  Sales  GROUP';
                                  TBLSalesLine."Shortcut Dimension 2 Code" := 'GROUP';
                                END;
                                // _________________ Calculating Cost amount ____
                                TBLMAWBLine.RESET;
                                TBLMAWBLine.SETRANGE("MAWB No.","MAWB No.");
                                TBLMAWBLine.SETRANGE("HAWB No.",TBLSalesLine."HAWB No.");
                                IF TBLMAWBLine.FINDFIRST THEN BEGIN
                                  TBLSalesLine."Split Weight" := TBLMAWBLine."Chargeable Weight";
                                  TBLFlightCode := TBLMAWBLine."Flight Code";
                                END;
                                //Calculating Cost Amount based on Slabs
                                gRecHandlingSlab.RESET;
                                gRecHandlingSlab.SETRANGE("Freight Charge Code",TBLSalesLine."Freight Charge Code");
                                gRecHandlingSlab.SETFILTER(gRecHandlingSlab."From Weight",'<=%1',TBLSalesLine."Split Weight");
                                gRecHandlingSlab.SETFILTER(gRecHandlingSlab."To Weight",'>=%1',TBLSalesLine."Split Weight");
                                IF gRecHandlingSlab.FINDFIRST  THEN
                                  TBLSalesLine."Cost Amount" := gRecHandlingSlab."Rate Amount"/TBLSalesLine."Split Factor";
                                //Calculating VAT
                                IF gRecFreightCharges.GET(TBLSalesLine."Freight Charge Code") THEN BEGIN
                                  TBLSalesLine.VALIDATE("VAT Prod. Posting Group",gRecFreightCharges."VAT Prod. Posting Group");
                                  TBLSalesLine.VALIDATE("VAT %");
                                END;
                              END;
                            END;
                            TBLSalesLine."Margin Amount" := (TBLSalesLine."Margin %" / 100) * TBLSalesLine."Cost Amount";
                            TBLSalesLine."Amount Including VAT" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount" + TBLSalesLine."VAT Amount";
                            TBLSalesLine."Line Amount" := TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount";
                            TBLSalesLine.MODIFY;
                          END;
                            TBLSalesLine."Margin Amount" := ROUND((TBLSalesLine."Margin %" / 100) * TBLSalesLine."Cost Amount",0.01);
                            TBLSalesLine."Amount Including VAT" := ROUND(TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount" + TBLSalesLine."VAT Amount",0.01);
                            TBLSalesLine.VALIDATE("Unit Price",ROUND(TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount",0.01));
                            TBLSalesLine.VALIDATE("Line Amount",ROUND(TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount",0.01));
                            TBLSalesLine.VALIDATE(Amount,ROUND(TBLSalesLine."Cost Amount" + TBLSalesLine."Margin Amount",0.01));

                            TBLSalesLine."VAT Amount" := TBLSalesLine."Amount Including VAT" - TBLSalesLine.Amount;
                          //  TBLSalesLine.VALIDATE("VAT Prod. Posting Group",TBLSalesLine."VAT Prod. Posting Group");
                          //  TBLSalesLine.VALIDATE("VAT %");
                            TBLSalesLine.MODIFY;
                        UNTIL TBLSalesLine.NEXT = 0;
                        // ****************************** End of modifications ************************************
                    end;
                }
                separator()
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record 172;
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator()
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator()
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit 439;
                    begin
                        IF ApprovalMgt.CancelSalesApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                separator()
                {
                }
            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = AuthorizeCreditCard;
                action(Authorize)
                {
                    Caption = 'Authorize';
                    Image = AuthorizeCreditCard;

                    trigger OnAction()
                    begin
                        Authorize;
                    end;
                }
                action("Void A&uthorize")
                {
                    Caption = 'Void A&uthorize';
                    Image = VoidCreditCard;

                    trigger OnAction()
                    begin
                        Void;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        // ******************************* TBL Validating Cost Amount *****************
                        TBLPostValidate := TRUE;
                        TBLSalesLine.FINDSET;
                        REPEAT
                           IF (TBLSalesLine."Document No." = "No.") THEN
                               BEGIN
                                     IF (TBLSalesLine."Cost Amount" = 0) THEN
                                        TBLPostValidate := FALSE;
                                END;
                        UNTIL TBLSalesLine.NEXT = 0;
                        // ********************************** END ***************************************
                        IF (TBLPostValidate) THEN  BEGIN
                        MAWBAlloc.RESET;
                        MAWBAlloc.SETRANGE(MAWBAlloc."MAWB No","No.");
                        IF MAWBAlloc.FINDFIRST THEN
                        BEGIN
                         BookingSheetLine.RESET;
                         BookingSheetLine.SETRANGE(BookingSheetLine."Booking Sheet No.",MAWBAlloc."Booking Sheet No");
                         IF BookingSheetLine.FINDSET THEN
                         BEGIN
                          REPEAT
                           FreightCharge.RESET;
                           FreightCharge.SETRANGE(FreightCharge."Delivery Type",BookingSheetLine."Type of Delivery");
                           IF FreightCharge.FINDSET THEN
                           BEGIN
                            REPEAT
                             SalesLine.RESET;
                             SalesLine.SETRANGE(SalesLine."Document No.","No.");
                             SalesLine.SETRANGE(SalesLine."Freight Charge Code",FreightCharge.Code);
                             IF SalesLine.FIND('-') THEN
                             BEGIN
                               IF SalesLine."Unit Price" = 0 THEN BEGIN
                                 ERROR(Text000,FreightCharge."Delivery Type");
                               END;
                             END;
                             UNTIL FreightCharge.NEXT=0;
                           END;

                          UNTIL BookingSheetLine.NEXT = 0;
                         END;
                        END;
                        CloseMawb("MAWB No.");
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                        ///PostSalesInvoice;
                        MAWBHeader.GET("MAWB No.");
                        MAWBHeader."Invoice Status":=MAWBHeader."Invoice Status"::New;
                        MAWBHeader.MODIFY;
                        END
                        ELSE
                        MESSAGE('You can not post this invoice while you have zero cost amount in the lines');
                    end;
                }
                action("Mail Invoice")
                {
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM('Do you want to Send the Invoice ?') THEN
                        BEGIN
                        //MESSAGE("No.");
                          Mailed := CustomMail.SendInvoice("No.","Bill-to Customer No.");
                          IF Mailed THEN
                            MESSAGE('Emailed');
                        END;
                    end;
                }
                action(Print)
                {
                    Caption = 'Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //ReportPrint.PrintSalesHeader(Rec);
                        SalesHeader.RESET;
                        SalesHeader.SETRANGE("No.","No.");
                        IF SalesHeader.FINDFIRST THEN BEGIN
                          MAWBHeader.RESET;
                          MAWBHeader.SETRANGE(MAWBHeader."No.","MAWB No.");
                          IF MAWBHeader.FINDFIRST THEN
                          BEGIN
                            IF MAWBHeader."Has Houses" THEN
                             BEGIN
                                REPORT                                    ApplicationArea = All;
.RUNMODAL(50015,TRUE,FALSE, SalesHeader);
                             END ELSE
                             BEGIN
                              // REPORT.RUNMODAL(50015,TRUE,FALSE, SalesHeader);
                              REPORT                                                                                                                    ApplicationArea = All;
.RUNMODAL(50039,TRUE,FALSE, SalesHeader)
                             END;
                          END ELSE BEGIN MESSAGE('MAWB Not found in Documentation');END;
                        END;
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction()
                    begin
                        // ******************************* TBL Validating Cost Amount *****************
                        TBLPostValidate := TRUE;
                        TBLSalesLine.FINDSET;
                        REPEAT
                           IF (TBLSalesLine."Document No." = "No.") THEN
                               BEGIN
                                     IF (TBLSalesLine."Cost Amount" = 0) THEN
                                        TBLPostValidate := FALSE;
                                END;
                        UNTIL TBLSalesLine.NEXT = 0;
                        // ********************************** END ***************************************
                        IF (TBLPostValidate) THEN  BEGIN
                             Post(CODEUNIT::"Sales-Post + Print");
                        END;
                    end;
                }
                action("Post and Email")
                {
                    Caption = 'Post and Email';
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit 82;
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT                            ApplicationArea = All;
.RUNMODAL(REPORT    ApplicationArea = All;
::"Batch Post Sales Invoices",TRUE,TRUE,Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
                action(Calc)
                {
                    Caption = 'Calc';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SetExtDocNoMandatoryCondition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter;
        //ImportExportSetup.GET();
        //VALIDATE("Currency Code",ImportExportSetup."Invoicing Currency Code");
    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
          FILTERGROUP(0);
        END;

        SetDocNoVisible;
    end;

    var
        ChangeExchangeRate: Page 511;
                                CopySalesDoc: Report 292;
                                MoveNegSalesLines: Report 6699;
                                ReportPrint: Codeunit 228;
                                UserMgt: Codeunit 5700;
                                SalesCalcDiscountByType: Codeunit 56;


                                JobQueueVisible: Boolean;
                                DocNoVisible: Boolean;
                                ExternalDocNoMandatory: Boolean;
                                MAWBLine: Record 50076;
                                SalesHeader: Record 36;
                                ImportChargeMaster: Record 50007;
                                ImportExportSetup: Record 50010;
                                BookingSheetHAWBAllocation: Record 50056;
                                BookingSheetLine: Record 50054;
                                FreightCharge: Record 50018;
                                SalesLine: Record 37;
                                Text000:     ApplicationArea = All;
Label 'Ensure that all costs relating to %1 have been captured before posting invoice';
    MAWBAlloc: Record 50070;
    FCharges: Record 50018;
    MAWBHeader: Record 50077;
    Check: Codeunit 50031;
    CustomMail: Codeunit 50030;
    Mailed: Boolean;
    Custcode: Code[30];
    CustRec: Record 18;
    TBLSalesLine: Record 37;
    TBLPostValidate: Boolean;
    TBLSalesHeader: Record 36;
    TBLCustomer: Record 18;
    TBLHNo: Integer;
    TBLMAWBLine: Record 50076;
    TBLFreightItemCharge: Record 50029;
    TBLFlightCode: Code[20];
    TBLAgreedRate: Decimal;
    TBLMAWBInvoiceCharge: Record 50073;
    TBLPurchInvLine: Record 123;
    TBLCurrecnyCode: Code[10];
    TBLPurchInvHeader: Record 122;
    TBLExchangeRate: Record 330;
    TBLAmountLCY: Decimal;
    TBLAmountUSD: Decimal;
    TBLPurchLineAmount: Decimal;
    TBLPurchInvLineTemp: Record 123 temporary;
    gRecHandlingSlab: Record 50045;
    gRecFreightCharges: Record 50018;

local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE    ApplicationArea = All;
.ApproveCalcInvDisc;
    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        IF GETFILTER("Sell-to Customer No.") = xRec."Sell-to Customer No." THEN
          IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN
            SETRANGE("Sell-to Customer No.");
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE    ApplicationArea = All;
.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.UPDATE;
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit 1400;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Invoice,"No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    var
        SalesReceivablesSetup: Record "311";
    begin
        SalesReceivablesSetup.GET;
        ExternalDocNoMandatory := SalesReceivablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure CloseMawb(MAWB: Code[50])
    var
        BookingSheetMAWBAllocation: Record 50070;
        MAWBReceipt: Record "50039";
        BookingSheetMAWBAllocation1: Record 50070;
        BookingSheetMAWBAllocation2: Record 50070;
        i: Integer;
    begin
        BookingSheetMAWBAllocation.RESET;
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No",MAWB);
        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code","Sell-to Customer No.");
        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
          BookingSheetMAWBAllocation.Invoiced:=TRUE;
          BookingSheetMAWBAllocation.MODIFY;
        END;
        BookingSheetMAWBAllocation1.RESET;
        BookingSheetMAWBAllocation1.SETRANGE(BookingSheetMAWBAllocation1."MAWB No",MAWB);
        BookingSheetMAWBAllocation1.SETRANGE(BookingSheetMAWBAllocation1.Invoiced,FALSE);
        IF NOT BookingSheetMAWBAllocation1.FINDFIRST THEN BEGIN
          MAWBReceipt.RESET;
          MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.",MAWB);
          IF MAWBReceipt.FINDFIRST THEN BEGIN
            MAWBReceipt.Invoiced:=TRUE;
            MAWBReceipt."Invioced Date":="Posting Date";
            MAWBReceipt.MODIFY;
          END;
        END;
    end;
}

