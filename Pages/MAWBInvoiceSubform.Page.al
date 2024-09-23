page 50115 "MAWB Invoice Subform"
{
    AutoSplitKey = true;
    Caption = 'MAWB Invoice Subform';
    DelayedInsert = true;
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
                field("Document Type";"Document Type")
                {
                }
                field("Sell-to Customer No.";"Sell-to Customer No.")
                {
                    Visible = false;
                }
                field("Document No.";"Document No.")
                {
                }
                field("Line No.";"Line No.")
                {
                }
                field(Quantity;Quantity)
                {
                }
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
                field("Freight Handling Type";"Freight Handling Type")
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
                field("Currency Code";"Currency Code")
                {
                    Editable = true;
                }
                field("Split Weight";"Split Weight")
                {
                    Editable = true;
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("Split Factor";"Split Factor")
                {
                    Editable = true;
                }
                field("Cost Amount";"Cost Amount")
                {
                    Editable = true;
                }
                field("VAT %";"VAT %")
                {
                    Editable = false;
                }
                field("VAT Amount";"VAT Amount")
                {
                    Editable = true;
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("Margin %";"Margin %")
                {
                    Caption = 'Margin (G=%, TP=Cents)';

                    trigger OnValidate()
                    begin
                        // ***************************** TBL calculating the cost amount ****************
                        IF ("Freight Charge Code" = '14') OR ("Freight Charge Code" = '82') THEN
                          BEGIN
                               "Margin Amount" := "Margin %" * "Cost Amount";
                               "Line Amount" := "Cost Amount" + "Margin Amount";
                               "Amount Including VAT" := "Line Amount" + "VAT Amount";
                          END;
                    end;
                }
                field("Margin Amount";"Margin Amount")
                {
                    Editable = true;

                    trigger OnValidate()
                    begin
                        // ***************************** TBL calculating the cost amount ****************
                        IF ("Freight Charge Code" = '14') OR ("Freight Charge Code" = '82') THEN
                          BEGIN
                               //"Margin %" := "Margin Amount" / "Split Weight";
                               "Line Amount" := "Cost Amount" + "Margin Amount";
                               "Amount Including VAT" := "Line Amount" + "VAT Amount";
                          END;
                    end;
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Line Amount";"Line Amount")
                {
                    Editable = true;
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    Editable = true;
                    Style = Favorable;
                    StyleExpr = StyleText;
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                }
                field("Shortcut Dimension 1 Code";"Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(ShortcutDimCode[3];ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3,ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3,ShortcutDimCode[3]);
                    end;
                }
            }
            group()
            {
                group()
                {
                    field("Agreed Rate";"Agreed Rate")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Agreed Rate2";TBLSalesLine."Agreed Rate")
                    {
                        Caption = 'Agreed Rate';
                        Editable = false;
                        Visible = false;
                    }
                    field("Description 2";"Description 2")
                    {
                        Caption = 'Commodity';
                        Enabled = false;
                        Visible = false;
                    }
                    field("Description 22";TBLSalesLine."Description 2")
                    {
                        Caption = 'Commodity';
                        Enabled = false;
                        Visible = false;
                    }
                    field("Item Code Description";ShortcutDimCode[3])
                    {
                        Visible = true;
                    }
                    field("Total weight";"Total weight")
                    {
                        Editable = false;
                        Visible = false;
                    }
                    field("Total weight2";TBLSalesLine."Total weight")
                    {
                        Caption = 'Total weight';
                        Editable = false;
                        Visible = false;
                    }
                    field("Invoice Discount Amount";TotalSalesLine."Inv. Discount Amount")
                    {
                        AutoFormatType = 1;
                        Caption = 'Invoice Discount Amount';
                        Editable = InvDiscAmountEditable;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;

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
                    field("Total Amount Excl. VAT";TotalSalesLine.Amount)
                    {
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Excl. VAT';
                        DrillDown = false;
                        Editable = false;
                        Style = Subordinate;
                        StyleExpr = RefreshMessageEnabled;
                        Visible = true;
                    }
                    field("<Total Amount Excl. VATT>";"Total Amount Excl. VAT")
                    {
                        Caption = 'Total Amount Excl. VAT';
                        Editable = false;
                        Visible = false;
                    }
                    field("Total Amount Excl.VAT2";TBLSalesLine."Total Amount Excl. VAT")
                    {
                        Caption = 'Total Amount Excl. VAT';
                        Editable = false;
                        Visible = false;
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
                    field("Total Amount Incl. VATT";TotalSalesLine."Amount Including VAT")
                    {
                        AutoFormatType = 1;
                        CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
                        Caption = 'Total Amount Incl. VAT';
                        Editable = false;
                        ShowCaption = true;
                        StyleExpr = TotalAmountStyle;
                        Visible = true;
                    }
                    field("Total Amount Incl. VAT";"Total Amount Incl. VAT")
                    {
                        Caption = 'Total Amount Incl. VAT (USD)';
                        Editable = false;
                        Enabled = true;
                        Visible = false;
                    }
                    field("Total Amount Incl. VAT2";TBLSalesLine."Total Amount Incl. VAT")
                    {
                        Caption = 'Total Amount Incl. VAT (USD)';
                        Editable = false;
                        Visible = false;
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
                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

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
                    Visible = false;

                    trigger OnAction()
                    begin
                        GetShipment;
                    end;
                }
                action(GetHAWBAllocationLines)
                {
                    Caption = 'Get Lines';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetMAWBAllocation;
                    end;
                }
                action(CalcTotals)
                {
                    Caption = 'Calculate Totals';

                    trigger OnAction()
                    begin
                        IF (TBLSalesHeader.GET(Rec."Document Type",Rec."Document No.")) THEN
                          BEGIN
                                IF (TBLSalesHeader.Status = 0) THEN
                                    BEGIN
                                         // ****************************** Calculating total weight ***************
                                          TBLHNo1 := '';
                                          TBLHNo2 := '';
                                          TBLSalesLine.FINDSET;
                                          REPEAT
                                            IF (TBLSalesLine."Document No." = "Document No.") THEN
                                              BEGIN
                                                IF (TBLSalesLine."HAWB No." <> '') AND (TBLHNo1 = '') THEN
                                                  TBLHNo1 := TBLSalesLine."HAWB No."
                                                ELSE IF (TBLSalesLine."HAWB No." <> '') AND (TBLHNo1 <> '') THEN
                                                  TBLHNo2 := TBLSalesLine."HAWB No.";
                                              END;
                                          UNTIL TBLSalesLine.NEXT = 0;
                                         // ========
                                         TBLTotalWeight := 0;
                                         IF ((TBLHNo1 = '') AND (TBLHNo2 = '')) OR (((TBLHNo1 <> '') AND (TBLHNo2 <> '')) AND (TBLHNo1 <> TBLHNo2)) THEN
                                           BEGIN
                                              TBLMAWBLine.FINDSET;
                                              REPEAT
                                                IF (TBLMAWBLine."MAWB No." = "MAWB No.") THEN
                                                  TBLTotalWeight := TBLTotalWeight + TBLMAWBLine."Chargeable Weight";
                                              UNTIL TBLMAWBLine.NEXT = 0;
                                              "Total weight" := TBLTotalWeight;
                                           END ELSE
                                           BEGIN
                                             TBLMAWBLine.FINDSET;
                                             REPEAT
                                              IF (TBLMAWBLine."MAWB No." = "MAWB No.") AND (TBLMAWBLine."HAWB No." = TBLHNo1) THEN
                                                TBLTotalWeight := TBLMAWBLine."Chargeable Weight";
                                             UNTIL TBLMAWBLine.NEXT = 0;
                                             "Total weight" := TBLTotalWeight;
                                           END;
                                           "Total weight" := CheckTotalWeightAndCorrect(TBLTotalWeight);
                                         // ****************************** Calculating agreed rate ********************
                                         TBLAgreedRate := 0;
                                         TBLMAWBInvoiceCharge.FINDSET;
                                         REPEAT
                                             IF (TBLMAWBInvoiceCharge."MAWB No." = "MAWB No.") THEN
                                                BEGIN
                                                      TBLAgreedRate := TBLAgreedRate + TBLMAWBInvoiceCharge."Agreed Rate";
                                                      TBLItemNo := TBLMAWBInvoiceCharge."Item No.";
                                                END;
                                         UNTIL TBLMAWBInvoiceCharge.NEXT = 0;
                                         "Agreed Rate" := TBLAgreedRate;
                                         // ******************************* getting the item number *******************
                                         TBLItem.GET(TBLItemNo);
                                         "Description 2" := TBLItem."Search Description";
                                         TBLCommodity := TBLItem."Search Description";
                                         // ******************************** calculating total amount ******************
                                        TBLTotalVATIncl := 0;
                                        TBLTotalVATExcl := 0;
                                        TBLSalesLine.RESET;
                                        TBLSalesLine.FINDSET;
                                        REPEAT
                                            IF (TBLSalesLine."Document No." = "Document No.") THEN
                                                BEGIN
                                                     TBLTotalVATIncl := TBLTotalVATIncl + TBLSalesLine."Amount Including VAT";
                                                     TBLTotalVATExcl := TBLTotalVATExcl + TBLSalesLine."Line Amount";
                                                END;
                                       UNTIL TBLSalesLine.NEXT = 0;
                                       "Total Amount Incl. VAT" := TBLTotalVATIncl;
                                       "Total Amount Excl. VAT" := TBLTotalVATExcl;
                                       //TotalSalesLine."Amount Including VAT" := TBLTotalVATIncl;
                                       // ********************************* modifying the sales line ********************
                                       /*TBLSalesLine.FINDSET;
                                        REPEAT
                                            IF (TBLSalesLine."Document No." = "Document No.") THEN
                                                BEGIN
                                                      TBLSalesLine."Total Amount Incl. VAT" := TBLTotalVATIncl;
                                                      TBLSalesLine.MODIFY;
                                                END;
                                       UNTIL TBLSalesLine.NEXT = 0;  */
                                    END
                                ELSE
                                    MESSAGE(TxtInfo);
                                // **************************** modifying the sales header *************************
                                TBLSalesHeader."Total Weight" := TBLTotalWeight;
                                TBLSalesHeader."Total Amount" := TBLTotalVATIncl;
                                TBLSalesHeader."Agreed Rate" := TBLAgreedRate;
                                TBLSalesHeader.Commodity := TBLCommodity;
                                TBLSalesHeader.MODIFY;
                          END;
                        // ******************** Displaying non updatable fields *****************
                        TBLSalesLine."Total Amount Incl. VAT" := TBLTotalVATIncl;
                        TBLSalesLine."Total Amount Excl. VAT" := TBLTotalVATExcl;
                        TBLSalesLine."Total weight" := TBLTotalWeight;
                        TBLSalesLine."Agreed Rate" := TBLAgreedRate;
                        TBLSalesLine."Description 2" := TBLItem."Search Description";
                        CurrPage.UPDATE(TRUE);

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

        //"Line Amount" := "Cost Amount" + "Margin Amount";
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
        TBLCustomer: Record "18";
        TBLSalesHeader: Record "36";
        TBLSalesLine: Record "37";
        TBLMAWBLine: Record "50076";
        TBLFreightItemCharge: Record "50029";
        TBLFlightCode: Code[10];
        TBLHNo: Integer;
        TBLFlag: Boolean;
        TBLTotalWeight: Decimal;
        TBLTotalVATIncl: Decimal;
        TBLRowFlag: Boolean;
        TxtInfo: Label 'Totals can''t be caculated while the sales invioce is not open.';
        TBLAgreedRate: Decimal;
        TBLMAWBInvoiceCharge: Record "50073";
        TBLItemNo: Code[20];
        TBLItem: Record "27";
        TBLHNo1: Code[20];
        TBLHNo2: Code[20];
        TBLTotalVATExcl: Decimal;
        TBLPurchInvLine: Record "123";
        TBLPurchInvHeader: Record "122";
        TBLExchangeRate: Record "330";
        TBLCurrecnyCode: Code[10];
        TBLAmountLCY: Decimal;
        TBLAmountUSD: Decimal;
        TBLCommodity: Text[100];

    [Scope('Internal')]
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
    end;

    [Scope('Internal')]
    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    end;

    [Scope('Internal')]
    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    end;

    [Scope('Internal')]
    procedure GetShipment()
    begin
        CODEUNIT.RUN(CODEUNIT::"Sales-Get Shipment",Rec);
    end;

    [Scope('Internal')]
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

    [Scope('Internal')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    [Scope('Internal')]
    procedure ShowPrices()
    begin
        SalesHeader.GET("Document Type","Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLinePrice(SalesHeader,Rec);
    end;

    [Scope('Internal')]
    procedure ShowLineDisc()
    begin
        SalesHeader.GET("Document Type","Document No.");
        CLEAR(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetSalesLineLineDisc(SalesHeader,Rec);
    end;

    [Scope('Internal')]
    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    [Scope('Internal')]
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

    [Scope('Internal')]
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
        //*******INSERT MAWB CHARGES*******
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

    local procedure CheckTotalWeightAndCorrect(var pDecTotalWeight: Decimal): Decimal
    var
        lRecSalesLine: Record "37";
        lDecSalesLineWeight: Decimal;
        lCodeTempHAWBNo: Code[20];
    begin
        lDecSalesLineWeight := 0;
        lCodeTempHAWBNo := '';
        lRecSalesLine.RESET;
        lRecSalesLine.SETRANGE("Document No.","Document No.");
        lRecSalesLine.SETFILTER("HAWB No.",'<>%1','');
        IF lRecSalesLine.FINDSET THEN
          REPEAT
            IF lCodeTempHAWBNo <> lRecSalesLine."HAWB No." THEN
              lDecSalesLineWeight += lRecSalesLine."Split Weight";
            lCodeTempHAWBNo := lRecSalesLine."HAWB No.";
          UNTIL lRecSalesLine.NEXT = 0
        ELSE BEGIN
          lRecSalesLine.RESET;
          lRecSalesLine.SETRANGE("Document No.","Document No.");
          lRecSalesLine.SETFILTER("HAWB No.",'%1','');
          IF lRecSalesLine.FINDFIRST THEN
            lDecSalesLineWeight := lRecSalesLine."Split Weight";
        END;
        //Check if Weight is Same or not
        IF pDecTotalWeight <> lDecSalesLineWeight THEN
          pDecTotalWeight := lDecSalesLineWeight;
    end;
}

