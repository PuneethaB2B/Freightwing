report 50095 "Import Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/ImportInvoice.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
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
            column(VATNO; CompanyInfo."VAT Registration No.")
            {
            }
            column(KRAPIn; ImportExportSetup."KRA Pin")
            {
            }
            column(DocumentType_SalesHeader; "Sales Header"."Document Type")
            {
            }
            column(SelltoCustomerNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoName2_SalesHeader; "Sales Header"."Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Sales Header"."Bill-to Address")
            {
            }
            column(BilltoAddress2_SalesHeader; "Sales Header"."Bill-to Address 2")
            {
            }
            column(BilltoCity_SalesHeader; "Sales Header"."Bill-to City")
            {
            }
            column(BilltoContact_SalesHeader; "Sales Header"."Bill-to Contact")
            {
            }
            column(YourReference_SalesHeader; "Sales Header"."Your Reference")
            {
            }
            column(ShiptoCode_SalesHeader; "Sales Header"."Ship-to Code")
            {
            }
            column(ShiptoName_SalesHeader; "Sales Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_SalesHeader; "Sales Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_SalesHeader; "Sales Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_SalesHeader; "Sales Header"."Ship-to Address 2")
            {
            }
            column(ShiptoCity_SalesHeader; "Sales Header"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesHeader; "Sales Header"."Ship-to Contact")
            {
            }
            column(OrderDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
            {
            }
            column(PostingDescription_SalesHeader; "Sales Header"."Posting Description")
            {
            }
            column(PaymentTermsCode_SalesHeader; "Sales Header"."Payment Terms Code")
            {
            }
            column(DueDate_SalesHeader; "Sales Header"."Due Date")
            {
            }
            column(PaymentDiscount_SalesHeader; "Sales Header"."Payment Discount %")
            {
            }
            column(PmtDiscountDate_SalesHeader; "Sales Header"."Pmt. Discount Date")
            {
            }
            column(ShipmentMethodCode_SalesHeader; "Sales Header"."Shipment Method Code")
            {
            }
            column(LocationCode_SalesHeader; "Sales Header"."Location Code")
            {
            }
            column(ShortcutDimension1Code_SalesHeader; "Sales Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_SalesHeader; "Sales Header"."Shortcut Dimension 2 Code")
            {
            }
            column(CustomerPostingGroup_SalesHeader; "Sales Header"."Customer Posting Group")
            {
            }
            column(CurrencyCode_SalesHeader; "Sales Header"."Currency Code")
            {
            }
            column(CurrencyFactor_SalesHeader; "Sales Header"."Currency Factor")
            {
            }
            column(CustomerPriceGroup_SalesHeader; "Sales Header"."Customer Price Group")
            {
            }
            column(PricesIncludingVAT_SalesHeader; "Sales Header"."Prices Including VAT")
            {
            }
            column(InvoiceDiscCode_SalesHeader; "Sales Header"."Invoice Disc. Code")
            {
            }
            column(CustomerDiscGroup_SalesHeader; "Sales Header"."Customer Disc. Group")
            {
            }
            column(LanguageCode_SalesHeader; "Sales Header"."Language Code")
            {
            }
            column(SalespersonCode_SalesHeader; "Sales Header"."Salesperson Code")
            {
            }
            column(OrderClass_SalesHeader; "Sales Header"."Order Class")
            {
            }
            column(Comment_SalesHeader; "Sales Header".Comment)
            {
            }
            column(NoPrinted_SalesHeader; "Sales Header"."No. Printed")
            {
            }
            column(OnHold_SalesHeader; "Sales Header"."On Hold")
            {
            }
            column(AppliestoDocType_SalesHeader; "Sales Header"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_SalesHeader; "Sales Header"."Applies-to Doc. No.")
            {
            }
            column(BalAccountNo_SalesHeader; "Sales Header"."Bal. Account No.")
            {
            }
            column(RecalculateInvoiceDisc_SalesHeader; "Sales Header"."Recalculate Invoice Disc.")
            {
            }
            column(Ship_SalesHeader; "Sales Header".Ship)
            {
            }
            column(Invoice_SalesHeader; "Sales Header".Invoice)
            {
            }
            column(PrintPostedDocuments_SalesHeader; "Sales Header"."Print Posted Documents")
            {
            }
            column(Amount_SalesHeader; "Sales Header".Amount)
            {
            }
            column(AmountIncludingVAT_SalesHeader; "Sales Header"."Amount Including VAT")
            {
            }
            column(ShippingNo_SalesHeader; "Sales Header"."Shipping No.")
            {
            }
            column(PostingNo_SalesHeader; "Sales Header"."Posting No.")
            {
            }
            column(LastShippingNo_SalesHeader; "Sales Header"."Last Shipping No.")
            {
            }
            column(LastPostingNo_SalesHeader; "Sales Header"."Last Posting No.")
            {
            }
            column(PrepaymentNo_SalesHeader; "Sales Header"."Prepayment No.")
            {
            }
            column(LastPrepaymentNo_SalesHeader; "Sales Header"."Last Prepayment No.")
            {
            }
            column(PrepmtCrMemoNo_SalesHeader; "Sales Header"."Prepmt. Cr. Memo No.")
            {
            }
            column(LastPrepmtCrMemoNo_SalesHeader; "Sales Header"."Last Prepmt. Cr. Memo No.")
            {
            }
            column(VATRegistrationNo_SalesHeader; "Sales Header"."VAT Registration No.")
            {
            }
            column(CombineShipments_SalesHeader; "Sales Header"."Combine Shipments")
            {
            }
            column(ReasonCode_SalesHeader; "Sales Header"."Reason Code")
            {
            }
            column(GenBusPostingGroup_SalesHeader; "Sales Header"."Gen. Bus. Posting Group")
            {
            }
            column(EU3PartyTrade_SalesHeader; "Sales Header"."EU 3-Party Trade")
            {
            }
            column(TransactionType_SalesHeader; "Sales Header"."Transaction Type")
            {
            }
            column(TransportMethod_SalesHeader; "Sales Header"."Transport Method")
            {
            }
            column(VATCountryRegionCode_SalesHeader; "Sales Header"."VAT Country/Region Code")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(SelltoCustomerName2_SalesHeader; "Sales Header"."Sell-to Customer Name 2")
            {
            }
            column(SelltoAddress_SalesHeader; "Sales Header"."Sell-to Address")
            {
            }
            column(SelltoAddress2_SalesHeader; "Sales Header"."Sell-to Address 2")
            {
            }
            column(SelltoCity_SalesHeader; "Sales Header"."Sell-to City")
            {
            }
            column(SelltoContact_SalesHeader; "Sales Header"."Sell-to Contact")
            {
            }
            column(BilltoPostCode_SalesHeader; "Sales Header"."Bill-to Post Code")
            {
            }
            column(BilltoCounty_SalesHeader; "Sales Header"."Bill-to County")
            {
            }
            column(BilltoCountryRegionCode_SalesHeader; "Sales Header"."Bill-to Country/Region Code")
            {
            }
            column(SelltoPostCode_SalesHeader; "Sales Header"."Sell-to Post Code")
            {
            }
            column(SelltoCounty_SalesHeader; "Sales Header"."Sell-to County")
            {
            }
            column(SelltoCountryRegionCode_SalesHeader; "Sales Header"."Sell-to Country/Region Code")
            {
            }
            column(ShiptoPostCode_SalesHeader; "Sales Header"."Ship-to Post Code")
            {
            }
            column(ShiptoCounty_SalesHeader; "Sales Header"."Ship-to County")
            {
            }
            column(ShiptoCountryRegionCode_SalesHeader; "Sales Header"."Ship-to Country/Region Code")
            {
            }
            column(BalAccountType_SalesHeader; "Sales Header"."Bal. Account Type")
            {
            }
            column(ExitPoint_SalesHeader; "Sales Header"."Exit Point")
            {
            }
            column(Correction_SalesHeader; "Sales Header".Correction)
            {
            }
            column(DocumentDate_SalesHeader; "Sales Header"."Document Date")
            {
            }
            column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
            {
            }
            column(Area_SalesHeader; "Sales Header".Area)
            {
            }
            column(TransactionSpecification_SalesHeader; "Sales Header"."Transaction Specification")
            {
            }
            column(PaymentMethodCode_SalesHeader; "Sales Header"."Payment Method Code")
            {
            }
            column(ShippingAgentCode_SalesHeader; "Sales Header"."Shipping Agent Code")
            {
            }
            column(PackageTrackingNo_SalesHeader; "Sales Header"."Package Tracking No.")
            {
            }
            column(NoSeries_SalesHeader; "Sales Header"."No. Series")
            {
            }
            column(PostingNoSeries_SalesHeader; "Sales Header"."Posting No. Series")
            {
            }
            column(ShippingNoSeries_SalesHeader; "Sales Header"."Shipping No. Series")
            {
            }
            column(TaxAreaCode_SalesHeader; "Sales Header"."Tax Area Code")
            {
            }
            column(TaxLiable_SalesHeader; "Sales Header"."Tax Liable")
            {
            }
            column(VATBusPostingGroup_SalesHeader; "Sales Header"."VAT Bus. Posting Group")
            {
            }
            column(Reserve_SalesHeader; "Sales Header".Reserve)
            {
            }
            column(AppliestoID_SalesHeader; "Sales Header"."Applies-to ID")
            {
            }
            column(VATBaseDiscount_SalesHeader; "Sales Header"."VAT Base Discount %")
            {
            }
            column(Status_SalesHeader; "Sales Header".Status)
            {
            }
            column(InvoiceDiscountCalculation_SalesHeader; "Sales Header"."Invoice Discount Calculation")
            {
            }
            column(InvoiceDiscountValue_SalesHeader; "Sales Header"."Invoice Discount Value")
            {
            }
            column(SendICDocument_SalesHeader; "Sales Header"."Send IC Document")
            {
            }
            column(ICStatus_SalesHeader; "Sales Header"."IC Status")
            {
            }
            column(SelltoICPartnerCode_SalesHeader; "Sales Header"."Sell-to IC Partner Code")
            {
            }
            column(BilltoICPartnerCode_SalesHeader; "Sales Header"."Bill-to IC Partner Code")
            {
            }
            column(ICDirection_SalesHeader; "Sales Header"."IC Direction")
            {
            }
            column(Prepayment_SalesHeader; "Sales Header"."Prepayment %")
            {
            }
            column(PrepaymentNoSeries_SalesHeader; "Sales Header"."Prepayment No. Series")
            {
            }
            column(CompressPrepayment_SalesHeader; "Sales Header"."Compress Prepayment")
            {
            }
            column(PrepaymentDueDate_SalesHeader; "Sales Header"."Prepayment Due Date")
            {
            }
            column(PrepmtCrMemoNoSeries_SalesHeader; "Sales Header"."Prepmt. Cr. Memo No. Series")
            {
            }
            column(PrepmtPostingDescription_SalesHeader; "Sales Header"."Prepmt. Posting Description")
            {
            }
            column(PrepmtPmtDiscountDate_SalesHeader; "Sales Header"."Prepmt. Pmt. Discount Date")
            {
            }
            column(PrepmtPaymentTermsCode_SalesHeader; "Sales Header"."Prepmt. Payment Terms Code")
            {
            }
            column(PrepmtPaymentDiscount_SalesHeader; "Sales Header"."Prepmt. Payment Discount %")
            {
            }
            column(QuoteNo_SalesHeader; "Sales Header"."Quote No.")
            {
            }
            column(JobQueueStatus_SalesHeader; "Sales Header"."Job Queue Status")
            {
            }
            column(JobQueueEntryID_SalesHeader; "Sales Header"."Job Queue Entry ID")
            {
            }
            column(IncomingDocumentEntryNo_SalesHeader; "Sales Header"."Incoming Document Entry No.")
            {
            }
            column(DimensionSetID_SalesHeader; "Sales Header"."Dimension Set ID")
            {
            }
            // column(AuthorizationRequired_SalesHeader; "Sales Header"."Authorization Required")
            // {
            // }
            // column(CreditCardNo_SalesHeader; "Sales Header"."Credit Card No.")
            // {
            // }  //B2BUPG Removed in hiogher version, there is no data against the field.
            column(DirectDebitMandateID_SalesHeader; "Sales Header"."Direct Debit Mandate ID")
            {
            }
            column(InvoiceDiscountAmount_SalesHeader; "Sales Header"."Invoice Discount Amount")
            {
            }
            column(NoofArchivedVersions_SalesHeader; "Sales Header"."No. of Archived Versions")
            {
            }
            column(DocNoOccurrence_SalesHeader; "Sales Header"."Doc. No. Occurrence")
            {
            }
            column(CampaignNo_SalesHeader; "Sales Header"."Campaign No.")
            {
            }
            column(SelltoCustomerTemplateCode_SalesHeader; "Sales Header"."Sell-to Customer Templ. Code")
            {
            }
            column(SelltoContactNo_SalesHeader; "Sales Header"."Sell-to Contact No.")
            {
            }
            column(BilltoContactNo_SalesHeader; "Sales Header"."Bill-to Contact No.")
            {
            }
            column(BilltoCustomerTemplateCode_SalesHeader; "Sales Header"."Bill-to Customer Templ. Code")
            {
            }
            column(OpportunityNo_SalesHeader; "Sales Header"."Opportunity No.")
            {
            }
            column(ResponsibilityCenter_SalesHeader; "Sales Header"."Responsibility Center")
            {
            }
            column(ShippingAdvice_SalesHeader; "Sales Header"."Shipping Advice")
            {
            }
            column(ShippedNotInvoiced_SalesHeader; "Sales Header"."Shipped Not Invoiced")
            {
            }
            column(CompletelyShipped_SalesHeader; "Sales Header"."Completely Shipped")
            {
            }
            column(PostingfromWhseRef_SalesHeader; "Sales Header"."Posting from Whse. Ref.")
            {
            }
            column(LocationFilter_SalesHeader; "Sales Header"."Location Filter")
            {
            }
            column(RequestedDeliveryDate_SalesHeader; "Sales Header"."Requested Delivery Date")
            {
            }
            column(PromisedDeliveryDate_SalesHeader; "Sales Header"."Promised Delivery Date")
            {
            }
            column(ShippingTime_SalesHeader; "Sales Header"."Shipping Time")
            {
            }
            column(OutboundWhseHandlingTime_SalesHeader; "Sales Header"."Outbound Whse. Handling Time")
            {
            }
            column(ShippingAgentServiceCode_SalesHeader; "Sales Header"."Shipping Agent Service Code")
            {
            }
            column(LateOrderShipping_SalesHeader; "Sales Header"."Late Order Shipping")
            {
            }
            column(DateFilter_SalesHeader; "Sales Header"."Date Filter")
            {
            }
            column(Receive_SalesHeader; "Sales Header".Receive)
            {
            }
            column(ReturnReceiptNo_SalesHeader; "Sales Header"."Return Receipt No.")
            {
            }
            column(ReturnReceiptNoSeries_SalesHeader; "Sales Header"."Return Receipt No. Series")
            {
            }
            column(LastReturnReceiptNo_SalesHeader; "Sales Header"."Last Return Receipt No.")
            {
            }
            column(AllowLineDisc_SalesHeader; "Sales Header"."Allow Line Disc.")
            {
            }
            column(GetShipmentUsed_SalesHeader; "Sales Header"."Get Shipment Used")
            {
            }
            column(AssignedUserID_SalesHeader; "Sales Header"."Assigned User ID")
            {
            }
            column(MAWBNo_SalesHeader; "Sales Header"."MAWB No.")
            {
            }
            column(AirlineCode_SalesHeader; "Sales Header"."Airline Code")
            {
            }
            column(ConsigneeCode_SalesHeader; "Sales Header"."Consignee Code")
            {
            }
            column(FlightCode_SalesHeader; "Sales Header"."Flight Code")
            {
            }
            column(DestinationCode_SalesHeader; "Sales Header"."Destination Code")
            {
            }
            column(FlightDate_SalesHeader; "Sales Header"."Flight Date")
            {
            }
            column(ChargeableWeight_SalesHeader; "Sales Header"."Chargeable Weight")
            {
            }
            column(GrossWeight_SalesHeader; "Sales Header"."Gross Weight")
            {
            }
            column(HAWBNo_SalesHeader; "Sales Header"."HAWB No.")
            {
            }
            column(Posted_SalesHeader; "Sales Header".Posted)
            {
            }
            column(ImportMAWBNo_SalesHeader; "Sales Header"."Import MAWB No.")
            {
            }
            column(CCPP_SalesHeader; "Sales Header"."CC/PP")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentType_SalesLine; "Sales Line"."Document Type")
                {
                }
                column(SelltoCustomerNo_SalesLine; "Sales Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(Type_SalesLine; "Sales Line".Type)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(LocationCode_SalesLine; "Sales Line"."Location Code")
                {
                }
                column(PostingGroup_SalesLine; "Sales Line"."Posting Group")
                {
                }
                column(ShipmentDate_SalesLine; "Sales Line"."Shipment Date")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Description2_SalesLine; "Sales Line"."Description 2")
                {
                }
                column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(OutstandingQuantity_SalesLine; "Sales Line"."Outstanding Quantity")
                {
                }
                column(QtytoInvoice_SalesLine; "Sales Line"."Qty. to Invoice")
                {
                }
                column(QtytoShip_SalesLine; "Sales Line"."Qty. to Ship")
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesLine; "Sales Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_SalesLine; "Sales Line"."VAT %")
                {
                }
                column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesLine; "Sales Line"."Line Discount Amount")
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(AmountIncludingVAT_SalesLine; "Sales Line"."Amount Including VAT")
                {
                }
                column(AllowInvoiceDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_SalesLine; "Sales Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesLine; "Sales Line"."Net Weight")
                {
                }
                column(UnitsperParcel_SalesLine; "Sales Line"."Units per Parcel")
                {
                }
                column(UnitVolume_SalesLine; "Sales Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_SalesLine; "Sales Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_SalesLine; "Sales Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_SalesLine; "Sales Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPriceGroup_SalesLine; "Sales Line"."Customer Price Group")
                {
                }
                column(JobNo_SalesLine; "Sales Line"."Job No.")
                {
                }
                column(WorkTypeCode_SalesLine; "Sales Line"."Work Type Code")
                {
                }
                column(RecalculateInvoiceDisc_SalesLine; "Sales Line"."Recalculate Invoice Disc.")
                {
                }
                column(OutstandingAmount_SalesLine; "Sales Line"."Outstanding Amount")
                {
                }
                column(QtyShippedNotInvoiced_SalesLine; "Sales Line"."Qty. Shipped Not Invoiced")
                {
                }
                column(ShippedNotInvoiced_SalesLine; "Sales Line"."Shipped Not Invoiced")
                {
                }
                column(QuantityShipped_SalesLine; "Sales Line"."Quantity Shipped")
                {
                }
                column(QuantityInvoiced_SalesLine; "Sales Line"."Quantity Invoiced")
                {
                }
                column(ShipmentNo_SalesLine; "Sales Line"."Shipment No.")
                {
                }
                column(ShipmentLineNo_SalesLine; "Sales Line"."Shipment Line No.")
                {
                }
                column(Profit_SalesLine; "Sales Line"."Profit %")
                {
                }
                column(BilltoCustomerNo_SalesLine; "Sales Line"."Bill-to Customer No.")
                {
                }
                column(InvDiscountAmount_SalesLine; "Sales Line"."Inv. Discount Amount")
                {
                }
                column(PurchaseOrderNo_SalesLine; "Sales Line"."Purchase Order No.")
                {
                }
                column(PurchOrderLineNo_SalesLine; "Sales Line"."Purch. Order Line No.")
                {
                }
                column(DropShipment_SalesLine; "Sales Line"."Drop Shipment")
                {
                }
                column(GenBusPostingGroup_SalesLine; "Sales Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_SalesLine; "Sales Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_SalesLine; "Sales Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_SalesLine; "Sales Line"."Transaction Type")
                {
                }
                column(TransportMethod_SalesLine; "Sales Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_SalesLine; "Sales Line"."Attached to Line No.")
                {
                }
                column(ExitPoint_SalesLine; "Sales Line"."Exit Point")
                {
                }
                column(Area_SalesLine; "Sales Line".Area)
                {
                }
                column(TransactionSpecification_SalesLine; "Sales Line"."Transaction Specification")
                {
                }
                column(TaxAreaCode_SalesLine; "Sales Line"."Tax Area Code")
                {
                }
                column(TaxLiable_SalesLine; "Sales Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_SalesLine; "Sales Line"."Tax Group Code")
                {
                }
                column(VATClauseCode_SalesLine; "Sales Line"."VAT Clause Code")
                {
                }
                column(VATBusPostingGroup_SalesLine; "Sales Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_SalesLine; "Sales Line"."VAT Prod. Posting Group")
                {
                }
                column(CurrencyCode_SalesLine; "Sales Line"."Currency Code")
                {
                }
                column(OutstandingAmountLCY_SalesLine; "Sales Line"."Outstanding Amount (LCY)")
                {
                }
                column(ShippedNotInvoicedLCY_SalesLine; "Sales Line"."Shipped Not Invoiced (LCY)")
                {
                }
                column(ReservedQuantity_SalesLine; "Sales Line"."Reserved Quantity")
                {
                }
                column(Reserve_SalesLine; "Sales Line".Reserve)
                {
                }
                column(BlanketOrderNo_SalesLine; "Sales Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_SalesLine; "Sales Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_SalesLine; "Sales Line"."VAT Base Amount")
                {
                }
                column(UnitCost_SalesLine; "Sales Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_SalesLine; "Sales Line"."System-Created Entry")
                {
                }
                column(LineAmount_SalesLine; "Sales Line"."Line Amount")
                {
                }
                column(VATDifference_SalesLine; "Sales Line"."VAT Difference")
                {
                }
                column(InvDiscAmounttoInvoice_SalesLine; "Sales Line"."Inv. Disc. Amount to Invoice")
                {
                }
                column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_SalesLine; "Sales Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_SalesLine; "Sales Line"."IC Partner Reference")
                {
                }
                column(Prepayment_SalesLine; "Sales Line"."Prepayment %")
                {
                }
                column(PrepmtLineAmount_SalesLine; "Sales Line"."Prepmt. Line Amount")
                {
                }
                column(PrepmtAmtInv_SalesLine; "Sales Line"."Prepmt. Amt. Inv.")
                {
                }
                column(PrepmtAmtInclVAT_SalesLine; "Sales Line"."Prepmt. Amt. Incl. VAT")
                {
                }
                column(PrepaymentAmount_SalesLine; "Sales Line"."Prepayment Amount")
                {
                }
                column(PrepmtVATBaseAmt_SalesLine; "Sales Line"."Prepmt. VAT Base Amt.")
                {
                }
                column(PrepaymentVAT_SalesLine; "Sales Line"."Prepayment VAT %")
                {
                }
                column(PrepmtVATCalcType_SalesLine; "Sales Line"."Prepmt. VAT Calc. Type")
                {
                }
                column(PrepaymentVATIdentifier_SalesLine; "Sales Line"."Prepayment VAT Identifier")
                {
                }
                column(PrepaymentTaxAreaCode_SalesLine; "Sales Line"."Prepayment Tax Area Code")
                {
                }
                column(PrepaymentTaxLiable_SalesLine; "Sales Line"."Prepayment Tax Liable")
                {
                }
                column(PrepaymentTaxGroupCode_SalesLine; "Sales Line"."Prepayment Tax Group Code")
                {
                }
                column(PrepmtAmttoDeduct_SalesLine; "Sales Line"."Prepmt Amt to Deduct")
                {
                }
                column(PrepmtAmtDeducted_SalesLine; "Sales Line"."Prepmt Amt Deducted")
                {
                }
                column(PrepaymentLine_SalesLine; "Sales Line"."Prepayment Line")
                {
                }
                column(PrepmtAmountInvInclVAT_SalesLine; "Sales Line"."Prepmt. Amount Inv. Incl. VAT")
                {
                }
                column(PrepmtAmountInvLCY_SalesLine; "Sales Line"."Prepmt. Amount Inv. (LCY)")
                {
                }
                column(ICPartnerCode_SalesLine; "Sales Line"."IC Partner Code")
                {
                }
                column(PrepmtVATAmountInvLCY_SalesLine; "Sales Line"."Prepmt. VAT Amount Inv. (LCY)")
                {
                }
                column(PrepaymentVATDifference_SalesLine; "Sales Line"."Prepayment VAT Difference")
                {
                }
                column(PrepmtVATDifftoDeduct_SalesLine; "Sales Line"."Prepmt VAT Diff. to Deduct")
                {
                }
                column(PrepmtVATDiffDeducted_SalesLine; "Sales Line"."Prepmt VAT Diff. Deducted")
                {
                }
                column(DimensionSetID_SalesLine; "Sales Line"."Dimension Set ID")
                {
                }
                column(QtytoAssembletoOrder_SalesLine; "Sales Line"."Qty. to Assemble to Order")
                {
                }
                column(QtytoAsmtoOrderBase_SalesLine; "Sales Line"."Qty. to Asm. to Order (Base)")
                {
                }
                column(ATOWhseOutstandingQty_SalesLine; "Sales Line"."ATO Whse. Outstanding Qty.")
                {
                }
                column(ATOWhseOutstdQtyBase_SalesLine; "Sales Line"."ATO Whse. Outstd. Qty. (Base)")
                {
                }
                column(JobTaskNo_SalesLine; "Sales Line"."Job Task No.")
                {
                }
                column(JobContractEntryNo_SalesLine; "Sales Line"."Job Contract Entry No.")
                {
                }
                column(PostingDate_SalesLine; "Sales Line"."Posting Date")
                {
                }
                column(VariantCode_SalesLine; "Sales Line"."Variant Code")
                {
                }
                column(BinCode_SalesLine; "Sales Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_SalesLine; "Sales Line"."Qty. per Unit of Measure")
                {
                }
                column(Planned_SalesLine; "Sales Line".Planned)
                {
                }
                column(UnitofMeasureCode_SalesLine; "Sales Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_SalesLine; "Sales Line"."Quantity (Base)")
                {
                }
                column(OutstandingQtyBase_SalesLine; "Sales Line"."Outstanding Qty. (Base)")
                {
                }
                column(QtytoInvoiceBase_SalesLine; "Sales Line"."Qty. to Invoice (Base)")
                {
                }
                column(QtytoShipBase_SalesLine; "Sales Line"."Qty. to Ship (Base)")
                {
                }
                column(QtyShippedNotInvdBase_SalesLine; "Sales Line"."Qty. Shipped Not Invd. (Base)")
                {
                }
                column(QtyShippedBase_SalesLine; "Sales Line"."Qty. Shipped (Base)")
                {
                }
                column(QtyInvoicedBase_SalesLine; "Sales Line"."Qty. Invoiced (Base)")
                {
                }
                column(ReservedQtyBase_SalesLine; "Sales Line"."Reserved Qty. (Base)")
                {
                }
                column(FAPostingDate_SalesLine; "Sales Line"."FA Posting Date")
                {
                }
                column(DepreciationBookCode_SalesLine; "Sales Line"."Depreciation Book Code")
                {
                }
                column(DepruntilFAPostingDate_SalesLine; "Sales Line"."Depr. until FA Posting Date")
                {
                }
                column(DuplicateinDepreciationBook_SalesLine; "Sales Line"."Duplicate in Depreciation Book")
                {
                }
                column(UseDuplicationList_SalesLine; "Sales Line"."Use Duplication List")
                {
                }
                column(ResponsibilityCenter_SalesLine; "Sales Line"."Responsibility Center")
                {
                }
                column(OutofStockSubstitution_SalesLine; "Sales Line"."Out-of-Stock Substitution")
                {
                }
                column(SubstitutionAvailable_SalesLine; "Sales Line"."Substitution Available")
                {
                }
                column(OriginallyOrderedNo_SalesLine; "Sales Line"."Originally Ordered No.")
                {
                }
                column(OriginallyOrderedVarCode_SalesLine; "Sales Line"."Originally Ordered Var. Code")
                {
                }
                column(CrossReferenceNo_SalesLine; "Sales Line"."Item Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_SalesLine; "Sales Line"."Item Reference Unit of Measure")
                {
                }
                column(CrossReferenceType_SalesLine; "Sales Line"."Item Reference Type")
                {
                }
                column(CrossReferenceTypeNo_SalesLine; "Sales Line"."Item Reference Type No.")
                {
                }
                column(ItemCategoryCode_SalesLine; "Sales Line"."Item Category Code")
                {
                }
                column(Nonstock_SalesLine; "Sales Line".Nonstock)
                {
                }
                column(PurchasingCode_SalesLine; "Sales Line"."Purchasing Code")
                {
                }
                column(ProductGroupCode_SalesLine; "Sales Line"."Item Category Code")
                {
                }//B22BUPG
                column(SpecialOrder_SalesLine; "Sales Line"."Special Order")
                {
                }
                column(SpecialOrderPurchaseNo_SalesLine; "Sales Line"."Special Order Purchase No.")
                {
                }
                column(SpecialOrderPurchLineNo_SalesLine; "Sales Line"."Special Order Purch. Line No.")
                {
                }
                column(WhseOutstandingQty_SalesLine; "Sales Line"."Whse. Outstanding Qty.")
                {
                }
                column(WhseOutstandingQtyBase_SalesLine; "Sales Line"."Whse. Outstanding Qty. (Base)")
                {
                }
                column(CompletelyShipped_SalesLine; "Sales Line"."Completely Shipped")
                {
                }
                column(RequestedDeliveryDate_SalesLine; "Sales Line"."Requested Delivery Date")
                {
                }
                column(PromisedDeliveryDate_SalesLine; "Sales Line"."Promised Delivery Date")
                {
                }
                column(ShippingTime_SalesLine; "Sales Line"."Shipping Time")
                {
                }
                column(OutboundWhseHandlingTime_SalesLine; "Sales Line"."Outbound Whse. Handling Time")
                {
                }
                column(PlannedDeliveryDate_SalesLine; "Sales Line"."Planned Delivery Date")
                {
                }
                column(PlannedShipmentDate_SalesLine; "Sales Line"."Planned Shipment Date")
                {
                }
                column(ShippingAgentCode_SalesLine; "Sales Line"."Shipping Agent Code")
                {
                }
                column(ShippingAgentServiceCode_SalesLine; "Sales Line"."Shipping Agent Service Code")
                {
                }
                column(AllowItemChargeAssignment_SalesLine; "Sales Line"."Allow Item Charge Assignment")
                {
                }
                column(QtytoAssign_SalesLine; "Sales Line"."Qty. to Assign")
                {
                }
                column(QtyAssigned_SalesLine; "Sales Line"."Qty. Assigned")
                {
                }
                column(ReturnQtytoReceive_SalesLine; "Sales Line"."Return Qty. to Receive")
                {
                }
                column(ReturnQtytoReceiveBase_SalesLine; "Sales Line"."Return Qty. to Receive (Base)")
                {
                }
                column(ReturnQtyRcdNotInvd_SalesLine; "Sales Line"."Return Qty. Rcd. Not Invd.")
                {
                }
                column(RetQtyRcdNotInvdBase_SalesLine; "Sales Line"."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                }
                column(ReturnRcdNotInvd_SalesLine; "Sales Line"."Return Rcd. Not Invd.")
                {
                }
                column(ReturnRcdNotInvdLCY_SalesLine; "Sales Line"."Return Rcd. Not Invd. (LCY)")
                {
                }
                column(ReturnQtyReceived_SalesLine; "Sales Line"."Return Qty. Received")
                {
                }
                column(ReturnQtyReceivedBase_SalesLine; "Sales Line"."Return Qty. Received (Base)")
                {
                }
                column(ApplfromItemEntry_SalesLine; "Sales Line"."Appl.-from Item Entry")
                {
                }
                column(BOMItemNo_SalesLine; "Sales Line"."BOM Item No.")
                {
                }
                column(ReturnReceiptNo_SalesLine; "Sales Line"."Return Receipt No.")
                {
                }
                column(ReturnReceiptLineNo_SalesLine; "Sales Line"."Return Receipt Line No.")
                {
                }
                column(ReturnReasonCode_SalesLine; "Sales Line"."Return Reason Code")
                {
                }
                column(AllowLineDisc_SalesLine; "Sales Line"."Allow Line Disc.")
                {
                }
                column(CustomerDiscGroup_SalesLine; "Sales Line"."Customer Disc. Group")
                {
                }
                column(MAWBNo_SalesLine; "Sales Line"."MAWB No.")
                {
                }
                column(HAWBNo_SalesLine; "Sales Line"."HAWB No.")
                {
                }
                column(DivisionCode_SalesLine; "Sales Line"."Division Code")
                {
                }
                column(SplitWeight_SalesLine; "Sales Line"."Split Weight")
                {
                }
                column(AirlineCode_SalesLine; "Sales Line"."Airline Code")
                {
                }
                column(ConsigneeCode_SalesLine; "Sales Line"."Consignee Code")
                {
                }
                column(FlightCode_SalesLine; "Sales Line"."Flight Code")
                {
                }
                column(DestinationCode_SalesLine; "Sales Line"."Destination Code")
                {
                }
                column(FlightDate_SalesLine; "Sales Line"."Flight Date")
                {
                }
                column(VATAmount_SalesLine; "Sales Line"."VAT Amount")
                {
                }
                column(CostAmount_SalesLine; "Sales Line"."Cost Amount")
                {
                }
                column(FreightChargeCode_SalesLine; "Sales Line"."Freight Charge Code")
                {
                }
                column(SplitFactor_SalesLine; "Sales Line"."Split Factor")
                {
                }
                column(FreightCost_SalesLine; "Sales Line"."Freight Cost")
                {
                }
                column(Margin_SalesLine; "Sales Line"."Margin %")
                {
                }
                column(MarginAmount_SalesLine; "Sales Line"."Margin Amount")
                {
                }
                column(FreightHandlingType_SalesLine; "Sales Line"."Freight Handling Type")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
                PreAlertHeader.RESET;
                PreAlertHeader.SETRANGE(PreAlertHeader."MAWB No", "Sales Header"."Import MAWB No.");
                IF PreAlertHeader.FINDFIRST THEN BEGIN
                    ArrivalDate := PreAlertHeader."Arrival Date FWL";
                    Item.GET(PreAlertHeader."Item No.");
                    Carrier := PreAlertHeader."Delivery Agent";
                    FileNo := PreAlertHeader."No.";
                    Qty := PreAlertHeader.Quantity;
                    Weight := PreAlertHeader.Weight;
                END;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
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
}

