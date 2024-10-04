codeunit 50013 "Export Document-Mailing"
{

    trigger OnRun()
    begin
    end;

    var
        EmailSubjectCapTxt: Label '%1 - %2', Comment = '%1 = Customer Name. %2 = Document Type %3 = Invoice No.';
        i: Integer;
        ReportAsPdfFileNameMsg: Label '%1-%2.pdf', Comment = '%1 = Document Type %2 = Invoice No.';


    procedure EmailFileFromDailyWeightDistByCustomer(DailyWeightDistByCustomer: Record 50042; AttachmentFilePath: Text[250])
    var
        DocumentType: Text;
        Text001: Label 'Daily Weight Distribution';
    begin
        DocumentType := Text001;
        EmailDailyWeightDistByCustomerFile(AttachmentFilePath,
         DailyWeightDistByCustomer."Customer No.",
         DailyWeightDistByCustomer."Customer Name",
         DocumentType
         );
    end;

    local procedure EmailDailyWeightDistByCustomerFile(AttachmentFilePath: Text[250]; SendEmaillToCustNo: Code[20]; SendEmaillToCustName: Text[50]; EmailDocName: Text[50])
    var
        TempEmailItem: Record 9500 temporary;
        AttachmentFileName: Text[250];
        EmailScenario: Enum "Email Scenario";
    begin
        AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg, SendEmaillToCustNo, EmailDocName);

        TempEmailItem."Send to" := GetToAddressFromDailyWeightDistByCustomer(SendEmaillToCustNo);
        TempEmailItem.Subject := COPYSTR(
            STRSUBSTNO(
              EmailSubjectCapTxt, SendEmaillToCustName, EmailDocName), 1,
            MAXSTRLEN(TempEmailItem.Subject));
        TempEmailItem."Attachment File Path" := AttachmentFilePath;
        TempEmailItem."Attachment Name" := AttachmentFileName;
        TempEmailItem.Send(FALSE, EmailScenario);
    end;

    local procedure GetToAddressFromDailyWeightDistByCustomer(BillToCustomerNo: Code[20]): Text[250]
    var
        Customer: Record 18;
        ToAddress: Text;
        DailyWeightDistByCustomer: Record 50042;
    begin
        IF Customer.GET(BillToCustomerNo) THEN
            ToAddress := Customer."E-Mail";

        EXIT(ToAddress);
    end;

    local procedure "-------------------------------------------------------------------"()
    begin
    end;


    procedure EmailFileFromBookingSheetNotifyParty(BookingSheetNotifyParty: Record 50057; AttachmentFilePath: Text[250])
    var
        DocumentType: Text;
        Text001: Label 'Booking Sheet';
    begin
        DocumentType := Text001;
        EmailBookingSheetNotifyPartyFile(AttachmentFilePath,
         BookingSheetNotifyParty."Notify-Party No.",
         BookingSheetNotifyParty."Notify-Party Name",
         DocumentType
         );
    end;

    local procedure EmailBookingSheetNotifyPartyFile(AttachmentFilePath: Text[250]; SendEmaillToNPNo: Code[20]; SendEmaillToNPName: Text[50]; EmailDocName: Text[50])
    var
        TempEmailItem: Record 9500 temporary;
        AttachmentFileName: Text[250];
        EmailScenario: Enum "Email Scenario";
    begin
        AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg, SendEmaillToNPNo, EmailDocName);

        TempEmailItem."Send to" := GetToAddressFromBookingSheetNotifyParty(SendEmaillToNPNo);
        TempEmailItem.Subject := COPYSTR(
            STRSUBSTNO(
              EmailSubjectCapTxt, SendEmaillToNPName, EmailDocName), 1,
            MAXSTRLEN(TempEmailItem.Subject));
        TempEmailItem."Attachment File Path" := AttachmentFilePath;
        TempEmailItem."Attachment Name" := AttachmentFileName;
        TempEmailItem.Send(FALSE, EmailScenario);
    end;

    local procedure GetToAddressFromBookingSheetNotifyParty(NotifyPartyNo: Code[20]): Text[250]
    var
        NotifyParty: Record 50017;
        ToAddress: Text;
        BookingSheetNotifyParty: Record 50057;
    begin
        IF NotifyParty.GET(NotifyPartyNo) THEN
            ToAddress := NotifyParty."E-Mail";
        EXIT(ToAddress);
    end;

    local procedure "----------------------------------------------------------------------"()
    begin
    end;


    procedure EmailFileFromGoodReceiptNotifyParty(GoodReceiptNotifyParty: Record 50049; AttachmentFilePath: Text[250])
    var
        DocumentType: Text;
        Text001: Label 'Goods Receipt Note';
    begin
        DocumentType := Text001;
        EmailBookingSheetNotifyPartyFile(AttachmentFilePath,
         GoodReceiptNotifyParty."Notify-Party No.",
         GoodReceiptNotifyParty."Notify-Party Name",
         DocumentType
         );
    end;

    local procedure EmailGoodReceiptNotifyPartyFile(AttachmentFilePath: Text[250]; SendEmaillToNPNo: Code[20]; SendEmaillToNPName: Text[50]; EmailDocName: Text[50])
    var
        TempEmailItem: Record 9500 temporary;
        AttachmentFileName: Text[250];
        EmailScenario: Enum "Email Scenario";
    begin
        AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg, SendEmaillToNPNo, EmailDocName);

        TempEmailItem."Send to" := GetToAddressFromGoodReceiptNotifyParty(SendEmaillToNPNo);
        TempEmailItem.Subject := COPYSTR(
            STRSUBSTNO(
              EmailSubjectCapTxt, SendEmaillToNPName, EmailDocName), 1,
            MAXSTRLEN(TempEmailItem.Subject));
        TempEmailItem."Attachment File Path" := AttachmentFilePath;
        TempEmailItem."Attachment Name" := AttachmentFileName;
        TempEmailItem.Send(FALSE, EmailScenario);
    end;

    local procedure GetToAddressFromGoodReceiptNotifyParty(NotifyPartyNo: Code[20]): Text[250]
    var
        NotifyParty: Record 50017;
        ToAddress: Text;
        BookingSheetNotifyParty: Record 50057;
    begin
        IF NotifyParty.GET(NotifyPartyNo) THEN
            ToAddress := NotifyParty."E-Mail";
        EXIT(ToAddress);
    end;

    local procedure "------------------------------------------------------------------------"()
    begin
    end;


    procedure EmailFileFromMAWBInvoiceNotifyParty(MAWBInvoiceNotifyParty: Record 50072; AttachmentFilePath: Text[250])
    var
        DocumentType: Text;
        Text001: Label 'MAWB Invoice';
    begin
        DocumentType := Text001;
        EmailMAWBInvoiceNotifyPartyFile(AttachmentFilePath,
         MAWBInvoiceNotifyParty."Notify-Party No.",
         MAWBInvoiceNotifyParty."Notify-Party Name",
         DocumentType
         );
    end;

    local procedure EmailMAWBInvoiceNotifyPartyFile(AttachmentFilePath: Text[250]; SendEmaillToNPNo: Code[20]; SendEmaillToNPName: Text[50]; EmailDocName: Text[50])
    var
        TempEmailItem: Record 9500 temporary;
        AttachmentFileName: Text[250];
        EmailScenario: Enum "Email Scenario";
    begin
        AttachmentFileName := STRSUBSTNO(ReportAsPdfFileNameMsg, SendEmaillToNPNo, EmailDocName);

        TempEmailItem."Send to" := GetToAddressFromMAWBInvoiceNotifyParty(SendEmaillToNPNo);
        TempEmailItem.Subject := COPYSTR(
            STRSUBSTNO(
              EmailSubjectCapTxt, SendEmaillToNPName, EmailDocName), 1,
            MAXSTRLEN(TempEmailItem.Subject));
        TempEmailItem."Attachment File Path" := AttachmentFilePath;
        TempEmailItem."Attachment Name" := AttachmentFileName;
        TempEmailItem.Send(FALSE, EmailScenario);
    end;

    local procedure GetToAddressFromMAWBInvoiceNotifyParty(NotifyPartyNo: Code[20]): Text[250]
    var
        NotifyParty: Record 50017;
        ToAddress: Text;
        MAWBInvoiceNotifyParty: Record 50072;
    begin
        IF NotifyParty.GET(NotifyPartyNo) THEN
            ToAddress := NotifyParty."E-Mail";
        EXIT(ToAddress);
    end;
}

