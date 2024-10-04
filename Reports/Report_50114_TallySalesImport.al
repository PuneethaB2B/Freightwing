report 50114 "Tally Sales Import"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/TallySalesImport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date";
            column(AmountIncludingVAT_SalesInvoiceHeader; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(CurrencyFactor_SalesInvoiceHeader; XRate)
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Sales Invoice Header"."Posting Date")
            {
            }
            column(CurrencyCode_SalesInvoiceHeader; "Sales Invoice Header"."Currency Code")
            {
            }
            column(BilledToname; Customer.Name)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(ItemName; Item.Description)
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(SelltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Sell-to Customer No.")
                {
                }
                column(DocumentNo_SalesInvoiceLine; "Sales Invoice Line"."Document No.")
                {
                }
                column(LineNo_SalesInvoiceLine; "Sales Invoice Line"."Line No.")
                {
                }
                column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                {
                }
                column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                {
                }
                column(LocationCode_SalesInvoiceLine; "Sales Invoice Line"."Location Code")
                {
                }
                column(PostingGroup_SalesInvoiceLine; "Sales Invoice Line"."Posting Group")
                {
                }
                column(ShipmentDate_SalesInvoiceLine; "Sales Invoice Line"."Shipment Date")
                {
                }
                column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                {
                }
                column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                {
                }
                column(UnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure")
                {
                }
                column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                {
                }
                column(UnitCostLCY_SalesInvoiceLine; "Sales Invoice Line"."Unit Cost (LCY)")
                {
                }
                column(VAT_SalesInvoiceLine; "Sales Invoice Line"."VAT %")
                {
                }
                column(LineDiscount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount %")
                {
                }
                column(LineDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Discount Amount")
                {
                }
                column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                {
                }
                column(AllowInvoiceDisc_SalesInvoiceLine; "Sales Invoice Line"."Allow Invoice Disc.")
                {
                }
                column(GrossWeight_SalesInvoiceLine; "Sales Invoice Line"."Gross Weight")
                {
                }
                column(NetWeight_SalesInvoiceLine; "Sales Invoice Line"."Net Weight")
                {
                }
                column(UnitsperParcel_SalesInvoiceLine; "Sales Invoice Line"."Units per Parcel")
                {
                }
                column(UnitVolume_SalesInvoiceLine; "Sales Invoice Line"."Unit Volume")
                {
                }
                column(AppltoItemEntry_SalesInvoiceLine; "Sales Invoice Line"."Appl.-to Item Entry")
                {
                }
                column(ShortcutDimension1Code_SalesInvoiceLine; "Sales Invoice Line"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_SalesInvoiceLine; "Sales Invoice Line"."Shortcut Dimension 2 Code")
                {
                }
                column(CustomerPriceGroup_SalesInvoiceLine; "Sales Invoice Line"."Customer Price Group")
                {
                }
                column(JobNo_SalesInvoiceLine; "Sales Invoice Line"."Job No.")
                {
                }
                column(WorkTypeCode_SalesInvoiceLine; "Sales Invoice Line"."Work Type Code")
                {
                }
                column(ShipmentNo_SalesInvoiceLine; "Sales Invoice Line"."Shipment No.")
                {
                }
                column(ShipmentLineNo_SalesInvoiceLine; "Sales Invoice Line"."Shipment Line No.")
                {
                }
                column(BilltoCustomerNo_SalesInvoiceLine; "Sales Invoice Line"."Bill-to Customer No.")
                {
                }
                column(InvDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Inv. Discount Amount")
                {
                }
                column(DropShipment_SalesInvoiceLine; "Sales Invoice Line"."Drop Shipment")
                {
                }
                column(GenBusPostingGroup_SalesInvoiceLine; "Sales Invoice Line"."Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_SalesInvoiceLine; "Sales Invoice Line"."Gen. Prod. Posting Group")
                {
                }
                column(VATCalculationType_SalesInvoiceLine; "Sales Invoice Line"."VAT Calculation Type")
                {
                }
                column(TransactionType_SalesInvoiceLine; "Sales Invoice Line"."Transaction Type")
                {
                }
                column(TransportMethod_SalesInvoiceLine; "Sales Invoice Line"."Transport Method")
                {
                }
                column(AttachedtoLineNo_SalesInvoiceLine; "Sales Invoice Line"."Attached to Line No.")
                {
                }
                column(ExitPoint_SalesInvoiceLine; "Sales Invoice Line"."Exit Point")
                {
                }
                column(Area_SalesInvoiceLine; "Sales Invoice Line".Area)
                {
                }
                column(TransactionSpecification_SalesInvoiceLine; "Sales Invoice Line"."Transaction Specification")
                {
                }
                column(TaxAreaCode_SalesInvoiceLine; "Sales Invoice Line"."Tax Area Code")
                {
                }
                column(TaxLiable_SalesInvoiceLine; "Sales Invoice Line"."Tax Liable")
                {
                }
                column(TaxGroupCode_SalesInvoiceLine; "Sales Invoice Line"."Tax Group Code")
                {
                }
                column(VATClauseCode_SalesInvoiceLine; "Sales Invoice Line"."VAT Clause Code")
                {
                }
                column(VATBusPostingGroup_SalesInvoiceLine; "Sales Invoice Line"."VAT Bus. Posting Group")
                {
                }
                column(VATProdPostingGroup_SalesInvoiceLine; "Sales Invoice Line"."VAT Prod. Posting Group")
                {
                }
                column(BlanketOrderNo_SalesInvoiceLine; "Sales Invoice Line"."Blanket Order No.")
                {
                }
                column(BlanketOrderLineNo_SalesInvoiceLine; "Sales Invoice Line"."Blanket Order Line No.")
                {
                }
                column(VATBaseAmount_SalesInvoiceLine; "Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(UnitCost_SalesInvoiceLine; "Sales Invoice Line"."Unit Cost")
                {
                }
                column(SystemCreatedEntry_SalesInvoiceLine; "Sales Invoice Line"."System-Created Entry")
                {
                }
                column(LineAmount_SalesInvoiceLine; "Sales Invoice Line"."Line Amount")
                {
                }
                column(VATDifference_SalesInvoiceLine; "Sales Invoice Line"."VAT Difference")
                {
                }
                column(VATIdentifier_SalesInvoiceLine; "Sales Invoice Line"."VAT Identifier")
                {
                }
                column(ICPartnerRefType_SalesInvoiceLine; "Sales Invoice Line"."IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_SalesInvoiceLine; "Sales Invoice Line"."IC Partner Reference")
                {
                }
                column(PrepaymentLine_SalesInvoiceLine; "Sales Invoice Line"."Prepayment Line")
                {
                }
                column(ICPartnerCode_SalesInvoiceLine; "Sales Invoice Line"."IC Partner Code")
                {
                }
                column(PostingDate_SalesInvoiceLine; "Sales Invoice Line"."Posting Date")
                {
                }
                column(DimensionSetID_SalesInvoiceLine; "Sales Invoice Line"."Dimension Set ID")
                {
                }
                column(JobTaskNo_SalesInvoiceLine; "Sales Invoice Line"."Job Task No.")
                {
                }
                column(JobContractEntryNo_SalesInvoiceLine; "Sales Invoice Line"."Job Contract Entry No.")
                {
                }
                column(VariantCode_SalesInvoiceLine; "Sales Invoice Line"."Variant Code")
                {
                }
                column(BinCode_SalesInvoiceLine; "Sales Invoice Line"."Bin Code")
                {
                }
                column(QtyperUnitofMeasure_SalesInvoiceLine; "Sales Invoice Line"."Qty. per Unit of Measure")
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Sales Invoice Line"."Unit of Measure Code")
                {
                }
                column(QuantityBase_SalesInvoiceLine; "Sales Invoice Line"."Quantity (Base)")
                {
                }
                column(FAPostingDate_SalesInvoiceLine; "Sales Invoice Line"."FA Posting Date")
                {
                }
                column(DepreciationBookCode_SalesInvoiceLine; "Sales Invoice Line"."Depreciation Book Code")
                {
                }
                column(DepruntilFAPostingDate_SalesInvoiceLine; "Sales Invoice Line"."Depr. until FA Posting Date")
                {
                }
                column(DuplicateinDepreciationBook_SalesInvoiceLine; "Sales Invoice Line"."Duplicate in Depreciation Book")
                {
                }
                column(UseDuplicationList_SalesInvoiceLine; "Sales Invoice Line"."Use Duplication List")
                {
                }
                column(ResponsibilityCenter_SalesInvoiceLine; "Sales Invoice Line"."Responsibility Center")
                {
                }
                column(CrossReferenceNo_SalesInvoiceLine; "Sales Invoice Line"."Item Reference No.")
                {
                }
                column(UnitofMeasureCrossRef_SalesInvoiceLine; "Sales Invoice Line"."Item Reference Unit of Measure")
                {
                }
                column(CrossReferenceType_SalesInvoiceLine; "Sales Invoice Line"."Item Reference Type")
                {
                }
                column(CrossReferenceTypeNo_SalesInvoiceLine; "Sales Invoice Line"."Item Reference Type No.")
                {
                }
                column(ItemCategoryCode_SalesInvoiceLine; "Sales Invoice Line"."Item Category Code")
                {
                }
                column(Nonstock_SalesInvoiceLine; "Sales Invoice Line".Nonstock)
                {
                }
                column(PurchasingCode_SalesInvoiceLine; "Sales Invoice Line"."Purchasing Code")
                {
                }
                column(ProductGroupCode_SalesInvoiceLine; "Sales Invoice Line"."Item Category Code")
                {
                } //B2BUPG
                column(ApplfromItemEntry_SalesInvoiceLine; "Sales Invoice Line"."Appl.-from Item Entry")
                {
                }
                column(ReturnReasonCode_SalesInvoiceLine; "Sales Invoice Line"."Return Reason Code")
                {
                }
                column(AllowLineDisc_SalesInvoiceLine; "Sales Invoice Line"."Allow Line Disc.")
                {
                }
                column(CustomerDiscGroup_SalesInvoiceLine; "Sales Invoice Line"."Customer Disc. Group")
                {
                }
                column(MAWBNo_SalesInvoiceLine; "Sales Invoice Line"."MAWB No.")
                {
                }
                column(HAWBNo_SalesInvoiceLine; DivCode)
                {
                }
                column(DivisionCode_SalesInvoiceLine; "Sales Invoice Line"."Division Code")
                {
                }
                column(SplitWeight_SalesInvoiceLine; "Sales Invoice Line"."Split Weight")
                {
                }
                column(AirlineCode_SalesInvoiceLine; "Sales Invoice Line"."Airline Code")
                {
                }
                column(ConsigneeCode_SalesInvoiceLine; "Sales Invoice Line"."Consignee Code")
                {
                }
                column(FlightCode_SalesInvoiceLine; "Sales Invoice Line"."Flight Code")
                {
                }
                column(DestinationCode_SalesInvoiceLine; "Sales Invoice Line"."Destination Code")
                {
                }
                column(FlightDate_SalesInvoiceLine; "Sales Invoice Line"."Flight Date")
                {
                }
                column(VATAmount_SalesInvoiceLine; "Sales Invoice Line"."VAT Amount")
                {
                }
                column(CostAmount_SalesInvoiceLine; "Sales Invoice Line"."Cost Amount")
                {
                }
                column(FreightChargeCode_SalesInvoiceLine; "Sales Invoice Line"."Freight Charge Code")
                {
                }
                column(SplitFactor_SalesInvoiceLine; "Sales Invoice Line"."Split Factor")
                {
                }
                column(FreightCost_SalesInvoiceLine; "Sales Invoice Line"."Freight Cost")
                {
                }
                column(Margin_SalesInvoiceLine; "Sales Invoice Line"."Margin %")
                {
                }
                column(MarginAmount_SalesInvoiceLine; "Sales Invoice Line"."Margin Amount")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DivCode := '';
                    BookingSheetMAWBAllocation.RESET;
                    BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "Sales Invoice Line"."MAWB No.");
                    IF BookingSheetMAWBAllocation.FINDFIRST THEN
                        Ok := Item.GET(BookingSheetMAWBAllocation."Item No");

                    MAWBLine.RESET;
                    MAWBLine.SETRANGE(MAWBLine."MAWB No.", "Sales Invoice Line"."MAWB No.");
                    MAWBLine.SETRANGE(MAWBLine."HAWB No.", "Sales Invoice Line"."HAWB No.");
                    IF MAWBLine.FINDFIRST THEN
                        DivCode := MAWBLine."Division/Farm Code";
                    //MESSAGE(DivCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                XRate := 0;
                IF "Sales Invoice Header"."Currency Factor" <> 0 THEN
                    XRate := (1 / "Sales Invoice Header"."Currency Factor")
                ELSE
                    XRate := 1;
                Ok := Customer.GET("Sales Invoice Header"."Bill-to Customer No.");
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
        Ok: Boolean;
        Item: Record Item;
        Customer: Record Customer;
        BookingSheetMAWBAllocation: Record "Booking Sheet MAWB Allocation";
        MAWBLine: Record "MAWB Line";
        DivCode: Text[200];
}

