report 50052 "Airline Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AirlinePayments.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {
            DataItemTableView = WHERE("Airline Code" = FILTER(<> ''));
            column("Filter"; Filter)
            {
            }
            column(Logo; CompanyInformation.Picture)
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
            column(PrefixCode_MAWBReceipt; "MAWB Receipt"."Prefix Code")
            {
            }
            column(BillNo_MAWBReceipt; "MAWB Receipt"."Bill No.")
            {
            }
            column(StartNo_MAWBReceipt; "MAWB Receipt"."Start No.")
            {
            }
            column(EndNo_MAWBReceipt; "MAWB Receipt"."End No.")
            {
            }
            column(KAAFees_MAWBReceipt; "MAWB Receipt"."KAA Fees")
            {
            }
            column(Invoiced_MAWBReceipt; "MAWB Receipt".Invoiced)
            {
            }
            column(AssignedDate_MAWBReceipt; "MAWB Receipt"."Assigned Date")
            {
            }
            column(InviocedDate_MAWBReceipt; "MAWB Receipt"."Invioced Date")
            {
            }
            column(PreparedDate_MAWBReceipt; "MAWB Receipt"."Prepared Date")
            {
            }
            column(AirlineName; Airline.Name)
            {
            }
            column(ShowSummary; Summary)
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Payment Voucher No." = FIELD("MAWB No.");
                column(ShippedWeight; ShippedWeight)
                {
                }
                column(VendorName; Vendors."Search Name")
                {
                }
                column(Prod; Item.Description)
                {
                }
                column(Curr; PurchInvHeader."Currency Code")
                {
                }
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
                }//B2BUPG prdtcatgorycode
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
                column(AmountLCY; gDecAmountLCY)
                {
                }
                column(PaymentDocumentNo; gCodeDocumentNo)
                {
                }
                column(PaymentDate; gDatePaymentDate)
                {
                }
                column(PaymentAmount; gDecPaymentAmount)
                {
                }
                column(PaymentAmountLCY; gDecPaymentAmtLCY)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ShippedWeight := 0;
                    PurchInvHeader.GET("Purch. Inv. Line"."Document No.");
                    IF Vendors.GET("Purch. Inv. Line"."Buy-from Vendor No.") THEN;
                    MAWBInvoiceCharge.RESET;
                    MAWBInvoiceCharge.SETRANGE(MAWBInvoiceCharge."MAWB No.", "Purch. Inv. Line"."Payment Voucher No.");
                    MAWBInvoiceCharge.SETFILTER(MAWBInvoiceCharge."Chargeable Weight", '<>%1', 0);
                    IF MAWBInvoiceCharge.FINDFIRST THEN BEGIN
                        ShippedWeight := MAWBInvoiceCharge."Chargeable Weight";
                    END;


                    //Payment Amount, DocumentNo, Date
                    gCodeDocumentNo := '';
                    CLEAR(gDatePaymentDate);
                    gDecPaymentAmount := 0;
                    gRecVendorLedgerEntry.RESET;
                    gRecVendorLedgerEntry.SETRANGE("Document No.", "Purch. Inv. Line"."Document No.");
                    IF gRecVendorLedgerEntry.FINDFIRST THEN BEGIN
                        gRecDtldVendLedgerEntry.RESET;
                        gRecDtldVendLedgerEntry.SETRANGE("Vendor Ledger Entry No.", gRecVendorLedgerEntry."Entry No.");
                        gRecDtldVendLedgerEntry.SETRANGE("Document Type", gRecDtldVendLedgerEntry."Document Type"::Payment);
                        IF gRecDtldVendLedgerEntry.FINDFIRST THEN BEGIN
                            gCodeDocumentNo := gRecDtldVendLedgerEntry."Document No.";
                            gDatePaymentDate := gRecDtldVendLedgerEntry."Posting Date";
                            gDecPaymentAmount := gRecDtldVendLedgerEntry.Amount;
                        END;
                    END;

                    //Calculate LCY Amount
                    gDecPaymentAmtLCY := 0;
                    gDecAmountLCY := 0;
                    IF PurchInvHeader."Currency Factor" <> 0 THEN BEGIN
                        gDecAmountLCY := "Purch. Inv. Line".Amount * 1 / PurchInvHeader."Currency Factor";
                        gDecPaymentAmtLCY := gDecPaymentAmount * 1 / PurchInvHeader."Currency Factor";
                    END ELSE BEGIN
                        gDecAmountLCY := "Purch. Inv. Line".Amount;
                        gDecPaymentAmtLCY := gDecPaymentAmount
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.CALCFIELDS(Picture);
                Airline.GET("MAWB Receipt"."Airline Code");
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "MAWB Receipt"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    //  Customer.GET(BookingSheetMAWBAllocation."Shipper Code");
                    Item.GET(BookingSheetMAWBAllocation."Item No");
                END;
            end;

            trigger OnPreDataItem()
            begin
                Filter := "MAWB Receipt".GETFILTERS;
                CompanyInformation.GET();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Show As")
                {
                    field("Show Summarized"; Summary)
                    {
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

    var
        CompanyInformation: Record 79;
        PurchInvHeader: Record 122;
        Airline: Record 50021;
        "Filter": Text[250];
        Summary: Boolean;
        Vendors: Record 23;
        MAWBInvoiceCharge: Record 50073;
        ShippedWeight: Decimal;
        BookingSheetMAWBAllocation: Record 50070;
        Customer: Record 18;
        Item: Record 27;
        gRecCurrExch: Record 330;
        gDecAmountLCY: Decimal;
        gCodeDocumentNo: Code[50];
        gDatePaymentDate: Date;
        gDecPaymentAmount: Decimal;
        gRecVendorLedgerEntry: Record 25;
        gRecDtldVendLedgerEntry: Record 380;
        gDecPaymentAmtLCY: Decimal;
}

