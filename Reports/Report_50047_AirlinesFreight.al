report 50047 "Airlines Freight"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/AirlinesFreight.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {
            RequestFilterHeading = 'Airline Filter';
            column(InvoiceCurr; Setup."Invoicing Currency Code")
            {
            }
            column(AirlineCode_MAWBReceipt; "MAWB Receipt"."Airline Code")
            {
            }
            column(MAWBNo_MAWBReceipt; "MAWB Receipt"."MAWB No.")
            {
            }
            column(ReceiptDate_MAWBReceipt; "MAWB Receipt"."Receipt Date")
            {
            }
            column(MAWBFees_MAWBReceipt; "MAWB Receipt"."MAWB Fees")
            {
            }
            column(Assigned_MAWBReceipt; "MAWB Receipt".Assigned)
            {
            }
            column(FreightChargeCode_MAWBReceipt; "MAWB Receipt"."Freight Charge Code")
            {
            }
            column(Prepared_MAWBReceipt; "MAWB Receipt".Prepared)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(PostalCode; CompanyInfo."Post Code")
            {
            }
            dataitem("Loading Sheet Line"; "Loading Sheet Line")
            {
                DataItemLink = "Airline Code" = FIELD("Airline Code"),
                               "MAWB No." = FIELD("MAWB No.");
                DataItemTableView = SORTING("Loading Sheet No.", "MAWB No.", "Division/Farm Code", "Destination Code", "Line No.", "Consignee Code")
                                    ORDER(Ascending);
                column(ItemNo_LoadingSheetLine; "Loading Sheet Line"."Item No.")
                {
                }
                column(Description_LoadingSheetLine; "Loading Sheet Line".Description)
                {
                }
                column(AirlineCode_LoadingSheetLine; "Loading Sheet Line"."Airline Code")
                {
                }
                column(MAWBNo_LoadingSheetLine; "Loading Sheet Line"."MAWB No.")
                {
                }
                dataitem("MAWB Invoice Charge"; "MAWB Invoice Charge")
                {
                    DataItemLink = "MAWB No."=FIELD("MAWB No.");
                    DataItemTableView = SORTING("MAWB No.", "Item No.", "Freight Charge Code", "Line No.")
                                        ORDER(Ascending);
                    column(InvoiceNo_MAWBInvoiceCharge; "MAWB Invoice Charge"."Invoice No.")
                    {
                    }
                    column(ItemNo_MAWBInvoiceCharge; "MAWB Invoice Charge"."Item No.")
                    {
                    }
                    column(Description_MAWBInvoiceCharge; "MAWB Invoice Charge".Description)
                    {
                    }
                    column(FreightChargeCode_MAWBInvoiceCharge; "MAWB Invoice Charge"."Freight Charge Code")
                    {
                    }
                    column(UnitOfMeasure_MAWBInvoiceCharge; "MAWB Invoice Charge"."Unit Of Measure")
                    {
                    }
                    column(BaseUnitPrice_MAWBInvoiceCharge; "MAWB Invoice Charge"."Base Unit Price")
                    {
                    }
                    column(CostAmount_MAWBInvoiceCharge; "MAWB Invoice Charge"."Cost Amount")
                    {
                    }
                    column(SalesAmountExVAT_MAWBInvoiceCharge; "MAWB Invoice Charge"."Sales Amount Ex. VAT")
                    {
                    }
                    column(MAWBNo_MAWBInvoiceCharge; "MAWB Invoice Charge"."MAWB No.")
                    {
                    }
                    column(VATAmount_MAWBInvoiceCharge; "MAWB Invoice Charge"."VAT Amount")
                    {
                    }
                    column(LineNo_MAWBInvoiceCharge; "MAWB Invoice Charge"."Line No.")
                    {
                    }
                    column(CurrencyCode_MAWBInvoiceCharge; "MAWB Invoice Charge"."Currency Code")
                    {
                    }
                    column(Margin_MAWBInvoiceCharge; "MAWB Invoice Charge"."Margin %")
                    {
                    }
                    column(SalesAmountIncVAT_MAWBInvoiceCharge; "MAWB Invoice Charge"."Sales Amount Inc. VAT")
                    {
                    }
                    column(VAT_MAWBInvoiceCharge; "MAWB Invoice Charge"."VAT %")
                    {
                    }
                    column(TransactionDate_MAWBInvoiceCharge; "MAWB Invoice Charge"."Transaction Date")
                    {
                    }
                    column(FreightCost_MAWBInvoiceCharge; "MAWB Invoice Charge"."Freight Cost")
                    {
                    }
                    column(PurchaseACCode_MAWBInvoiceCharge; "MAWB Invoice Charge"."Purchase A/C Code")
                    {
                    }
                    column(PurchaseInvoiceNo_MAWBInvoiceCharge; "MAWB Invoice Charge"."Purchase Invoice No.")
                    {
                    }
                    column(SalesAmountIncMargin_MAWBInvoiceCharge; "MAWB Invoice Charge"."Sales Amount Inc. Margin")
                    {
                    }
                    column(InvoiceUnitPrice_MAWBInvoiceCharge; "MAWB Invoice Charge"."Invoice Unit Price")
                    {
                    }
                    column(PreparedBy_MAWBInvoiceCharge; "MAWB Invoice Charge"."Prepared By")
                    {
                    }
                    column(PreparedOn_MAWBInvoiceCharge; "MAWB Invoice Charge"."Prepared On")
                    {
                    }
                    column(ContractRate_MAWBInvoiceCharge; "MAWB Invoice Charge"."Contract Rate")
                    {
                    }
                    column(AgreedRate_MAWBInvoiceCharge; "MAWB Invoice Charge"."Agreed Rate")
                    {
                    }
                    column(ChargeableWeight_MAWBInvoiceCharge; "MAWB Invoice Charge"."Chargeable Weight")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
                Setup.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        Setup: Record "Import/Export Setup";
}

