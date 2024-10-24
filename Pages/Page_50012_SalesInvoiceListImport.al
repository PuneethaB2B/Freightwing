page 50012 "Sales Invoice List - Import"
{
    Caption = 'Sales Invoices';
    CardPageID = "Sales Invoice - Import";
    Editable = false;
    PageType = List;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = CONST(Invoice));
    ApplicationArea = All;
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Import MAWB No."; Rec."Import MAWB No.")
                {
                    Caption = 'MAWB No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Visible = false;
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Visible = false;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Visible = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Visible = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Visible = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {
            part(Page1; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            part(Page; "Customer Details FactBox")
            {
                SubPageLink = "No." = FIELD("Bill-to Customer No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            systempart(System; Links)
            {
                Visible = false;
            }
            systempart(System1; Notes)
            {
                Visible = true;
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
                        Rec.CalcInvDiscForHeader;
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Sales Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(DATABASE::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
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
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalMgt.IsSalesApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalMgt.OnSendSalesDocForApproval(Rec);       //B2BUPG

                        // IF ApprovalMgt.SendSalesApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalMgt.OnCancelSalesApprovalRequest(Rec);      //B2BUPG

                        // IF ApprovalMgt.CancelSalesApprovalRequest(Rec, TRUE, TRUE) THEN;
                    end;
                }
                separator(General1)
                {
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        Rec.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
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
                        Rec.SendToPosting(CODEUNIT::Microsoft.Sales.Posting."Sales-Post + Print");
                    end;
                }
                action("Post and Email")
                {
                    Caption = 'Post and Email';
                    Image = PostMail;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        SalesPostPrint: Codeunit Microsoft.Sales.Posting."Sales-Post + Print";
                    begin
                        SalesPostPrint.PostAndEmail(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Invoices", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Remove From Job Queue")
                {
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter;
        JobQueueActive := SalesSetup.JobQueueActive;
    end;

    var
        ReportPrint: Codeunit "Test Report-Print";
        JobQueueActive: Boolean;
}

