page 50149 "IATA Purchase Invoices"
{
    AutoSplitKey = true;
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = 50016;
    SourceTableView = WHERE(Converted = FILTER(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Airline Invoice Date"; Rec."Airline Invoice Date")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Weight As Per FWL"; Rec."Weight As Per FWL")
                {
                }
                field("Amount As Per FWL"; Rec."Amount As Per FWL")
                {
                }
                field("Rate Per Kilo As Per FWL"; Rec."Rate Per Kilo As Per FWL")
                {
                }
                field("Airline Invoice No"; Rec."Airline Invoice No")
                {
                }
                field("Weight as per Airline"; Rec."Weight as per Airline")
                {
                }
                field("Amount as per Airline"; Rec."Amount as per Airline")
                {
                }
                field("Airline Kilo Rate"; Rec."Airline Kilo Rate")
                {
                }
                field("Difference in Weight"; Rec."Difference in Weight")
                {
                }
                field("Rate Difference"; Rec."Rate Difference")
                {
                }
                field("Difference In Amount"; Rec."Difference In Amount")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Reconciled; Rec.Reconciled)
                {
                }
                field(Converted; Rec.Converted)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(HAWB)
            {
                Caption = 'HAWB';
                Image = Print;
                action("&Calculate   Entries")
                {
                    Caption = '&Calculate   Entries';
                    Image = CreateSerialNo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Window.OPEN('Validating IATA Entries \Airline Code #1### \MAWB No. #2###');
                        IATAPurchaseInvoice.RESET;
                        ImportExportSetup.GET();
                        IATAPurchaseInvoice.SETRANGE(IATAPurchaseInvoice.Converted, FALSE);
                        IF IATAPurchaseInvoice.FINDSET THEN BEGIN
                            REPEAT
                                ok := Airlines.GET(Rec."Airline Code");
                                //  ok:=AirlineGroups.GET(Airlines."Default Vendor No");
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
                                //I//ATAPurchaseInvoice.VALIDATE(IATAPurchaseInvoice."Vendor No.",AirlineGroups."Default Vendor");
                                IATAPurchaseInvoice.VALIDATE(IATAPurchaseInvoice."Airline Code");
                                IATAPurchaseInvoice."Purchase A/C Code" := ImportExportSetup."IATA Purchase Acc.Group";
                                //IF IATAPurchaseInvoice."Amount As Per FWL"<>0 THEN
                                IATAPurchaseInvoice.Reconciled := TRUE;
                                IATAPurchaseInvoice."Processed By" := USERID;
                                IATAPurchaseInvoice."Processed On" := TODAY;
                                IATAPurchaseInvoice."Purchase A/C Code" := GetPurchaseAcc(IATAPurchaseInvoice."MAWB No.");
                                //Invoice Daates
                                IF ((IATAPurchaseInvoice."Airline Invoice Date" = 0D) AND (IATAPurchaseInvoice."Invoice Date" <> 0D)) THEN
                                    IATAPurchaseInvoice."Airline Invoice Date" := IATAPurchaseInvoice."Invoice Date"
                                ELSE
                                    IF ((IATAPurchaseInvoice."Airline Invoice Date" <> 0D) AND (IATAPurchaseInvoice."Invoice Date" = 0D)) THEN
                                        IATAPurchaseInvoice."Invoice Date" := IATAPurchaseInvoice."Airline Invoice Date";
                                //Invoice Dates
                                IATAPurchaseInvoice.MODIFY;
                                SLEEP(100);
                            UNTIL IATAPurchaseInvoice.NEXT = 0;
                        END;

                        IATAPurchaseInvoice.RESET;
                        IATAPurchaseInvoice.SETRANGE(IATAPurchaseInvoice."Airline Code", '');
                        IATAPurchaseInvoice.SETRANGE(IATAPurchaseInvoice.Converted, FALSE);
                        IF IATAPurchaseInvoice.FIND('-') THEN BEGIN
                            IATAPurchaseInvoice.DELETEALL;
                        END;
                        Window.CLOSE;
                    end;
                }
                action("Make Purchase Invoice")
                {
                    Caption = 'Make Purchase Invoice';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    begin
                        IF CONFIRM(Text001, FALSE) THEN BEGIN
                            Rec.ConvertIATATempToPurchInvoice(IATAPurchaseInvoice);
                        END;
                    end;
                }
                action("Reconciliation Report")
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report 50032;
                }
                action("Delete Line")
                {
                    Image = Delete;

                    trigger OnAction()
                    begin
                        Rec.DELETE;
                    end;
                }
            }
        }
    }

    var
        IATAPurchaseInvoice: Record 50016;
        Text001: Label 'Do you wish to convert the lines  into  Purchase Invoices?';
        Text002: Label 'The Lines have been converted into purchase invoices successfully';
        ImportExportSetup: Record 50010;
        Window: Dialog;
        AmmendCharges: Codeunit 50031;
        Airlines: Record 50021;
        ok: Boolean;

    local procedure GetTotalCharge("MAWB no": Code[50]) TotalCharge: Decimal
    var
        MawbInvoiceCharge: Record 50073;
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
        LoadingSheet: Record 50060;
        LoadingSheetLine: Record 50061;
        MawbInvoiceCharge: Record 50073;
    begin
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
        BookingSheetMawb: Record 50070;
        Cust: Record 18;
    begin
        BookingSheetMawb.RESET;
        BookingSheetMawb.SETRANGE(BookingSheetMawb."MAWB No", MAWB);
        IF BookingSheetMawb.FINDFIRST THEN BEGIN
            ImportExportSetup.GET();
            ok := Cust.GET(BookingSheetMawb."Shipper Code");
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

