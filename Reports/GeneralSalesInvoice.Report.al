report 50065 "General Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GeneralSalesInvoice.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table36)
        {
            column(CurrencyCode_SalesHeader; "Sales Header"."Currency Code")
            {
            }
            column(DocumentType_SalesHeader; "Sales Header"."Document Type")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            column(SelltoCustomerName_SalesHeader; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(DocumentDate_SalesHeader; "Sales Header"."Document Date")
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
            dataitem(DataItem1000000001; Table37)
            {
                DataItemLink = Document No.=FIELD(No.);
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
                column(CrossReferenceNo_SalesLine; "Sales Line"."Cross-Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_SalesLine; "Sales Line"."Unit of Measure (Cross Ref.)")
                {
                }
                column(CrossReferenceType_SalesLine; "Sales Line"."Cross-Reference Type")
                {
                }
                column(CrossReferenceTypeNo_SalesLine; "Sales Line"."Cross-Reference Type No.")
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
                column(ProductGroupCode_SalesLine; "Sales Line"."Product Group Code")
                {
                }
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
                CompanyInformation.CALCFIELDS(Picture);
                Customer.GET("Sales Header"."Sell-to Customer No.");
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

