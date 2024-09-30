report 50051 "MAWB Sales Purch. Comp"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/MAWBSalesPurchComp.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Header 2"; "MAWB Header 2")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            column(No_MAWBHeader; "MAWB Header 2"."No.")
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "MAWB No."=FIELD("No.");
                DataItemTableView = WHERE("MAWB No."=FILTER(<>''));
                RequestFilterHeading = 'Posting Date';
                column(SelltoCustomerNo_SalesInvoiceLine;"Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesInvoiceLine;"Sales Invoice Line"."Document No.")
                {
                }
                column(LineNo_SalesInvoiceLine;"Sales Invoice Line"."Line No.")
                {
                }
                column(Type_SalesInvoiceLine;"Sales Invoice Line".Type)
                {
                }
                column(No_SalesInvoiceLine;"Sales Invoice Line"."No.")
                {
                }
                column(LocationCode_SalesInvoiceLine;"Sales Invoice Line"."Location Code")
                {
                }
                column(PostingGroup_SalesInvoiceLine;"Sales Invoice Line"."Posting Group")
                {
                }
                column(ShipmentDate_SalesInvoiceLine;"Sales Invoice Line"."Shipment Date")
                {
                }
                column(Description_SalesInvoiceLine;"Sales Invoice Line".Description)
                {
                }
                column(Description2_SalesInvoiceLine;"Sales Invoice Line"."Description 2")
                {
                }
                column(UnitofMeasure_SalesInvoiceLine;"Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesInvoiceLine;"Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine;"Sales Invoice Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesInvoiceLine;"Sales Invoice Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_SalesInvoiceLine;"Sales Invoice Line"."VAT %")
                {
                }
                column(LineDiscount_SalesInvoiceLine;"Sales Invoice Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesInvoiceLine;"Sales Invoice Line"."Line Discount Amount")
                {
                }
                column(Amount_SalesInvoiceLine;"Sales Invoice Line".Amount)
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine;"Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(AllowInvoiceDisc_SalesInvoiceLine;"Sales Invoice Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_SalesInvoiceLine;"Sales Invoice Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesInvoiceLine;"Sales Invoice Line"."Net Weight")
                {
                }
                column(UnitsperParcel_SalesInvoiceLine;"Sales Invoice Line"."Units per Parcel")
                {
                }
                column(UnitVolume_SalesInvoiceLine;"Sales Invoice Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_SalesInvoiceLine;"Sales Invoice Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_SalesInvoiceLine;"Sales Invoice Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_SalesInvoiceLine;"Sales Invoice Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPriceGroup_SalesInvoiceLine;"Sales Invoice Line"."Customer Price Group")
                {
                }
                column(JobNo_SalesInvoiceLine;"Sales Invoice Line"."Job No.")
                {
                }
                column(WorkTypeCode_SalesInvoiceLine;"Sales Invoice Line"."Work Type Code")
                {
                }
                column(ShipmentNo_SalesInvoiceLine;"Sales Invoice Line"."Shipment No.")
                {
                }
                column(ShipmentLineNo_SalesInvoiceLine;"Sales Invoice Line"."Shipment Line No.")
                {
                }
                column(BilltoCustomerNo_SalesInvoiceLine;"Sales Invoice Line"."Bill-to Customer No.")
                {
                }
                column(InvDiscountAmount_SalesInvoiceLine;"Sales Invoice Line"."Inv. Discount Amount")
                {
                }
                column(DropShipment_SalesInvoiceLine;"Sales Invoice Line"."Drop Shipment")
                {
                }
                column(GenBusPostingGroup_SalesInvoiceLine;"Sales Invoice Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_SalesInvoiceLine;"Sales Invoice Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_SalesInvoiceLine;"Sales Invoice Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_SalesInvoiceLine;"Sales Invoice Line"."Transaction Type")
                {
                }
                column(TransportMethod_SalesInvoiceLine;"Sales Invoice Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_SalesInvoiceLine;"Sales Invoice Line"."Attached to Line No.")
                {
                }
                column(ExitPoint_SalesInvoiceLine;"Sales Invoice Line"."Exit Point")
                {
                }
                column(Area_SalesInvoiceLine;"Sales Invoice Line".Area)
                {
                }
                column(TransactionSpecification_SalesInvoiceLine;"Sales Invoice Line"."Transaction Specification")
                {
                }
                column(TaxAreaCode_SalesInvoiceLine;"Sales Invoice Line"."Tax Area Code")
                {
                }
                column(TaxLiable_SalesInvoiceLine;"Sales Invoice Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_SalesInvoiceLine;"Sales Invoice Line"."Tax Group Code")
                {
                }
                column(VATClauseCode_SalesInvoiceLine;"Sales Invoice Line"."VAT Clause Code")
                {
                }
                column(VATBusPostingGroup_SalesInvoiceLine;"Sales Invoice Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_SalesInvoiceLine;"Sales Invoice Line"."VAT Prod. Posting Group")
                {
                }
                column(BlanketOrderNo_SalesInvoiceLine;"Sales Invoice Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_SalesInvoiceLine;"Sales Invoice Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_SalesInvoiceLine;"Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(UnitCost_SalesInvoiceLine;"Sales Invoice Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_SalesInvoiceLine;"Sales Invoice Line"."System-Created Entry")
                {
                }
                column(LineAmount_SalesInvoiceLine;"Sales Invoice Line"."Line Amount")
                {
                }
                column(VATDifference_SalesInvoiceLine;"Sales Invoice Line"."VAT Difference")
                {
                }
                column(VATIdentifier_SalesInvoiceLine;"Sales Invoice Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_SalesInvoiceLine;"Sales Invoice Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_SalesInvoiceLine;"Sales Invoice Line"."IC Partner Reference")
                {
                }
                column(PrepaymentLine_SalesInvoiceLine;"Sales Invoice Line"."Prepayment Line")
                {
                }
                column(ICPartnerCode_SalesInvoiceLine;"Sales Invoice Line"."IC Partner Code")
                {
                }
                column(PostingDate_SalesInvoiceLine;"Sales Invoice Line"."Posting Date")
                {
                }
                column(DimensionSetID_SalesInvoiceLine;"Sales Invoice Line"."Dimension Set ID")
                {
                }
                column(JobTaskNo_SalesInvoiceLine;"Sales Invoice Line"."Job Task No.")
                {
                }
                column(JobContractEntryNo_SalesInvoiceLine;"Sales Invoice Line"."Job Contract Entry No.")
                {
                }
                column(VariantCode_SalesInvoiceLine;"Sales Invoice Line"."Variant Code")
                {
                }
                column(BinCode_SalesInvoiceLine;"Sales Invoice Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_SalesInvoiceLine;"Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine;"Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_SalesInvoiceLine;"Sales Invoice Line"."Quantity (Base)")
                {
                }
                column(FAPostingDate_SalesInvoiceLine;"Sales Invoice Line"."FA Posting Date")
                {
                }
                column(DepreciationBookCode_SalesInvoiceLine;"Sales Invoice Line"."Depreciation Book Code")
                {
                }
                column(DepruntilFAPostingDate_SalesInvoiceLine;"Sales Invoice Line"."Depr. until FA Posting Date")
                {
                }
                column(DuplicateinDepreciationBook_SalesInvoiceLine;"Sales Invoice Line"."Duplicate in Depreciation Book")
                {
                }
                column(UseDuplicationList_SalesInvoiceLine;"Sales Invoice Line"."Use Duplication List")
                {
                }
                column(ResponsibilityCenter_SalesInvoiceLine;"Sales Invoice Line"."Responsibility Center")
                {
                }
                column(CrossReferenceNo_SalesInvoiceLine;"Sales Invoice Line"."Item Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_SalesInvoiceLine;"Sales Invoice Line"."Item Reference Unit of Measure")
                {
                }
                column(CrossReferenceType_SalesInvoiceLine;"Sales Invoice Line"."Item Reference Type")
                {
                }
                column(CrossReferenceTypeNo_SalesInvoiceLine;"Sales Invoice Line"."Item Reference Type No.")
                {
                }
                column(ItemCategoryCode_SalesInvoiceLine;"Sales Invoice Line"."Item Category Code")
                {
                }
                column(Nonstock_SalesInvoiceLine;"Sales Invoice Line".Nonstock)
                {
                }
                column(PurchasingCode_SalesInvoiceLine;"Sales Invoice Line"."Purchasing Code")
                {
                }
                column(ProductGroupCode_SalesInvoiceLine;"Sales Invoice Line"."Item Category Code")
                {
                }//b2BUPG
                column(ApplfromItemEntry_SalesInvoiceLine;"Sales Invoice Line"."Appl.-from Item Entry")
                {
                }
                column(ReturnReasonCode_SalesInvoiceLine;"Sales Invoice Line"."Return Reason Code")
                {
                }
                column(AllowLineDisc_SalesInvoiceLine;"Sales Invoice Line"."Allow Line Disc.")
                {
                }
                column(CustomerDiscGroup_SalesInvoiceLine;"Sales Invoice Line"."Customer Disc. Group")
                {
                }
                column(MAWBNo_SalesInvoiceLine;"Sales Invoice Line"."MAWB No.")
                {
                }
                column(HAWBNo_SalesInvoiceLine;"Sales Invoice Line"."HAWB No.")
                {
                }
                column(DivisionCode_SalesInvoiceLine;"Sales Invoice Line"."Division Code")
                {
                }
                column(SplitWeight_SalesInvoiceLine;"Sales Invoice Line"."Split Weight")
                {
                }
                column(AirlineCode_SalesInvoiceLine;"Sales Invoice Line"."Airline Code")
                {
                }
                column(ConsigneeCode_SalesInvoiceLine;"Sales Invoice Line"."Consignee Code")
                {
                }
                column(FlightCode_SalesInvoiceLine;"Sales Invoice Line"."Flight Code")
                {
                }
                column(DestinationCode_SalesInvoiceLine;"Sales Invoice Line"."Destination Code")
                {
                }
                column(FlightDate_SalesInvoiceLine;"Sales Invoice Line"."Flight Date")
                {
                }
                column(VATAmount_SalesInvoiceLine;"Sales Invoice Line"."VAT Amount")
                {
                }
                column(CostAmount_SalesInvoiceLine;"Sales Invoice Line"."Cost Amount")
                {
                }
                column(FreightChargeCode_SalesInvoiceLine;"Sales Invoice Line"."Freight Charge Code")
                {
                }
                column(SplitFactor_SalesInvoiceLine;"Sales Invoice Line"."Split Factor")
                {
                }
                column(FreightCost_SalesInvoiceLine;"Sales Invoice Line"."Freight Cost")
                {
                }
                column(Margin_SalesInvoiceLine;"Sales Invoice Line"."Margin %")
                {
                }
                column(MarginAmount_SalesInvoiceLine;"Sales Invoice Line"."Margin Amount")
                {
                }
                column(CutomerName;Cust.Name)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    WITH "Sales Invoice Line"DO
                    BEGIN
                      IF "Sales Invoice Line"."Sell-to Customer No."<>'' THEN
                        Cust.GET("Sales Invoice Line"."Sell-to Customer No.");
                    END;
                end;
            }
            dataitem("Purch. Inv. Line";"Purch. Inv. Line")
            {
                DataItemLink = "Payment Voucher No."=FIELD("No.");
                DataItemTableView = SORTING("Document No.","Line No.")
                                    ORDER(Ascending)
                                    WHERE("Payment Voucher No."=FILTER(<>''));
                column(AirlineName;Airlines.Name)
                {
                }
                column(BuyfromVendorNo_PurchInvLine;"Purch. Inv. Line"."Buy-from Vendor No.")
                {
                }
                column(DocumentNo_PurchInvLine;"Purch. Inv. Line"."Document No.")
                {
                }
                column(LineNo_PurchInvLine;"Purch. Inv. Line"."Line No.")
                {
                }
                column(Type_PurchInvLine;"Purch. Inv. Line".Type)
                {
                }
                column(No_PurchInvLine;"Purch. Inv. Line"."No.")
                {
                }
                column(LocationCode_PurchInvLine;"Purch. Inv. Line"."Location Code")
                {
                }
                column(PostingGroup_PurchInvLine;"Purch. Inv. Line"."Posting Group")
                {
                }
                column(ExpectedReceiptDate_PurchInvLine;"Purch. Inv. Line"."Expected Receipt Date")
                {
                }
                column(Description_PurchInvLine;"Purch. Inv. Line".Description)
                {
                }
                column(Description2_PurchInvLine;"Purch. Inv. Line"."Description 2")
                {
                }
                column(UnitofMeasure_PurchInvLine;"Purch. Inv. Line"."Unit of Measure")
                {
                }
                column(Quantity_PurchInvLine;"Purch. Inv. Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchInvLine;"Purch. Inv. Line"."Direct Unit Cost")
                {
                }
                column(UnitCostLCY_PurchInvLine;"Purch. Inv. Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_PurchInvLine;"Purch. Inv. Line"."VAT %")
                {
                }
                column(LineDiscount_PurchInvLine;"Purch. Inv. Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchInvLine;"Purch. Inv. Line"."Line Discount Amount")
                {
                }
                column(Amount_PurchInvLine;"Purch. Inv. Line".Amount)
                {
                }
                column(AmountIncludingVAT_PurchInvLine;"Purch. Inv. Line"."Amount Including VAT")
                {
                }
                column(UnitPriceLCY_PurchInvLine;"Purch. Inv. Line"."Unit Price (LCY)")
                {
                }
                column(AllowInvoiceDisc_PurchInvLine;"Purch. Inv. Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_PurchInvLine;"Purch. Inv. Line"."Gross Weight")
                {
                }
                column(NetWeight_PurchInvLine;"Purch. Inv. Line"."Net Weight")
                {
                }
                column(UnitsperParcel_PurchInvLine;"Purch. Inv. Line"."Units per Parcel")
                {
                }
                column(UnitVolume_PurchInvLine;"Purch. Inv. Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_PurchInvLine;"Purch. Inv. Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_PurchInvLine;"Purch. Inv. Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_PurchInvLine;"Purch. Inv. Line"."Shortcut Dimension 2 Code")
                {
                }
                column(JobNo_PurchInvLine;"Purch. Inv. Line"."Job No.")
                {
                }
                column(IndirectCost_PurchInvLine;"Purch. Inv. Line"."Indirect Cost %")
                {
                }
                column(ReceiptNo_PurchInvLine;"Purch. Inv. Line"."Receipt No.")
                {
                }
                column(ReceiptLineNo_PurchInvLine;"Purch. Inv. Line"."Receipt Line No.")
                {
                }
                column(PaytoVendorNo_PurchInvLine;"Purch. Inv. Line"."Pay-to Vendor No.")
                {
                }
                column(InvDiscountAmount_PurchInvLine;"Purch. Inv. Line"."Inv. Discount Amount")
                {
                }
                column(VendorItemNo_PurchInvLine;"Purch. Inv. Line"."Vendor Item No.")
                {
                }
                column(GenBusPostingGroup_PurchInvLine;"Purch. Inv. Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_PurchInvLine;"Purch. Inv. Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_PurchInvLine;"Purch. Inv. Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_PurchInvLine;"Purch. Inv. Line"."Transaction Type")
                {
                }
                column(TransportMethod_PurchInvLine;"Purch. Inv. Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_PurchInvLine;"Purch. Inv. Line"."Attached to Line No.")
                {
                }
                column(EntryPoint_PurchInvLine;"Purch. Inv. Line"."Entry Point")
                {
                }
                column(Area_PurchInvLine;"Purch. Inv. Line".Area)
                {
                }
                column(TransactionSpecification_PurchInvLine;"Purch. Inv. Line"."Transaction Specification")
                {
                }
                column(TaxAreaCode_PurchInvLine;"Purch. Inv. Line"."Tax Area Code")
                {
                }
                column(TaxLiable_PurchInvLine;"Purch. Inv. Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_PurchInvLine;"Purch. Inv. Line"."Tax Group Code")
                {
                }
                column(UseTax_PurchInvLine;"Purch. Inv. Line"."Use Tax")
                {
                }
                column(VATBusPostingGroup_PurchInvLine;"Purch. Inv. Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_PurchInvLine;"Purch. Inv. Line"."VAT Prod. Posting Group")
                {
                }
                column(BlanketOrderNo_PurchInvLine;"Purch. Inv. Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_PurchInvLine;"Purch. Inv. Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_PurchInvLine;"Purch. Inv. Line"."VAT Base Amount")
                {
                }
                column(UnitCost_PurchInvLine;"Purch. Inv. Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_PurchInvLine;"Purch. Inv. Line"."System-Created Entry")
                {
                }
                column(LineAmount_PurchInvLine;"Purch. Inv. Line"."Line Amount")
                {
                }
                column(VATDifference_PurchInvLine;"Purch. Inv. Line"."VAT Difference")
                {
                }
                column(VATIdentifier_PurchInvLine;"Purch. Inv. Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_PurchInvLine;"Purch. Inv. Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_PurchInvLine;"Purch. Inv. Line"."IC Partner Reference")
                {
                }
                column(PrepaymentLine_PurchInvLine;"Purch. Inv. Line"."Prepayment Line")
                {
                }
                column(ICPartnerCode_PurchInvLine;"Purch. Inv. Line"."IC Partner Code")
                {
                }
                column(PostingDate_PurchInvLine;"Purch. Inv. Line"."Posting Date")
                {
                }
                column(DimensionSetID_PurchInvLine;"Purch. Inv. Line"."Dimension Set ID")
                {
                }
                column(JobTaskNo_PurchInvLine;"Purch. Inv. Line"."Job Task No.")
                {
                }
                column(JobLineType_PurchInvLine;"Purch. Inv. Line"."Job Line Type")
                {
                }
                column(JobUnitPrice_PurchInvLine;"Purch. Inv. Line"."Job Unit Price")
                {
                }
                column(JobTotalPrice_PurchInvLine;"Purch. Inv. Line"."Job Total Price")
                {
                }
                column(JobLineAmount_PurchInvLine;"Purch. Inv. Line"."Job Line Amount")
                {
                }
                column(JobLineDiscountAmount_PurchInvLine;"Purch. Inv. Line"."Job Line Discount Amount")
                {
                }
                column(JobLineDiscount_PurchInvLine;"Purch. Inv. Line"."Job Line Discount %")
                {
                }
                column(JobUnitPriceLCY_PurchInvLine;"Purch. Inv. Line"."Job Unit Price (LCY)")
                {
                }
                column(JobTotalPriceLCY_PurchInvLine;"Purch. Inv. Line"."Job Total Price (LCY)")
                {
                }
                column(JobLineAmountLCY_PurchInvLine;"Purch. Inv. Line"."Job Line Amount (LCY)")
                {
                }
                column(JobLineDiscAmountLCY_PurchInvLine;"Purch. Inv. Line"."Job Line Disc. Amount (LCY)")
                {
                }
                column(JobCurrencyFactor_PurchInvLine;"Purch. Inv. Line"."Job Currency Factor")
                {
                }
                column(JobCurrencyCode_PurchInvLine;"Purch. Inv. Line"."Job Currency Code")
                {
                }
                column(ProdOrderNo_PurchInvLine;"Purch. Inv. Line"."Prod. Order No.")
                {
                }
                column(VariantCode_PurchInvLine;"Purch. Inv. Line"."Variant Code")
                {
                }
                column(BinCode_PurchInvLine;"Purch. Inv. Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_PurchInvLine;"Purch. Inv. Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_PurchInvLine;"Purch. Inv. Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_PurchInvLine;"Purch. Inv. Line"."Quantity (Base)")
                {
                }
                column(FAPostingDate_PurchInvLine;"Purch. Inv. Line"."FA Posting Date")
                {
                }
                column(FAPostingType_PurchInvLine;"Purch. Inv. Line"."FA Posting Type")
                {
                }
                column(DepreciationBookCode_PurchInvLine;"Purch. Inv. Line"."Depreciation Book Code")
                {
                }
                column(SalvageValue_PurchInvLine;"Purch. Inv. Line"."Salvage Value")
                {
                }
                column(DepruntilFAPostingDate_PurchInvLine;"Purch. Inv. Line"."Depr. until FA Posting Date")
                {
                }
                column(DeprAcquisitionCost_PurchInvLine;"Purch. Inv. Line"."Depr. Acquisition Cost")
                {
                }
                column(MaintenanceCode_PurchInvLine;"Purch. Inv. Line"."Maintenance Code")
                {
                }
                column(InsuranceNo_PurchInvLine;"Purch. Inv. Line"."Insurance No.")
                {
                }
                column(BudgetedFANo_PurchInvLine;"Purch. Inv. Line"."Budgeted FA No.")
                {
                }
                column(DuplicateinDepreciationBook_PurchInvLine;"Purch. Inv. Line"."Duplicate in Depreciation Book")
                {
                }
                column(UseDuplicationList_PurchInvLine;"Purch. Inv. Line"."Use Duplication List")
                {
                }
                column(ResponsibilityCenter_PurchInvLine;"Purch. Inv. Line"."Responsibility Center")
                {
                }
                column(CrossReferenceNo_PurchInvLine;"Purch. Inv. Line"."Item Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_PurchInvLine;"Purch. Inv. Line"."Item Reference Unit of Measure")
                {
                }
                column(CrossReferenceType_PurchInvLine;"Purch. Inv. Line"."Item Reference Type")
                {
                }
                column(CrossReferenceTypeNo_PurchInvLine;"Purch. Inv. Line"."Item Reference Type No.")
                {
                }
                column(ItemCategoryCode_PurchInvLine;"Purch. Inv. Line"."Item Category Code")
                {
                }
                column(Nonstock_PurchInvLine;"Purch. Inv. Line".Nonstock)
                {
                }
                column(PurchasingCode_PurchInvLine;"Purch. Inv. Line"."Purchasing Code")
                {
                }
                column(ProductGroupCode_PurchInvLine;"Purch. Inv. Line"."Item Category Code")
                {
                }//b2BUPG
                column(ReturnReasonCode_PurchInvLine;"Purch. Inv. Line"."Return Reason Code")
                {
                }
                column(PaymentVoucherNo_PurchInvLine;"Purch. Inv. Line"."Payment Voucher No.")
                {
                }
                column(ChargeCode_PurchInvLine;"Purch. Inv. Line"."Charge Code")
                {
                }
                column(RoutingNo_PurchInvLine;"Purch. Inv. Line"."Routing No.")
                {
                }
                column(OperationNo_PurchInvLine;"Purch. Inv. Line"."Operation No.")
                {
                }
                column(WorkCenterNo_PurchInvLine;"Purch. Inv. Line"."Work Center No.")
                {
                }
                column(ProdOrderLineNo_PurchInvLine;"Purch. Inv. Line"."Prod. Order Line No.")
                {
                }
                column(OverheadRate_PurchInvLine;"Purch. Inv. Line"."Overhead Rate")
                {
                }
                column(RoutingReferenceNo_PurchInvLine;"Purch. Inv. Line"."Routing Reference No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    WITH "Purch. Inv. Line"DO BEGIN
                      IF "Purch. Inv. Line"."Shortcut Dimension 1 Code"<>'' THEN
                      Airlines.GET("Purch. Inv. Line"."Shortcut Dimension 1 Code");
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
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
        Airlines: Record Airline;
        Cust: Record Customer;
}

