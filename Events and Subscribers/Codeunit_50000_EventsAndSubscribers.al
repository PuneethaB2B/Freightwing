codeunit 50000 "Events And Subscribers"
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]

    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; WhseShip: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; InvtPickPutaway: Boolean)
    begin
        SalesInvHeader.Commodity := SalesHeader.Commodity;
        SalesInvHeader."Total Weight" := SalesHeader."Total Weight";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostGLAndCustomer', '', false, false)]
    local procedure OnAfterPostGLAndCustomer(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; TotalSalesLine: Record "Sales Line"; TotalSalesLineLCY: Record "Sales Line"; CommitIsSuppressed: Boolean;
            WhseShptHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var SalesInvHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
            var CustLedgEntry: Record "Cust. Ledger Entry"; var SrcCode: Code[10]; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; var GenJnlLineDocType: Enum "Gen. Journal Document Type"; PreviewMode: Boolean; DropShipOrder: Boolean)
    begin
        IF SalesHeader.Invoice THEN BEGIN
            //TIMSManager.ProcessSalesDocument(SalesInvHeader);
        END;
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforePostPurchLine', '', false, false)]
    local procedure OnRunOnBeforePostPurchLine(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
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

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
        Vendor: Record Vendor;
    begin
        IF Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN //PHILIP
            GenJournalLine."VAT Registration No." := Vendor."VAT Registration No.";//"VAT Registration No.";
    end;
    //Codeunit 90 Purch.-Post<<

    //Codeunit 260 Document-Mailing>>
    PROCEDURE EmailFileFromDailyWeightDistByCustomer(DailyWeightDistByCustomer: Record "Dl. Weight Dist. By Customer"; AttachmentFilePath: Text[250]);
    VAR
        DocumentType: Text;
        Text001: Label 'Daily Weight Distribution';
        Doc: Codeunit "Document-Mailing";
    BEGIN
        /*  DocumentType := Text001;
         Doc.EmailFile(AttachmentFilePath,
           DailyWeightDistByCustomer."Daily No.",
           DailyWeightDistByCustomer."Customer No.",
           DailyWeightDistByCustomer."Customer Name",
           DocumentType); */ //B2BUPG //commented Due to No function found in higher version and also there are 0 referencse to this procedure
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

    /* PROCEDURE MakeApprovalEntryPayments(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[20]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
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
            "Last Modified By User ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END;
 */ //B2BUPG No Approvalsetup table in higher version and this procedure has 0 references 
    PROCEDURE "...RECEIPT VOUCHER APPROVALS..."();
    BEGIN
    END;

    /* PROCEDURE MakeApprovalEntryReceipts(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
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
            "Last Modified By User ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END; */ //B2BUPG No Approvalsetup  and approval template tables in higher version and this procedure has 0 references

    LOCAL PROCEDURE "...PURCHASE REQUISITION APPROVALS--"();
    BEGIN
    END;

    /*  PROCEDURE MakeApprovalEntryRequisitions(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
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
             "Last Modified By User ID" := USERID;
             "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
             "Approval Type" := AppTemplate."Approval Type";
             "Limit Type" := AppTemplate."Limit Type";
             //"Available Credit Limit (LCY)" := ExeedAmountLCY;
             INSERT;
         END;
     END; */ //B2BUPG No Approvalsetup  and approval template tables in higher version and this procedure has 0 references

    PROCEDURE "...PETTY CASH VOUCHER APPROVALS..."();
    BEGIN
    END;

    /* PROCEDURE MakeApprovalEntryPettyCash(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
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
            "Last Modified By User ID" := USERID;
            "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
            "Approval Type" := AppTemplate."Approval Type";
            "Limit Type" := AppTemplate."Limit Type";
            //"Available Credit Limit (LCY)" := ExeedAmountLCY;
            INSERT;
        END;
    END; */ //B2BUPG No Approvalsetup  and approval template tables in higher version and this procedure has 0 references

    LOCAL PROCEDURE "...RFP APPROVALS--"();
    BEGIN
    END;

    /*  PROCEDURE MakeApprovalEntryRFPs(TableID: Integer; DocType: Integer; DocNo: Code[20]; ApprovalSetup: Record 452; ApproverId: Code[30]; ApprovalCode: Code[30]; UserSetup: Record "User Setup"; ApprovalAmount: Decimal; CurrencyCode: Code[10]; AppTemplate: Record 464);
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
             "Last Modified By User ID" := USERID;
             "Due Date" := CALCDATE(ApprovalSetup."Due Date Formula", TODAY);
             "Approval Type" := AppTemplate."Approval Type";
             "Limit Type" := AppTemplate."Limit Type";
             //"Available Credit Limit (LCY)" := ExeedAmountLCY;
             INSERT;
         END;
     END; */ //B2BUPG No Approvalsetup  and approval template tables in higher version and this procedure has 0 references
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
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Report Distribution Management", 'OnAfterGetFullDocumentTypeText', '', false, false)]
    local procedure OnAfterGetFullDocumentTypeText(DocumentVariant: Variant; var DocumentTypeText: Text[50]; var DocumentRecordRef: RecordRef)
    var
        DailyWeightDistRecRef: RecordRef;
        DailyWeightDistHeader: Record 50040;
        ReportSelections: Record 77;
        SendTo: option Email,Disk;
        SalesHeaderRecRef: RecordRef;
        UnSupportedTableTypeErr: Label 'The table %1 is not supported.';
    begin
        //...GET THE DISTRIBUTION HEADER
        DailyWeightDistRecRef.GETTABLE(DocumentVariant);
        CASE DailyWeightDistRecRef.NUMBER OF
            DATABASE::"Dl. Weight Dist. Header":
                BEGIN
                    DailyWeightDistRecRef.SETTABLE(DailyWeightDistHeader);
                    BEGIN
                        ReportSelections.SETRANGE(Usage, ReportSelections.Usage::"Daily Weight Distribution");
                        ReportSelections.FINDFIRST;
                        SendDailyWeightDistributionReport(DocumentVariant, ReportSelections."Report ID", SendTo);
                    END;
                END;
            ELSE
                ERROR(STRSUBSTNO(UnSupportedTableTypeErr, SalesHeaderRecRef.NAME));
        END;
    end;

    PROCEDURE SendDailyWeightDistributionReport(DailyWeightDistHeader: Record "Dl. Weight Dist. Header"; ReportID: Integer; SendTo: option Email,Disk)
    VAR
        FileManagement: Codeunit "File Management";
        ServerAttachmentFilePath: Text;
        DocumentType: Text;
        Text001: Label 'Daily Weight Distribution';
        ServerSaveAsPdfFailedErr: Label 'Cannot open the document because it is empty or cannot be created.';
        ServerSaveAsPdfAbortedErr: Label 'You must select a sales invoice.';
        AttachmentTempBlob: Codeunit "Temp Blob";
        AttchmentOutStream: OutStream;
        RecordrefVar: RecordRef;
        AttcahmentInstream: InStream;
    BEGIN
        //ServerAttachmentFilePath := FileManagement.ServerTempFileName('pdf');

        WITH DailyWeightDistHeader DO BEGIN
            SETRECFILTER;
            AttachmentTempBlob.CreateOutStream(AttchmentOutStream, TextEncoding::UTF8);
            RecordrefVar.GetTable(DailyWeightDistHeader);
            Report.SaveAs(ReportId, '', ReportFormat::Pdf, AttchmentOutStream, RecordrefVar);
            AttachmentTempBlob.CreateInStream(AttcahmentInstream);
            IF NOT REPORT.SAVEAS(ReportID, '', ReportFormat::Pdf, AttchmentOutStream, RecordrefVar) THEN
                ERROR(ServerSaveAsPdfFailedErr);

            /* 
            WITH DailyWeightDistHeader DO BEGIN
                SETRECFILTER;
                IF NOT REPORT.SAVEASPDF(ReportID, ServerAttachmentFilePath, DailyWeightDistHeader) THEN
                    ERROR(ServerSaveAsPdfFailedErr);

            IF NOT EXISTS(ServerAttachmentFilePath) THEN
                ERROR(ServerSaveAsPdfAbortedErr); */ //B2BUPG this was handled above using streams

            DocumentType := Text001;
        END;
    END;

    LOCAL PROCEDURE HandleDistDocumentReport(HeaderDoc: Variant; SendTo: Option Email,Disk)
    VAR
        ReportSelections: Record "Report Selections";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        SalesHeaderRecRef: RecordRef;
        DailyWeightDistRecRef: RecordRef;
        DailyWeightDistHeader: Record "Dl. Weight Dist. Header";
        UnSupportedTableTypeErr: Label 'The table %1 is not supported.';
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

}

