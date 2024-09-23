page 50148 "Converted IATA Purchase Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = Table50016;
    SourceTableView = WHERE (Converted = CONST (Yes));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Airline Code"; "Airline Code")
                {
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Vendor Name"; "Vendor Name")
                {
                }
                field("Purchase A/C Code"; "Purchase A/C Code")
                {
                }
                field("Weight As Per FWL"; "Weight As Per FWL")
                {
                }
                field("Amount As Per FWL"; "Amount As Per FWL")
                {
                }
                field("Rate Per Kilo As Per FWL"; "Rate Per Kilo As Per FWL")
                {
                }
                field("Airline Invoice No"; "Airline Invoice No")
                {
                }
                field("Airline Invoice Date"; "Airline Invoice Date")
                {
                }
                field("Weight as per Airline"; "Weight as per Airline")
                {
                }
                field("Amount as per Airline"; "Amount as per Airline")
                {
                }
                field("Airline Kilo Rate"; "Airline Kilo Rate")
                {
                }
                field("Difference in Weight"; "Difference in Weight")
                {
                }
                field("Rate Difference"; "Rate Difference")
                {
                }
                field("Difference In Amount"; "Difference In Amount")
                {
                }
                field(Comments; Comments)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Recalculate)
            {

                trigger OnAction()
                begin
                    Window.OPEN('Validating IATA Entries \Airline Code #1### \MAWB No. #2###');
                    IATAPurchaseInvoice.RESET;
                    ImportExportSetup.GET();
                    IATAPurchaseInvoice.SETRANGE(IATAPurchaseInvoice."Amount As Per FWL", 0);
                    //IATAPurchaseInvoice.SETRANGE(IATAPurchaseInvoice.Reconciled,FALSE);
                    IF IATAPurchaseInvoice.FINDSET THEN BEGIN
                        REPEAT
                            Window.UPDATE(1, IATAPurchaseInvoice."Airline Code");
                            Window.UPDATE(2, IATAPurchaseInvoice."MAWB No.");
                            IATAPurchaseInvoice."Amount As Per FWL" := GetTotalCharge(IATAPurchaseInvoice."MAWB No.");
                            IF IATAPurchaseInvoice."Weight as per Airline" > 0 THEN BEGIN
                                IATAPurchaseInvoice."Airline Kilo Rate" := IATAPurchaseInvoice."Amount as per Airline" / IATAPurchaseInvoice."Weight as per Airline";
                            END;
                            IATAPurchaseInvoice."Weight As Per FWL" := GetTotalWeight(IATAPurchaseInvoice."MAWB No.");
                            IF IATAPurchaseInvoice."Weight As Per FWL" <> 0 THEN BEGIN
                                IATAPurchaseInvoice."Rate Per Kilo As Per FWL" := IATAPurchaseInvoice."Amount As Per FWL" / IATAPurchaseInvoice."Weight As Per FWL";
                            END;
                            IATAPurchaseInvoice."Difference in Weight" := IATAPurchaseInvoice."Weight As Per FWL" - IATAPurchaseInvoice."Weight as per Airline";
                            IATAPurchaseInvoice."Difference In Amount" := IATAPurchaseInvoice."Amount As Per FWL" - IATAPurchaseInvoice."Amount as per Airline";
                            IATAPurchaseInvoice."Rate Difference" := IATAPurchaseInvoice."Rate Per Kilo As Per FWL" - IATAPurchaseInvoice."Airline Kilo Rate";
                            IATAPurchaseInvoice.VALIDATE(IATAPurchaseInvoice."Vendor No.", ImportExportSetup."Default IATA Vendor");
                            IATAPurchaseInvoice.VALIDATE(IATAPurchaseInvoice."Airline Code");
                            IATAPurchaseInvoice."Purchase A/C Code" := ImportExportSetup."IATA Purchase Acc.Group";
                            //IF IATAPurchaseInvoice."Amount As Per FWL"<>0 THEN
                            IATAPurchaseInvoice.Reconciled := TRUE;
                            IATAPurchaseInvoice."Processed By" := USERID;
                            IATAPurchaseInvoice."Processed On" := TODAY;
                            IATAPurchaseInvoice."Purchase A/C Code" := GetPurchaseAcc(IATAPurchaseInvoice."MAWB No.");
                            IATAPurchaseInvoice.MODIFY;
                            SLEEP(100);
                        UNTIL IATAPurchaseInvoice.NEXT = 0;
                    END;
                    Window.CLOSE;
                end;
            }
        }
    }

    var
        IATAPurchaseInvoice: Record "50016";
        Text001: Label 'Do you wish to convert the lines  into  Purchase Invoices?';
        Text002: Label 'The Lines have been converted into purchase invoices successfully';
        Window: Dialog;
        ImportExportSetup: Record "50010";
        AmmendCharges: Codeunit "50031";

    local procedure GetTotalCharge("MAWB no": Code[50]) TotalCharge: Decimal
    var
        MawbInvoiceCharge: Record "50073";
    begin
        MawbInvoiceCharge.RESET;
        MawbInvoiceCharge.SETRANGE(MawbInvoiceCharge."MAWB No.", "MAWB no");
        IF MawbInvoiceCharge.FINDSET THEN BEGIN
            TotalCharge := 0;
            REPEAT
                TotalCharge += MawbInvoiceCharge."Base Unit Price";
            UNTIL MawbInvoiceCharge.NEXT = 0;
        END;
        EXIT(TotalCharge);
    end;

    local procedure GetTotalWeight("MAWB No": Code[50]) TotalWeight: Decimal
    var
        LoadingSheet: Record "50060";
        LoadingSheetLine: Record "50061";
        MawbInvoiceCharge: Record "50073";
    begin
        /*AmmendCharges.ClearCalculatedCharges("MAWB no");
        AmmendCharges.CalculateMAWBCharges("MAWB no");
        AmmendCharges.CalculateHandlingFees("MAWB no"); */
        MawbInvoiceCharge.RESET;
        MawbInvoiceCharge.SETRANGE(MawbInvoiceCharge."MAWB No.", "MAWB No");
        MawbInvoiceCharge.SETFILTER(MawbInvoiceCharge."Chargeable Weight", '<>%1', 0);
        IF MawbInvoiceCharge.FINDFIRST THEN BEGIN
            TotalWeight += MawbInvoiceCharge."Chargeable Weight";
        END;
        EXIT(TotalWeight);

    end;

    local procedure GetPurchaseAcc(MAWB: Code[50]) AccNo: Code[50]
    var
        BookingSheetMawb: Record "50070";
        Cust: Record "18";
    begin
        BookingSheetMawb.RESET;
        BookingSheetMawb.SETRANGE(BookingSheetMawb."MAWB No", MAWB);
        IF BookingSheetMawb.FINDFIRST THEN BEGIN
            ImportExportSetup.GET();
            Cust.GET(BookingSheetMawb."Shipper Code");
            IF Cust."Customer Type" = Cust."Customer Type"::Group THEN BEGIN
                AccNo := ImportExportSetup."IATA Purchase Acc.Group";
            END
            ELSE BEGIN
                AccNo := ImportExportSetup."IATA Purchase Acc.TP";
            END;
        END;
        EXIT(AccNo);
    end;
}

