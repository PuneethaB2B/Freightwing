report 50106 "Posted Import Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostedImportInvoice.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            CalcFields = "QR Code";
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(Item; Item.Description)
            {
            }
            column(ArrDate; ArrivalDate)
            {
            }
            column(Carrier; Carrier)
            {
            }
            column(Weight; Weight)
            {
            }
            column(FileNo; FileNo)
            {
            }
            column(Qty; Qty)
            {
            }
            column(VATNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(KRAPin; ImportExportSetup."KRA Pin")
            {
            }
            column(DocumentType_SalesHeader; "Sales Invoice Header"."Transaction Type")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Invoice Header"."Sell-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; BillTo)
            {
            }
            column(BilltoName2_SalesHeader; "Sales Invoice Header"."Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Sales Invoice Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Sales Invoice Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Sales Invoice Header"."Bill-to Contact")
            {
            }
            column(YourReference_SalesHeader; "Sales Invoice Header"."Your Reference")
            {
            }
            column(ShiptoCode_SalesHeader; "Sales Invoice Header"."Ship-to Code")
            {
            }
            column(ShiptoName_SalesHeader; "Sales Invoice Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_SalesHeader; "Sales Invoice Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_SalesHeader; "Sales Invoice Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesHeader; "Sales Invoice Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_SalesHeader; "Sales Invoice Header"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesHeader; "Sales Invoice Header"."Ship-to Contact")
            {
            }
            column(OrderDate_SalesHeader; "Sales Invoice Header"."Order Date")
            {
            }
            column(PostingDate_SalesHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(ShipmentDate_SalesHeader; "Sales Invoice Header"."Shipment Date")
            {
            }
            column(PostingDescription_SalesHeader; "Sales Invoice Header"."Posting Description")
            {
            }
            column(PaymentTermsCode_SalesHeader; "Sales Invoice Header"."Payment Terms Code")
            {
            }
            column(DueDate_SalesHeader; "Sales Invoice Header"."Due Date")
            {
            }
            column(PaymentDiscount_SalesHeader; "Sales Invoice Header"."Payment Discount %")
            {
            }
            column(PmtDiscountDate_SalesHeader; "Sales Invoice Header"."Pmt. Discount Date")
            {
            }
            column(ShipmentMethodCode_SalesHeader; "Sales Invoice Header"."Shipment Method Code")
            {
            }
            column(LocationCode_SalesHeader; "Sales Invoice Header"."Location Code")
            {
            }
            column(ShortcutDimension1Code_SalesHeader; "Sales Invoice Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_SalesHeader; "Sales Invoice Header"."Shortcut Dimension 2 Code")
            {
            }
            column(CustomerPostingGroup_SalesHeader; "Sales Invoice Header"."Customer Posting Group")
            {
            }
            column(CurrencyCode_SalesHeader; "Sales Invoice Header"."Currency Code")
            {
            }
            column(CurrencyFactor_SalesHeader; "Sales Invoice Header"."Currency Factor")
            {
            }
            column(CustomerPriceGroup_SalesHeader; "Sales Invoice Header"."Customer Price Group")
            {
            }
            column(PricesIncludingVAT_SalesHeader; "Sales Invoice Header"."Prices Including VAT")
            {
            }
            column(InvoiceDiscCode_SalesHeader; "Sales Invoice Header"."Invoice Disc. Code")
            {
            }
            column(CustomerDiscGroup_SalesHeader; "Sales Invoice Header"."Customer Disc. Group")
            {
            }
            column(LanguageCode_SalesHeader; "Sales Invoice Header"."Language Code")
            {
            }
            column(SalespersonCode_SalesHeader; "Sales Invoice Header"."Salesperson Code")
            {
            }
            column(Comment_SalesHeader; "Sales Invoice Header".Comment)
            {
            }
            column(NoPrinted_SalesHeader; "Sales Invoice Header"."No. Printed")
            {
            }
            column(OnHold_SalesHeader; "Sales Invoice Header"."On Hold")
            {
            }
            column(AppliestoDocType_SalesHeader; "Sales Invoice Header"."Applies-to Doc. Type")
            {
            }
            column(ImportMAWBNo_SalesHeader; "Sales Invoice Header"."Import MAWB No.")
            {
            }
            column(CurrencyCode_SalesLine; "Sales Invoice Header"."Currency Code")
            {
            }
            column(QRCode_SalesInvoiceHeader; "Sales Invoice Header"."QR Code")
            {
            }
            column(InvoiceNumber_SalesInvoiceHeader; "Sales Invoice Header"."Invoice Number")
            {
            }
            column(DeiviceCode_SalesInvoiceHeader; "Sales Invoice Header"."Deivice Code")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(SelltoCustomerNo_SalesLine; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Invoice Line"."Line No.")
                {
                }
                column(Type_SalesLine; "Sales Invoice Line".Type)
                {
                }
                column(No_SalesLine; "Sales Invoice Line"."No.")
                {
                }
                column(LocationCode_SalesLine; "Sales Invoice Line"."Location Code")
                {
                }
                column(PostingGroup_SalesLine; "Sales Invoice Line"."Posting Group")
                {
                }
                column(ShipmentDate_SalesLine; "Sales Invoice Line"."Shipment Date")
                {
                }
                column(Description_SalesLine; "Sales Invoice Line".Description)
                {
                }
                column(Description2_SalesLine; "Sales Invoice Line"."Description 2")
                {
                }
                column(UnitofMeasure_SalesLine; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesLine; "Sales Invoice Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_SalesLine; "Sales Invoice Line"."VAT %")
                {
                }
                column(LineDiscount_SalesLine; "Sales Invoice Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesLine; "Sales Invoice Line"."Line Discount Amount")
                {
                }
                column(Amount_SalesLine; "Sales Invoice Line".Amount)
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(AllowInvoiceDisc_SalesLine; "Sales Invoice Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_SalesLine; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesLine; "Sales Invoice Line"."Net Weight")
                {
                }
                column(UnitsperParcel_SalesLine; "Sales Invoice Line"."Units per Parcel")
                {
                }
                column(UnitVolume_SalesLine; "Sales Invoice Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_SalesLine; "Sales Invoice Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_SalesLine; "Sales Invoice Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_SalesLine; "Sales Invoice Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPriceGroup_SalesLine; "Sales Invoice Line"."Customer Price Group")
                {
                }
                column(JobNo_SalesLine; "Sales Invoice Line"."Job No.")
                {
                }
                column(FreightChargeCode_SalesLine; "Sales Invoice Line"."Freight Charge Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                PreAlertHeader.RESET;
                PreAlertHeader.SETRANGE(PreAlertHeader."MAWB No", "Sales Invoice Header"."Import MAWB No.");
                IF PreAlertHeader.FINDFIRST THEN BEGIN
                    ArrivalDate := PreAlertHeader."Arrival Date FWL";
                    Item.GET(PreAlertHeader."Item No.");
                    Carrier := PreAlertHeader."Delivery Agent";
                    FileNo := PreAlertHeader."No.";
                    Qty := PreAlertHeader.Quantity;
                    Weight := PreAlertHeader.Weight;
                END;
                IF "Sales Invoice Header"."Bill-to Name" = '' THEN
                    BillTo := "Sales Invoice Header"."Sell-to Customer Name"
                ELSE
                    BillTo := "Sales Invoice Header"."Bill-to Name";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                ImportExportSetup.GET;
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
        PreAlertHeader: Record "Pre Alert Header";
        ArrivalDate: Date;
        Item: Record Item;
        Qty: Decimal;
        FileNo: Code[200];
        Carrier: Code[200];
        Weight: Decimal;
        ImportExportSetup: Record "Import/Export Setup";
        BillTo: Text[250];
}

