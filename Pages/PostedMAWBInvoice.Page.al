page 50145 "Posted MAWB Invoice"
{
    Caption = 'Posted MAWB Invoice';
    Editable = false;
    PageType = Document;
    PromotedActionCategories = ' New,Process,Reports,Documents & Charges,C5,C6,C7,C8,C9,C10';
    RefreshOnActivate = true;
    SourceTable = Table36;
    SourceTableView = WHERE (Document Type=FILTER(Invoice),
                            Posted=FILTER(Yes));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                          CurrPage.UPDATE;
                    end;
                }
                field("MAWB No.";"MAWB No.")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field("HAWB No.";"HAWB No.")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Caption = 'Shipper Code';
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Customer Name";"Sell-to Customer Name")
                {
                    Caption = 'Shipper Name';
                }
                field("Sell-to Address";"Sell-to Address")
                {
                    Caption = 'Shipper Address';
                    Importance = Additional;
                }
                field("Sell-to Address 2";"Sell-to Address 2")
                {
                    Caption = 'Shipper Address 2';
                    Importance = Additional;
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Importance = Promoted;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Document Date";"Document Date")
                {
                }
                field("Sell-to Post Code";"Sell-to Post Code")
                {
                    Caption = 'Shipper Post Code';
                    Importance = Additional;
                }
                field("Sell-to City";"Sell-to City")
                {
                    Caption = 'Shipper City';
                }
                field("Currency Code";"Currency Code")
                {
                }
                field("Prices Including VAT";"Prices Including VAT")
                {
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field(Posted;Posted)
                {
                }
                field("Posting Description";"Posting Description")
                {
                }
                field(Status;Status)
                {
                    Importance = Promoted;
                }
            }
            part(SalesLines;50146)
            {
                SubPageLink = Document No.=FIELD(No.);
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Contact No.";"Bill-to Contact No.")
                {
                }
                field("Bill-to Name";"Bill-to Name")
                {
                }
                field("Bill-to Address";"Bill-to Address")
                {
                    Importance = Additional;
                }
                field("Bill-to Address 2";"Bill-to Address 2")
                {
                    Importance = Additional;
                }
                field("Bill-to Post Code";"Bill-to Post Code")
                {
                    Importance = Additional;
                }
                field("Bill-to City";"Bill-to City")
                {
                }
                field("Bill-to Contact";"Bill-to Contact")
                {
                    Importance = Additional;
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                    Importance = Promoted;
                }
                field("Due Date";"Due Date")
                {
                    Importance = Promoted;
                }
                field("Payment Discount %";"Payment Discount %")
                {
                }
                field("Pmt. Discount Date";"Pmt. Discount Date")
                {
                    Importance = Additional;
                }
                field("Payment Method Code";"Payment Method Code")
                {
                }
                field("Direct Debit Mandate ID";"Direct Debit Mandate ID")
                {
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
                field("Credit Card No.";"Credit Card No.")
                {
                }
                field(GetCreditcardNumber;GetCreditcardNumber)
                {
                    Caption = 'Cr. Card Number (Last 4 Digits)';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code";"Ship-to Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to Name";"Ship-to Name")
                {
                }
                field("Ship-to Address";"Ship-to Address")
                {
                    Importance = Additional;
                }
                field("Ship-to Address 2";"Ship-to Address 2")
                {
                    Importance = Additional;
                }
                field("Ship-to Post Code";"Ship-to Post Code")
                {
                    Importance = Promoted;
                }
                field("Ship-to City";"Ship-to City")
                {
                }
                field("Ship-to Contact";"Ship-to Contact")
                {
                    Importance = Additional;
                }
                field("Location Code";"Location Code")
                {
                }
                field("Shipment Method Code";"Shipment Method Code")
                {
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                    Importance = Additional;
                }
                field("Shipment Date";"Shipment Date")
                {
                    Importance = Promoted;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("EU 3-Party Trade";"EU 3-Party Trade")
                {
                }
                field("Transaction Type";"Transaction Type")
                {
                }
                field("Transaction Specification";"Transaction Specification")
                {
                }
                field("Transport Method";"Transport Method")
                {
                }
                field("Exit Point";"Exit Point")
                {
                }
                field(Area;Area)
                {
                }
            }
        }
        area(factboxes)
        {
            part(;9080)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                Visible = false;
            }
            part(;9081)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                Visible = false;
            }
            part(;9082)
            {
                SubPageLink = No.=FIELD(Bill-to Customer No.);
                Visible = true;
            }
            part(;9084)
            {
                SubPageLink = No.=FIELD(Sell-to Customer No.);
                Visible = true;
            }
            part(;9087)
            {
                Provider = SalesLines;
                SubPageLink = Document Type=FIELD(Document Type),
                              Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.);
                Visible = false;
            }
            part(;9089)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
                Visible = true;
            }
            part(;9092)
            {
                SubPageLink = Table ID=CONST(36),
                              Document Type=FIELD(Document Type),
                              Document No.=FIELD(No.);
                Visible = false;
            }
            part(;9108)
            {
                Provider = SalesLines;
                SubPageLink = No.=FIELD(No.);
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
                Enabled = false;
                Image = Invoice;
                Visible = false;
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
                        PAGE.RUNMODAL(PAGE::"Sales Statistics",Rec);
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
                                    RunPageLink = No.=FIELD(Sell-to Customer No.);
                    ShortCutKey = 'Shift+F7';
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "658";
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
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
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
                                    RunPageLink = MAWB No=FIELD(No.);
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
                                    RunPageLink = MAWB No.=FIELD(MAWB No.);
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
            group("Credit Card")
            {
                Caption = 'Credit Card';
                Image = CreditCardLog;
                Visible = false;
                action("Credit Cards Transaction Lo&g Entries")
                {
                    Caption = 'Credit Cards Transaction Lo&g Entries';
                    Image = CreditCardLog;
                    RunObject = Page 829;
                                    RunPageLink = Document Type=FIELD(Document Type),
                                  Document No.=FIELD(No.),
                                  Customer No.=FIELD(Bill-to Customer No.);
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Visible = false;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "414";
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
                        ReleaseSalesDoc: Codeunit "414";
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
                Enabled = false;
                Image = "Action";
                Visible = false;
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
                action(CalculateMAWBCharges)
                {
                    Caption = 'Calculate &MAWB Charges';
                    Image = CalculateInvoiceDiscount;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CalculateMAWBCharges;
                    end;
                }
                separator()
                {
                }
                action(GetDefaultCharges)
                {
                    Caption = 'Default Charges';
                    Ellipsis = true;
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //GetDefaultCharges;
                    end;
                }
                separator()
                {
                }
                action(SplitMAWBInvoice)
                {
                    Caption = 'Split &Invoice';
                    Ellipsis = true;
                    Image = Shipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        SplitMAWBInvoice;
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
                        StdCustSalesCode: Record "172";
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
                        ApprovalMgt: Codeunit "439";
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
                        ApprovalMgt: Codeunit "439";
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
                Enabled = false;
                Image = AuthorizeCreditCard;
                Visible = false;
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
                Visible = false;
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
                        //Post(CODEUNIT::"Sales-Post (Yes/No)");
                        PostSalesInvoice;
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
                        IF SalesHeader.FINDFIRST THEN
                          REPORT.RUNMODAL(50015,TRUE,FALSE, SalesHeader);
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
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    Caption = 'Post and Email';
                    Image = PostMail;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit "82";
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
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices",TRUE,TRUE,Rec);
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
        ChangeExchangeRate: Page "511";
                                CopySalesDoc: Report "292";
                                MoveNegSalesLines: Report "6699";
                                ReportPrint: Codeunit "228";
                                UserMgt: Codeunit "5700";
                                SalesCalcDiscountByType: Codeunit "56";
    [InDataSet]

    JobQueueVisible: Boolean;
    DocNoVisible: Boolean;
    ExternalDocNoMandatory: Boolean;
    MAWBLine: Record "50076";
    SalesHeader: Record "36";

local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
          CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
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
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
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
        DocumentNoVisibility: Codeunit "1400";
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
}

