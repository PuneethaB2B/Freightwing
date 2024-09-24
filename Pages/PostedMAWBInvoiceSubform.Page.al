page 50146 "Posted MAWB Invoice Subform"
{
    AutoSplitKey = true;
    Caption = 'Posted MAWB Invoice Subform';
    DelayedInsert = true;
    Editable = false;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    PromotedActionCategories = ' New,Posting,Reports,Documents/Certificates,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table37;
    SourceTableView = WHERE(Document Type=FILTER(Invoice));

    layout
    {
        area(content)
        {
            repeater()
            {
                field("HAWB No.";"HAWB No.")
                {
                    HideValue = "HAWB No.HideValue";
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field(Type;Type)
                {
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("No.";"No.")
                {
                    ShowMandatory = TypeChosen;
                    Style = Favorable;
                    StyleExpr = StyleText;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        IF xRec."No." <> '' THEN
                          RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Freight Charge Code";"Freight Charge Code")
                {
                }
                field(Description;Description)
                {
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    Style = Favorable;
                    StyleExpr = StyleText;

                    trigger OnValidate()
                    begin
                        UnitofMeasureCodeOnAfterValida;
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field(Quantity;Quantity)
                {
                    BlankZero = true;
                    ShowMandatory = TypeChosen;
                    Style = Favorable;
                    StyleExpr = StyleText;

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                        RedistributeTotalsOnAfterValidate;
                    end;
                }
                field("Line Discount %";"Line Discount %")
                {
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                }
                field("Split Weight";"Split Weight")
                {
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("Split Factor";"Split Factor")
                {
                }
                field("Cost Amount";"Cost Amount")
                {
                    Editable = false;
                }
                field("Line Amount";"Line Amount")
                {
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("VAT Amount";"VAT Amount")
                {
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
            }
            group()
            {
                Visible = false;
                group()
                {
                    Visible = false;
                    field("Invoice Discount Amount";TotalSalesLine."Inv. Discount Amount")
                    {
                        AutoFormatType = 1;
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        Enabled = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;

                        trigger OnValidate()
                        var
                            SalesHeader: Record "36";
                        begin
                            SalesHeader.GET("Document Type","Document No.");
                            SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesLine."Inv. Discount Amount",SalesHeader);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                    field("Invoice Disc. Pct.";SalesCalcDiscByType.GetCustInvoiceDiscountPct(Rec))
                    {
                        Caption = 'Invoice Discount %';
                        DecimalPlaces = 0:2;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;
                    }
                }
                group()
                {
                    Visible = false;
                    field("Total Amount Excl. VAT";TotalSalesLine.Amount)
                    {
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total VAT Amount";VATAmount)
                    {
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total VAT';
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                    }
                    field("Total Amount Incl. VAT";TotalSalesLine."Amount Including VAT")
                    {
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        StyleExpr = TotalAmountStyle;
                    }
                    field(RefreshTotals;RefreshMessageText)
                    {
                        DrillDown = true;
                        Editable = false;
                        Enabled = RefreshMessageEnabled;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
                            CurrPage.UPDATE(FALSE);
                        end;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Get &Price")
                {
                    AccessByPermission = TableData 7002=R;
                    Caption = 'Get &Price';
                    Ellipsis = true;
                    Image = Price;

                    trigger OnAction()
                    begin
                        ShowPrices
                    end;
                }
                action("Get Li&ne Discount")
                {
                    AccessByPermission = TableData 7004=R;
                    Caption = 'Get Li&ne Discount';
                    Ellipsis = true;
                    Image = LineDiscount;

                    trigger OnAction()
                    begin
                        ShowLineDisc
                    end;
                }
                action("E&xplode BOM")
                {
                    AccessByPermission = TableData 90=R;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    AccessByPermission = TableData 279=R;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(GetShipmentLines)
                {
                    AccessByPermission = TableData 110=R;
                    Caption = 'Get &Shipment Lines';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetShipment;
                    end;
                }
                action(GetHAWBAllocationLines)
                {
                    Caption = 'Get &HAWB Lines';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetMAWBAllocation;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData 14=R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData 348=R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowLineComments;
                    end;
                }
                action("Item Charge &Assignment")
                {
                    AccessByPermission = TableData 5800=R;
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction()
                    begin
                        ShowItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF SalesHeader.GET("Document Type","Document No.") THEN;

        DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
          TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);

        TypeChosen := Type <> Type::" ";
    end;

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);

        //SetStyle;
        "HAWB No.HideValue" := FALSE;
        HAWBNoOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReserveSalesLine: Codeunit "99000832";
    begin
        IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
          COMMIT;
          IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
            EXIT(FALSE);
          ReserveSalesLine.DeleteLine(Rec);
        END;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SetStyle;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        TotalSalesHeader: Record "36";
        TotalSalesLine: Record "37";
        SalesHeader: Record "36";
        TransferExtendedText: Codeunit "378";
        SalesPriceCalcMgt: Codeunit "7000";
        ItemAvailFormsMgt: Codeunit "353";
        SalesCalcDiscByType: Codeunit "56";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
        ShortcutDimCode: array [8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to run this function while in View mode.';
        [InDataSet]
        ItemPanelVisible: Boolean;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        TypeChosen: Boolean;
        StyleText: Boolean;
        TempSalesLine: Record "37" temporary;
        [InDataSet]
        "HAWB No.HideValue": Boolean;

    
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
    end;

    
    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    end;

    
    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    end;

    
    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment",Rec);
    end;

    
    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
          CurrPage.SAVERECORD;
          COMMIT;
          TransferExtendedText.InsertSalesExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
          UpdateForm(TRUE);
    end;

    
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    
    procedure ShowPrices()
    begin
        SalesHeader.GET("Document Type","Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader,Rec);
    end;

    
    procedure ShowLineDisc()
    begin
        SalesHeader.GET("Document Type","Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader,Rec);
    end;

    
    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    
    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
          MESSAGE(Text000);
          EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := Type = Type::Item;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
          CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    local procedure QuantityOnAfterValidate()
    begin
        IF Reserve = Reserve::Always THEN BEGIN
          CurrPage.SAVERECORD;
          AutoReserve;
        END;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        IF Reserve = Reserve::Always THEN BEGIN
          CurrPage.SAVERECORD;
          AutoReserve;
        END;
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SAVERECORD;

        SalesHeader.GET("Document Type","Document No.");
        IF DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) THEN
          DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
        CurrPage.UPDATE;
    end;

    
    procedure GetMAWBAllocation()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get MAWB Line",Rec);
    end;

    local procedure SetStyle()
    begin
        IF "HAWB No."<>'' THEN
          StyleText:=TRUE
        ELSE
          StyleText:=FALSE;
    end;

    local procedure IsFirstDocLine(): Boolean
    var
        SalesLine: Record "37";
    begin
        TempSalesLine.RESET;
        TempSalesLine.COPYFILTERS(Rec);
        TempSalesLine.SETRANGE("Document Type","Document Type");
        TempSalesLine.SETRANGE("Document No.","Document No.");
        TempSalesLine.SETRANGE("MAWB No.","MAWB No.");
        TempSalesLine.SETRANGE("HAWB No.","HAWB No.");
        IF NOT TempSalesLine.FINDFIRST THEN BEGIN
          COPYFILTERS(Rec);
          SalesLine.SETRANGE("Document Type","Document Type");
          SalesLine.SETRANGE("Document No.","Document No.");
          SalesLine.SETRANGE("MAWB No.","MAWB No.");
          SalesLine.SETRANGE("HAWB No.","HAWB No.");
          IF SalesLine.FINDFIRST THEN BEGIN
            TempSalesLine :=SalesLine;
            TempSalesLine.INSERT;
          END;
        END;
        IF "Line No." = TempSalesLine."Line No." THEN
          EXIT(TRUE);
    end;

    local procedure HAWBNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
          "HAWB No.HideValue" := TRUE;
    end;

    local procedure GetDefaultCharges()
    var
        MAWBReceipt: Record "50039";
        FreightCharge: Record "50018";
        SalesLine: Record "37";
        MAWBLine: Record "50076";
    begin
        //*******INSERT MAWB CHARGES********
        IF SalesLine.FINDLAST THEN BEGIN
          SalesHeader.GET("Document Type","Document No.");
          MAWBReceipt.RESET;
          MAWBReceipt.SETRANGE("MAWB No.",SalesHeader."MAWB No.");
          IF MAWBReceipt.FINDFIRST THEN BEGIN
            SalesLine.INIT;
            SalesLine."Document Type":=SalesHeader."Document Type";
            SalesLine."Document No.":=SalesHeader."No.";
            SalesLine."Line No.":=SalesLine."Line No."+10000;
            SalesLine.Type:=SalesLine.Type::"G/L Account";
            SalesLine."No.":=MAWBReceipt."Freight Charge Code";
            SalesLine."Line Amount":=MAWBReceipt."MAWB Fees";

            FreightCharge.RESET;
            FreightCharge.SETRANGE(Code,MAWBReceipt."Freight Charge Code");
            IF FreightCharge.FINDFIRST THEN BEGIN
              SalesLine.Description:=FreightCharge.Description;
            END;
            MAWBLine.RESET;
            MAWBLine.SETRANGE("MAWB No.",SalesHeader."MAWB No.");
            MAWBLine.SETRANGE("Shipper Code",SalesHeader."Sell-to Customer No.");
            IF MAWBLine.FINDFIRST THEN BEGIN
              SalesLine.Quantity:=0;
              SalesLine."Split Weight":=0;
              SalesLine."Gross Weight":=0;
              SalesLine."MAWB No.":=MAWBLine."MAWB No.";
              SalesLine."Airline Code":=MAWBLine."Airline Code";
              SalesLine."Consignee Code":=MAWBLine."Consignee Code";
              SalesLine."Unit of Measure Code":='';
              SalesLine."Flight Code":=MAWBLine."Flight Code";
              SalesLine."Destination Code":=MAWBLine."Destination Code";
              SalesLine."Flight Date":=MAWBLine."Flight Date";
              SalesLine."Qty. to Ship":=Quantity;
              SalesLine."Qty. to Invoice":=Quantity;
              SalesLine."Qty. to Assign":=Quantity;
              SalesLine."Qty. Assigned":=Quantity;

              END;
            SalesLine.INSERT;
        END;
        END;
    end;
}
