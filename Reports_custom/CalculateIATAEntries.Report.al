report 50017 "Calculate IATA Entries"
{
    Caption = 'Calculate MAWB Entries';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        ImportExportSetup: Record "50010";
    begin
        IF StartDate = 0D THEN
            ERROR(Text001)
        ELSE
            IF EndDate = 0D THEN
                ERROR(Text002)
            ELSE BEGIN
                MAWBInvoiceCharge.RESET;
                MAWBInvoiceCharge.SETRANGE("Transaction Date", StartDate, EndDate);
                MAWBInvoiceCharge.CALCFIELDS("Freight Cost");
                MAWBInvoiceCharge.SETRANGE("Freight Cost", TRUE);
                IF (IATAPurchaseInvoice.Reconciled = FALSE AND IATAPurchaseInvoice.Converted = FALSE) THEN BEGIN
                    MAWBInvoiceCharge.SETRANGE("MAWB No.", IATAPurchaseInvoice."MAWB No.");
                END;
                IF MAWBInvoiceCharge.FINDSET THEN BEGIN
                    REPEAT
                        SalesInvoiceHeader.RESET;
                        SalesInvoiceHeader.SETRANGE("External Document No.", MAWBInvoiceCharge."MAWB No.");
                        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                            MAWBLine.RESET;
                            MAWBLine.SETRANGE("MAWB No.", SalesInvoiceHeader."External Document No.");
                            MAWBLine.CALCSUMS("Chargeable Weight");
                            MAWBLine.SETFILTER("Chargeable Weight", '<>%1', 0);
                            //IATAPurchaseInvoice."MAWB No.":=MAWBInvoiceCharge."MAWB No.";
                            //IATAPurchaseInvoice."Line No.":=IATAPurchaseInvoice."Line No."+10000;
                            IATAPurchaseInvoice.RESET;
                            IATAPurchaseInvoice.SETRANGE("MAWB No.", MAWBInvoiceCharge."MAWB No.");
                            IF IATAPurchaseInvoice.FIND('-') THEN BEGIN
                                IATAPurchaseInvoice."Weight As Per FWL" := MAWBLine."Chargeable Weight";
                                IATAPurchaseInvoice."Amount As Per FWL" := MAWBInvoiceCharge."Cost Amount";
                                IATAPurchaseInvoice."Rate Per Kilo As Per FWL" := MAWBInvoiceCharge."Cost Amount" / MAWBLine."Chargeable Weight";

                                /* SalesInvoiceHeader.SalesInvoiceHeader.SalesInvoiceHeader.:=0;
                                 IATAPurchaseInvoice."Amount As Per IATA":=0;
                                 IATAPurchaseInvoice."Rate Per Kilo As Per IATA":=0;
                                 IATAPurchaseInvoice."IATA Invoice Date":=0D;
                                 IATAPurchaseInvoice."IATA Invoice No.":=''; */

                                IF MAWBLine.FINDFIRST THEN
                                    IATAPurchaseInvoice."Airline Code" := MAWBLine."Airline Code";

                                ImportExportSetup.GET;
                                IATAPurchaseInvoice."Vendor No." := ImportExportSetup."Default Vendor Code";
                                IATAPurchaseInvoice."Vendor Name" := ImportExportSetup."Default Vendor Name";
                                IATAPurchaseInvoice."Billing Start Date" := StartDate;
                                IATAPurchaseInvoice."Billing End Date" := EndDate;

                                //MAWBInvoiceCharge.CALCFIELDS("Purchase A/C Code");
                                Customer.GET(MAWBLine."Shipper Code");
                                ImportExportSetup.GET();
                                IF Customer."Customer Type" = Customer."Customer Type"::Group THEN BEGIN
                                    IATAPurchaseInvoice."Purchase A/C Code" := ImportExportSetup."Group Purchase A/C Code";
                                END ELSE BEGIN
                                    IATAPurchaseInvoice."Purchase A/C Code" := ImportExportSetup."Third Party Purchase A/C Code";
                                END;
                                IATAPurchaseInvoice."Difference in Weight" := IATAPurchaseInvoice."Weight As Per FWL" - IATAPurchaseInvoice."Weight as per Airline";
                                IATAPurchaseInvoice."Rate Difference" := IATAPurchaseInvoice."Rate Per Kilo As Per FWL" - IATAPurchaseInvoice."Airline Kilo Rate";
                                IATAPurchaseInvoice."Difference In Amount" := IATAPurchaseInvoice."Amount As Per FWL" - IATAPurchaseInvoice."Amount as per Airline";
                                IATAPurchaseInvoice.Converted := FALSE;
                                IATAPurchaseInvoice.Reconciled := TRUE;
                                IATAPurchaseInvoice.Comments := '';

                                //IATAPurchaseInvoice.INSERT;
                                IATAPurchaseInvoice.MODIFY;
                            END;
                        END;
                    UNTIL MAWBInvoiceCharge.NEXT = 0;
                END;
            END;

    end;

    var
        Text001: Label 'Start Date cannot be blank';
        StartDate: Date;
        EndDate: Date;
        MAWBInvoiceCharge: Record "50073";
        IATAPurchaseInvoice: Record "50016";
        Text002: Label 'End Date cannot be blank';
        SalesInvoiceHeader: Record "112";
        SalesInvoiceLine: Record "113";
        MAWBLine: Record "50076";
        Customer: Record "18";
        ImportExportSetup: Record "50010";
}

