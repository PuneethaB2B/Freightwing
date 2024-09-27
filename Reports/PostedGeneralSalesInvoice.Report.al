report 50093 "Posted General Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostedGeneralSalesInvoice.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table112)
        {
            CalcFields = QR Code;
            column(CurrencyCode_SalesHeader; "Sales Invoice Header"."Currency Code")
            {
            }
            column(DocumentType_SalesHeader; "Sales Invoice Header"."Transaction Type")
            {
            }
            column(No_SalesHeader; "Sales Invoice Header"."No.")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(DocumentDate_SalesHeader; "Sales Invoice Header"."Document Date")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(Logo; CompanyInformation.Picture)
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(ETR; ImportExportSetup."KRA Pin")
            {
            }
            column(VAT; CompanyInformation."VAT Registration No.")
            {
            }
            column(CustPostAdd; Customer.Address)
            {
            }
            column(CustPhyAdd; Customer."Address 2")
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(CustPostCode; Customer."Post Code")
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
            dataitem(DataItem1000000001; Table113)
            {
                DataItemLink = Document No.=FIELD(No.);
                column(DocumentType_SalesLine; "Sales Invoice Line".Type)
                {
                }
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
                column(MAWBNo_SalesLine; "Sales Invoice Line"."MAWB No.")
                {
                }
                column(HAWBNo_SalesLine; "Sales Invoice Line"."HAWB No.")
                {
                }
                column(DivisionCode_SalesLine; "Sales Invoice Line"."Division Code")
                {
                }
                column(SplitWeight_SalesLine; "Sales Invoice Line"."Split Weight")
                {
                }
                column(AirlineCode_SalesLine; "Sales Invoice Line"."Airline Code")
                {
                }
                column(ConsigneeCode_SalesLine; "Sales Invoice Line"."Consignee Code")
                {
                }
                column(FlightCode_SalesLine; "Sales Invoice Line"."Flight Code")
                {
                }
                column(DestinationCode_SalesLine; "Sales Invoice Line"."Destination Code")
                {
                }
                column(FlightDate_SalesLine; "Sales Invoice Line"."Flight Date")
                {
                }
                column(VATAmount_SalesLine; "Sales Invoice Line"."VAT Amount")
                {
                }
                column(CostAmount_SalesLine; "Sales Invoice Line"."Cost Amount")
                {
                }
                column(FreightChargeCode_SalesLine; "Sales Invoice Line"."Freight Charge Code")
                {
                }
                column(SplitFactor_SalesLine; "Sales Invoice Line"."Split Factor")
                {
                }
                column(FreightCost_SalesLine; "Sales Invoice Line"."Freight Cost")
                {
                }
                column(Margin_SalesLine; "Sales Invoice Line"."Margin %")
                {
                }
                column(MarginAmount_SalesLine; "Sales Invoice Line"."Margin Amount")
                {
                }
                column(UnitPrice_SalesLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(Amount_SalesLine; "Sales Invoice Line".Amount)
                {
                }
                column(VAT_SalesLine; "Sales Invoice Line"."VAT %")
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Invoice Line"."Amount Including VAT")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.CALCFIELDS(Picture);
                Customer.GET("Sales Invoice Header"."Sell-to Customer No.");
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
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
        CompanyInformation: Record "79";
        ImportExportSetup: Record "50010";
        Customer: Record "18";
}

