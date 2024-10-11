codeunit 50038 "Events And Subscribers"
{
    //Codeunit 22 Item Jnl.-Post Line>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Shipper Code" := ItemJournalLine."Shipper Code";
        NewItemLedgEntry.Weight := ItemJournalLine.Weight;
    end;
    //Codeunit 22 Item Jnl.-Post Line<<

    //Codeunit 80 Sales-Post>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeInsertInvoiceHeader', '', false, false)]

    local procedure OnBeforeInsertInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header"; var IsHandled: Boolean)
    begin
        SalesInvHeader.Commodity := SalesHeader.Commodity;
        SalesInvHeader."Total Weight" := SalesHeader."Total Weight";
    end;

    PROCEDURE ModifySalesInv(VAR SalesInvoiceHeader: Record "Sales Invoice Header"): Boolean;
    BEGIN
        EXIT(SalesInvoiceHeader.MODIFY);
    END;

    PROCEDURE ModifySalesCreditMemo(VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean;
    BEGIN
        EXIT(SalesCrMemoHeader.MODIFY);
    END;
    //Codeunit 80 Sales-Post<<

    //Codeunit 90 Purch.-Post>>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchLine', '', false, false)]
    local procedure OnBeforePostPurchLine(var PurchHeader: Record "Purchase Header"; var PurchLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        UnrecoveredCharges: Record "Unrecovered Charge";
    begin
        //Insert Unrecovered charges to be converted to sales invoice
        UnrecoveredCharges.RESET;
        UnrecoveredCharges.INIT;
        IF UnrecoveredCharges.FIND('+') THEN
            UnrecoveredCharges."Line No." := UnrecoveredCharges."Line No." + 1000
        ELSE
            UnrecoveredCharges."Line No." := 10000;
        UnrecoveredCharges."MAWB No" := PurchLine."MAWB No.";
        UnrecoveredCharges."Document No." := PurchHeader."No.";
        UnrecoveredCharges.Type := UnrecoveredCharges.Type::"G/L Account";
        UnrecoveredCharges."No." := PurchLine."No.";
        UnrecoveredCharges.Description := PurchLine.Description;
        UnrecoveredCharges.Source := UnrecoveredCharges.Source::"Purchase Invoice";
        UnrecoveredCharges."Line Amount" := PurchLine."Line Amount";
        UnrecoveredCharges.Amount := PurchLine."Unit Cost";
        UnrecoveredCharges."Amount Including VAT" := PurchLine."Amount Including VAT";
        UnrecoveredCharges."Gen. Bus. Posting Group" := PurchLine."Gen. Bus. Posting Group";
        UnrecoveredCharges."Gen. Prod. Posting Group" := PurchLine."Gen. Prod. Posting Group";
        UnrecoveredCharges."VAT Bus. Posting Group" := PurchLine."VAT Bus. Posting Group";
        UnrecoveredCharges."VAT Prod. Posting Group" := PurchLine."VAT Prod. Posting Group";
        UnrecoveredCharges."Currency Code" := PurchHeader."Currency Code";
        UnrecoveredCharges.Date := PurchHeader."Posting Date";
        UnrecoveredCharges.Recovered := FALSE;
        UnrecoveredCharges.INSERT;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostVendorEntryOnAfterInitNewLine', '', false, false)]
    local procedure OnPostVendorEntryOnAfterInitNewLine(var PurchaseHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    var
        Vendor: Record Vendor;
    begin
        IF Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN //PHILIP
            GenJnlLine."VAT Registration No." := Vendor."VAT Registration No.";//"VAT Registration No.";
    end;
    //Codeunit 90 Purch.-Post<<

    //Codeunit 260 Document-Mailing>>
    PROCEDURE EmailFileFromDailyWeightDistByCustomer(DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer"; AttachmentFilePath: Text[250]);
    VAR
        DocumentType: Text;
        Text001: Label 'ENU=Daily Weight Distribution';
    BEGIN
        DocumentType := Text001;
        EmailFile(AttachmentFilePath,
          DailyWeightDistByCustomer."Daily No.",
          DailyWeightDistByCustomer."Customer No.",
          DailyWeightDistByCustomer."Customer Name",
          DocumentType);
    END;

    LOCAL PROCEDURE EmaiDailyWeightDistByCustomerFile(AttachmentFilePath: Text[250]; PostedDocNo: Code[20]; SendEmaillToNPNo: Code[20]; SendEmaillToNPName: Text[50]; EmailDocName: Text[50]);
    VAR
        TempEmailItem: Record "Email Item" temporary;
        AttachmentFileName: Text[250];
        i: Integer;
        ReportAsPdfFileNameMsg2: Label '@@@="%1 = Document Type %2 = Invoice No.";ENU=Daily Weight Distribution %1 %2.pdf';
        EmailSubjectCapTxt: Label '@@@="%1 = Customer Name. %2 = Document Type %3 = Invoice No.";ENU=%1 - %2 %3';
        EmailScenario: Enum "Email Scenario";
    BEGIN
        AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg2, EmailDocName, PostedDocNo);

        WITH TempEmailItem DO BEGIN
            "Send to" := GetToAddressFromNotifyParty(SendEmaillToNPNo);
            Subject := COPYSTR(
                STRSUBSTNO(
                  EmailSubjectCapTxt, SendEmaillToNPName, EmailDocName, PostedDocNo), 1,
                MAXSTRLEN(Subject));
            "Attachment File Path" := AttachmentFilePath;
            "Attachment Name" := AttachmentFileName;
            Send(FALSE, EmailScenario::Default);
        END;
    END;

    LOCAL PROCEDURE GetToAddressFromNotifyParty(BillToCustomerNo: Code[20]): Text[250];
    VAR
        Customer: Record Customer;
        ToAddress: Text;
        DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer";
    BEGIN
        IF Customer.GET(BillToCustomerNo) THEN
            ToAddress := Customer."E-Mail";

        EXIT(ToAddress);
    END;
    //Codeunit 260 Document-Mailing<<
    //Codeunit 367 CheckManagement>>

    LOCAL PROCEDURE "====FWL===="();
    BEGIN
    END;
    //Codeunit 367 CheckManagement<<


    //Codeunit 439 Approvals Management >>
    PROCEDURE "...PAYMENT VOUCHER APPROVALS..."();
    BEGIN
    END;

    PROCEDURE MakeApprovalEntryPayments(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[20]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
    VAR
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
    BEGIN
        WITH ApprovalEntry DO BEGIN
            SETRANGE("Table ID", TableID);
            SETRANGE("Document Type", DocType);
            SETRANGE("Document No.", DocNo);
            IF FIND('+') THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::"Payment Voucher";
            "Document No." := DocNo;
            //"Salespers./Purch. Code" := SalespersonPurchaser;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := ApprovalCode;
            "Sender ID" := USERID;
            Amount := ApprovalAmount;
            "Amount (LCY)" := ApprovalAmount;
            "Currency Code" := CurrencyCode;
            "Approver ID" := ApproverId;
            IF ApproverId = USERID THEN BEGIN
                Status := Status::Approved
            END ELSE BEGIN
                Status := Status::Created;
            END;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;

    PROCEDURE "...RECEIPT VOUCHER APPROVALS..."();
    BEGIN
    END;

    PROCEDURE MakeApprovalEntryReceipts(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
    VAR
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
    BEGIN
        WITH ApprovalEntry DO BEGIN
            SETRANGE("Table ID", TableID);
            SETRANGE("Document Type", DocType);
            SETRANGE("Document No.", DocNo);
            IF FIND('+') THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::"Receipt Voucher";
            "Document No." := DocNo;
            //"Salespers./Purch. Code" := SalespersonPurchaser;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := ApprovalCode;
            "Sender ID" := USERID;
            Amount := ApprovalAmount;
            "Amount (LCY)" := ApprovalAmount;
            "Currency Code" := CurrencyCode;
            "Approver ID" := ApproverId;
            IF ApproverId = USERID THEN BEGIN
                Status := Status::Approved
            END ELSE BEGIN
                Status := Status::Created;
            END;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;

    LOCAL PROCEDURE "...PURCHASE REQUISITION APPROVALS--"();
    BEGIN
    END;

    PROCEDURE MakeApprovalEntryRequisitions(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
    VAR
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
    BEGIN
        WITH ApprovalEntry DO BEGIN
            SETRANGE("Table ID", TableID);
            SETRANGE("Document Type", DocType);
            SETRANGE("Document No.", DocNo);
            IF FIND('+') THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::"Purchase Requisition";
            "Document No." := DocNo;
            //"Salespers./Purch. Code" := SalespersonPurchaser;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := ApprovalCode;
            "Sender ID" := USERID;
            Amount := ApprovalAmount;
            "Amount (LCY)" := ApprovalAmount;
            "Currency Code" := CurrencyCode;
            "Approver ID" := ApproverId;
            IF ApproverId = USERID THEN BEGIN
                Status := Status::Approved
            END ELSE BEGIN
                Status := Status::Created;
            END;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;

    PROCEDURE "...PETTY CASH VOUCHER APPROVALS..."();
    BEGIN
    END;

    PROCEDURE MakeApprovalEntryPettyCash(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
    VAR
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
    BEGIN
        WITH ApprovalEntry DO BEGIN
            SETRANGE("Table ID", TableID);
            SETRANGE("Document Type", DocType);
            SETRANGE("Document No.", DocNo);
            IF FIND('+') THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::"Petty Cash Voucher";
            "Document No." := DocNo;
            //"Salespers./Purch. Code" := SalespersonPurchaser;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := ApprovalCode;
            "Sender ID" := USERID;
            Amount := ApprovalAmount;
            "Amount (LCY)" := ApprovalAmount;
            "Currency Code" := CurrencyCode;
            "Approver ID" := ApproverId;
            IF ApproverId = USERID THEN BEGIN
                Status := Status::Approved
            END ELSE BEGIN
                Status := Status::Created;
            END;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;

    LOCAL PROCEDURE "...RFP APPROVALS--"();
    BEGIN
    END;

    PROCEDURE MakeApprovalEntryRFPs(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
    VAR
        ApprovalEntry: Record "Approval Entry";
        NewSequenceNo: Integer;
    BEGIN
        WITH ApprovalEntry DO BEGIN
            SETRANGE("Table ID", TableID);
            SETRANGE("Document Type", DocType);
            SETRANGE("Document No.", DocNo);
            IF FIND('+') THEN
                NewSequenceNo := "Sequence No." + 1
            ELSE
                NewSequenceNo := 1;
            "Table ID" := TableID;
            "Document Type" := "Document Type"::"Request for Quotation";
            "Document No." := DocNo;
            //"Salespers./Purch. Code" := SalespersonPurchaser;
            "Sequence No." := NewSequenceNo;
            "Approval Code" := ApprovalCode;
            "Sender ID" := USERID;
            Amount := ApprovalAmount;
            "Amount (LCY)" := ApprovalAmount;
            "Currency Code" := CurrencyCode;
            "Approver ID" := ApproverId;
            IF ApproverId = USERID THEN BEGIN
                Status := Status::Approved
            END ELSE BEGIN
                Status := Status::Created;
            END;
            "Date-Time Sent for Approval" := CREATEDATETIME(TODAY, TIME);
            "Last Date-Time Modified" := CREATEDATETIME(TODAY, TIME);
            "Last Modified By ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;
    //Codeunit 439 Approvals Management <<

    //Codeunit 440 Approvals Mgt Notification>>
    PROCEDURE "....PAYMENT VOUCHER APPROVALS...."();
    BEGIN
    END;

    PROCEDURE "....RECEIPT VOUCHER APPROVALS...."();
    BEGIN
    END;

    PROCEDURE "....PURCHASE REQUISITION APPROVALS...."();
    BEGIN
    END;

    PROCEDURE "....PETTY CASH VOUCHER APPROVALS...."();
    BEGIN
    END;

    PROCEDURE "....RFP APPROVALS...."();
    BEGIN
    END;
    //Codeunit 440 Approvals Mgt Notification<<

    //Codeunit 452 Report Distribution Management>>
    PROCEDURE SendDailyWeightDistributionReport(DailyWeightDistHeader: Record "Dl. Weight Dist. Header"; ReportID: Integer; SendTo: 'Email,Disk')
    VAR
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text;
        DocumentType: Text;
        Text001: Label 'ENU=Daily Weight Distribution';
        ServerSaveAsPdfFailedErr: Label 'ENU=Cannot open the document because it is empty or cannot be created.';
        ServerSaveAsPdfAbortedErr: Label 'ENU=You must select a sales invoice.';
    BEGIN
        ServerAttachmentFilePath := FileManagement.ServerTempFileName('pdf');

        WITH DailyWeightDistHeader DO BEGIN
            SETRECFILTER;
            IF NOT REPORT.SAVEASPDF(ReportID, ServerAttachmentFilePath, DailyWeightDistHeader) THEN
                ERROR(ServerSaveAsPdfFailedErr);

            IF NOT EXISTS(ServerAttachmentFilePath) THEN
                ERROR(ServerSaveAsPdfAbortedErr);

            DocumentType := Text001;
        END;
    END;

    LOCAL PROCEDURE HandleDistDocumentReport(HeaderDoc: Variant; SendTo: 'Email,Disk')
    VAR
        ReportSelections: Record "Report Selections";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        SalesHeaderRecRef: RecordRef;
        DailyWeightDistRecRef: RecordRef;
        DailyWeightDistHeader: Record "Dl. Weight Dist. Header";
        UnSupportedTableTypeErr: Label 'ENU=The table %1 is not supported.';
    BEGIN
        //...GET THE DISTRIBUTION HEADER
        DailyWeightDistRecRef.GETTABLE(HeaderDoc);
        CASE DailyWeightDistRecRef.NUMBER OF
            DATABASE::"Dl. Weight Dist. Header":
                BEGIN
                    DailyWeightDistRecRef.SETTABLE(DailyWeightDistHeader);
                    BEGIN
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Daily Weight Distribution");
                        ReportSelections.FINDFIRST;
                        SendDailyWeightDistributionReport(HeaderDoc, ReportSelections."Report ID", SendTo);
                    END;
                END;
            ELSE
                ERROR(STRSUBSTNO(UnSupportedTableTypeErr, SalesHeaderRecRef.NAME));
        END;
    END;

    //Codeunit 452 Report Distribution Management<<
    var
    Rep:Codeunit "Report Distribution Management";
}
