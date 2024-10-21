report 50115 "Tally Purchase Import"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/TallyPurchaseImport.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "Posting Date";
            column(BuyfromVendorNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchInvHeader; "Purch. Inv. Header"."No.")
            {
            }
            column(PostingDate_PurchInvHeader; "Purch. Inv. Header"."Posting Date")
            {
            }
            column(CurrencyFactor_PurchInvHeader; XRate)
            {
            }
            column(BuyfromVendorName_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name")
            {
            }
            column(VendorInvoiceNo_PurchInvHeader; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(BuyfromVendorNo_PurchInvLine; "Purch. Inv. Line"."Buy-from Vendor No.")
                {
                }
                column(DocumentNo_PurchInvLine; "Purch. Inv. Line"."Document No.")
                {
                }
                column(LineNo_PurchInvLine; "Purch. Inv. Line"."Line No.")
                {
                }
                column(Type_PurchInvLine; "Purch. Inv. Line".Type)
                {
                }
                column(No_PurchInvLine; "Purch. Inv. Line"."No.")
                {
                }
                column(LocationCode_PurchInvLine; "Purch. Inv. Line"."Location Code")
                {
                }
                column(PostingGroup_PurchInvLine; "Purch. Inv. Line"."Posting Group")
                {
                }
                column(ExpectedReceiptDate_PurchInvLine; "Purch. Inv. Line"."Expected Receipt Date")
                {
                }
                column(Description_PurchInvLine; "Purch. Inv. Line".Description)
                {
                }
                column(Description2_PurchInvLine; "Purch. Inv. Line"."Description 2")
                {
                }
                column(UnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchInvLine; "Purch. Inv. Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchInvLine; "Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(UnitCostLCY_PurchInvLine; "Purch. Inv. Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_PurchInvLine; "Purch. Inv. Line"."VAT %")
                {
                }
                column(LineDiscount_PurchInvLine; "Purch. Inv. Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Line Discount Amount")
                {
                }
                column(Amount_PurchInvLine; "Purch. Inv. Line".Amount)
                {
                }
                column(AmountIncludingVAT_PurchInvLine; "Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(UnitPriceLCY_PurchInvLine; "Purch. Inv. Line"."Unit Price (LCY)")
                {
                }
                column(AllowInvoiceDisc_PurchInvLine; "Purch. Inv. Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_PurchInvLine; "Purch. Inv. Line"."Gross Weight")
                {
                }
                column(NetWeight_PurchInvLine; "Purch. Inv. Line"."Net Weight")
                {
                }
                column(UnitsperParcel_PurchInvLine; "Purch. Inv. Line"."Units per Parcel")
                {
                }
                column(UnitVolume_PurchInvLine; "Purch. Inv. Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_PurchInvLine; "Purch. Inv. Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_PurchInvLine; "Purch. Inv. Line"."Shortcut Dimension 2 Code")
                {
                }
                column(JobNo_PurchInvLine; "Purch. Inv. Line"."Job No.")
                {
                }
                column(IndirectCost_PurchInvLine; "Purch. Inv. Line"."Indirect Cost %")
                {
                }
                column(ReceiptNo_PurchInvLine; "Purch. Inv. Line"."Receipt No.")
                {
                }
                column(ReceiptLineNo_PurchInvLine; "Purch. Inv. Line"."Receipt Line No.")
                {
                }
                column(PaytoVendorNo_PurchInvLine; "Purch. Inv. Line"."Pay-to Vendor No.")
                {
                }
                column(InvDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Inv. Discount Amount")
                {
                }
                column(VendorItemNo_PurchInvLine; "Purch. Inv. Line"."Vendor Item No.")
                {
                }
                column(GenBusPostingGroup_PurchInvLine; "Purch. Inv. Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_PurchInvLine; "Purch. Inv. Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_PurchInvLine; "Purch. Inv. Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_PurchInvLine; "Purch. Inv. Line"."Transaction Type")
                {
                }
                column(TransportMethod_PurchInvLine; "Purch. Inv. Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_PurchInvLine; "Purch. Inv. Line"."Attached to Line No.")
                {
                }
                column(EntryPoint_PurchInvLine; "Purch. Inv. Line"."Entry Point")
                {
                }
                column(Area_PurchInvLine; "Purch. Inv. Line".Area)
                {
                }
                column(TransactionSpecification_PurchInvLine; "Purch. Inv. Line"."Transaction Specification")
                {
                }
                column(TaxAreaCode_PurchInvLine; "Purch. Inv. Line"."Tax Area Code")
                {
                }
                column(TaxLiable_PurchInvLine; "Purch. Inv. Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_PurchInvLine; "Purch. Inv. Line"."Tax Group Code")
                {
                }
                column(UseTax_PurchInvLine; "Purch. Inv. Line"."Use Tax")
                {
                }
                column(VATBusPostingGroup_PurchInvLine; "Purch. Inv. Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_PurchInvLine; "Purch. Inv. Line"."VAT Prod. Posting Group")
                {
                }
                column(BlanketOrderNo_PurchInvLine; "Purch. Inv. Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_PurchInvLine; "Purch. Inv. Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_PurchInvLine; "Purch. Inv. Line"."VAT Base Amount")
                {
                }
                column(UnitCost_PurchInvLine; "Purch. Inv. Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_PurchInvLine; "Purch. Inv. Line"."System-Created Entry")
                {
                }
                column(LineAmount_PurchInvLine; "Purch. Inv. Line"."Line Amount")
                {
                }
                column(VATDifference_PurchInvLine; "Purch. Inv. Line"."VAT Difference")
                {
                }
                column(VATIdentifier_PurchInvLine; "Purch. Inv. Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_PurchInvLine; "Purch. Inv. Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_PurchInvLine; "Purch. Inv. Line"."IC Partner Reference")
                {
                }
                column(PrepaymentLine_PurchInvLine; "Purch. Inv. Line"."Prepayment Line")
                {
                }
                column(ICPartnerCode_PurchInvLine; "Purch. Inv. Line"."IC Partner Code")
                {
                }
                column(PostingDate_PurchInvLine; "Purch. Inv. Line"."Posting Date")
                {
                }
                column(DimensionSetID_PurchInvLine; "Purch. Inv. Line"."Dimension Set ID")
                {
                }
                column(JobTaskNo_PurchInvLine; "Purch. Inv. Line"."Job Task No.")
                {
                }
                column(JobLineType_PurchInvLine; "Purch. Inv. Line"."Job Line Type")
                {
                }
                column(JobUnitPrice_PurchInvLine; "Purch. Inv. Line"."Job Unit Price")
                {
                }
                column(JobTotalPrice_PurchInvLine; "Purch. Inv. Line"."Job Total Price")
                {
                }
                column(JobLineAmount_PurchInvLine; "Purch. Inv. Line"."Job Line Amount")
                {
                }
                column(JobLineDiscountAmount_PurchInvLine; "Purch. Inv. Line"."Job Line Discount Amount")
                {
                }
                column(JobLineDiscount_PurchInvLine; "Purch. Inv. Line"."Job Line Discount %")
                {
                }
                column(JobUnitPriceLCY_PurchInvLine; "Purch. Inv. Line"."Job Unit Price (LCY)")
                {
                }
                column(JobTotalPriceLCY_PurchInvLine; "Purch. Inv. Line"."Job Total Price (LCY)")
                {
                }
                column(JobLineAmountLCY_PurchInvLine; "Purch. Inv. Line"."Job Line Amount (LCY)")
                {
                }
                column(JobLineDiscAmountLCY_PurchInvLine; "Purch. Inv. Line"."Job Line Disc. Amount (LCY)")
                {
                }
                column(JobCurrencyFactor_PurchInvLine; "Purch. Inv. Line"."Job Currency Factor")
                {
                }
                column(JobCurrencyCode_PurchInvLine; "Purch. Inv. Line"."Job Currency Code")
                {
                }
                column(ProdOrderNo_PurchInvLine; "Purch. Inv. Line"."Prod. Order No.")
                {
                }
                column(VariantCode_PurchInvLine; "Purch. Inv. Line"."Variant Code")
                {
                }
                column(BinCode_PurchInvLine; "Purch. Inv. Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_PurchInvLine; "Purch. Inv. Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_PurchInvLine; "Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_PurchInvLine; "Purch. Inv. Line"."Quantity (Base)")
                {
                }
                column(FAPostingDate_PurchInvLine; "Purch. Inv. Line"."FA Posting Date")
                {
                }
                column(FAPostingType_PurchInvLine; "Purch. Inv. Line"."FA Posting Type")
                {
                }
                column(DepreciationBookCode_PurchInvLine; "Purch. Inv. Line"."Depreciation Book Code")
                {
                }
                column(SalvageValue_PurchInvLine; "Purch. Inv. Line"."Salvage Value")
                {
                }
                column(DepruntilFAPostingDate_PurchInvLine; "Purch. Inv. Line"."Depr. until FA Posting Date")
                {
                }
                column(DeprAcquisitionCost_PurchInvLine; "Purch. Inv. Line"."Depr. Acquisition Cost")
                {
                }
                column(MaintenanceCode_PurchInvLine; "Purch. Inv. Line"."Maintenance Code")
                {
                }
                column(InsuranceNo_PurchInvLine; "Purch. Inv. Line"."Insurance No.")
                {
                }
                column(BudgetedFANo_PurchInvLine; "Purch. Inv. Line"."Budgeted FA No.")
                {
                }
                column(DuplicateinDepreciationBook_PurchInvLine; "Purch. Inv. Line"."Duplicate in Depreciation Book")
                {
                }
                column(UseDuplicationList_PurchInvLine; "Purch. Inv. Line"."Use Duplication List")
                {
                }
                column(ResponsibilityCenter_PurchInvLine; "Purch. Inv. Line"."Responsibility Center")
                {
                }
                column(CrossReferenceNo_PurchInvLine; "Purch. Inv. Line"."Item Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_PurchInvLine; "Purch. Inv. Line"."Item Reference Unit of Measure")
                {
                }
                column(CrossReferenceType_PurchInvLine; "Purch. Inv. Line"."Item Reference Type")
                {
                }
                column(CrossReferenceTypeNo_PurchInvLine; "Purch. Inv. Line"."Item Reference Type No.")
                {
                }
                column(ItemCategoryCode_PurchInvLine; "Purch. Inv. Line"."Item Category Code")
                {
                }
                column(Nonstock_PurchInvLine; "Purch. Inv. Line".Nonstock)
                {
                }
                column(PurchasingCode_PurchInvLine; "Purch. Inv. Line"."Purchasing Code")
                {
                }
                column(ProductGroupCode_PurchInvLine; "Purch. Inv. Line"."Item Category Code")
                {
                }//B2BUPG
                column(ReturnReasonCode_PurchInvLine; "Purch. Inv. Line"."Return Reason Code")
                {
                }
                column(PaymentVoucherNo_PurchInvLine; "Purch. Inv. Line"."Payment Voucher No.")
                {
                }
                column(ChargeCode_PurchInvLine; "Purch. Inv. Line"."Charge Code")
                {
                }
                column(RoutingNo_PurchInvLine; "Purch. Inv. Line"."Routing No.")
                {
                }
                column(OperationNo_PurchInvLine; "Purch. Inv. Line"."Operation No.")
                {
                }
                column(WorkCenterNo_PurchInvLine; "Purch. Inv. Line"."Work Center No.")
                {
                }
                column(ProdOrderLineNo_PurchInvLine; "Purch. Inv. Line"."Prod. Order Line No.")
                {
                }
                column(OverheadRate_PurchInvLine; "Purch. Inv. Line"."Overhead Rate")
                {
                }
                column(RoutingReferenceNo_PurchInvLine; "Purch. Inv. Line"."Routing Reference No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                XRate := 0;
                IF "Purch. Inv. Header"."Currency Factor" <> 0 THEN
                    XRate := 1 / "Purch. Inv. Header"."Currency Factor"
                ELSE
                    XRate := 1;
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
        XRate: Decimal;
}

