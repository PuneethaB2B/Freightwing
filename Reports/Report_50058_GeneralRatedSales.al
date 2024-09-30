report 50058 "General Rated Sales"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/GeneralRatedSales.rdl';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = WHERE(Type = FILTER(Sale),
                                      "VAT Prod. Posting Group" = FILTER('VAT16' | 'VAT14'),
                                      "Source Code" = FILTER(<> 'REVERSAL'));
            column(Descrip; Desc)
            {
            }
            column(CrMemoNo; CrMemoNo)
            {
            }
            column(CrMemoDate; CrMemoDate)
            {
            }
            column(ETR; Setup."ETR PIN.")
            {
            }
            column(VendorName; Vendors.Name)
            {
            }
            column(Desc; GLEnt.Description)
            {
            }
            column(VAT; Vendors."VAT Registration No.")
            {
            }
            column(EntryNo_VATEntry; "VAT Entry"."Entry No.")
            {
            }
            column(GenBusPostingGroup_VATEntry; "VAT Entry"."Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostingGroup_VATEntry; "VAT Entry"."Gen. Prod. Posting Group")
            {
            }
            column(PostingDate_VATEntry; "VAT Entry"."Posting Date")
            {
            }
            column(DocumentNo_VATEntry; "VAT Entry"."Document No.")
            {
            }
            column(DocumentType_VATEntry; "VAT Entry"."Document Type")
            {
            }
            column(Type_VATEntry; "VAT Entry".Type)
            {
            }
            column(Base_VATEntry; "VAT Entry".Base)
            {
            }
            column(Amount_VATEntry; "VAT Entry".Amount)
            {
            }
            column(VATCalculationType_VATEntry; "VAT Entry"."VAT Calculation Type")
            {
            }
            column(BilltoPaytoNo_VATEntry; "VAT Entry"."Bill-to/Pay-to No.")
            {
            }
            column(EU3PartyTrade_VATEntry; "VAT Entry"."EU 3-Party Trade")
            {
            }
            column(UserID_VATEntry; "VAT Entry"."User ID")
            {
            }
            column(SourceCode_VATEntry; "VAT Entry"."Source Code")
            {
            }
            column(ReasonCode_VATEntry; "VAT Entry"."Reason Code")
            {
            }
            column(ClosedbyEntryNo_VATEntry; "VAT Entry"."Closed by Entry No.")
            {
            }
            column(Closed_VATEntry; "VAT Entry".Closed)
            {
            }
            column(CountryRegionCode_VATEntry; "VAT Entry"."Country/Region Code")
            {
            }
            column(InternalRefNo_VATEntry; "VAT Entry"."Internal Ref. No.")
            {
            }
            column(TransactionNo_VATEntry; "VAT Entry"."Transaction No.")
            {
            }
            column(UnrealizedAmount_VATEntry; "VAT Entry"."Unrealized Amount")
            {
            }
            column(UnrealizedBase_VATEntry; "VAT Entry"."Unrealized Base")
            {
            }
            column(RemainingUnrealizedAmount_VATEntry; "VAT Entry"."Remaining Unrealized Amount")
            {
            }
            column(RemainingUnrealizedBase_VATEntry; "VAT Entry"."Remaining Unrealized Base")
            {
            }
            column(ExternalDocumentNo_VATEntry; "VAT Entry"."External Document No.")
            {
            }
            column(NoSeries_VATEntry; "VAT Entry"."No. Series")
            {
            }
            column(TaxAreaCode_VATEntry; "VAT Entry"."Tax Area Code")
            {
            }
            column(TaxLiable_VATEntry; "VAT Entry"."Tax Liable")
            {
            }
            column(TaxGroupCode_VATEntry; "VAT Entry"."Tax Group Code")
            {
            }
            column(UseTax_VATEntry; "VAT Entry"."Use Tax")
            {
            }
            column(TaxJurisdictionCode_VATEntry; "VAT Entry"."Tax Jurisdiction Code")
            {
            }
            column(TaxGroupUsed_VATEntry; "VAT Entry"."Tax Group Used")
            {
            }
            column(TaxType_VATEntry; "VAT Entry"."Tax Type")
            {
            }
            column(TaxonTax_VATEntry; "VAT Entry"."Tax on Tax")
            {
            }
            column(SalesTaxConnectionNo_VATEntry; "VAT Entry"."Sales Tax Connection No.")
            {
            }
            column(UnrealizedVATEntryNo_VATEntry; "VAT Entry"."Unrealized VAT Entry No.")
            {
            }
            column(VATBusPostingGroup_VATEntry; "VAT Entry"."VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup_VATEntry; "VAT Entry"."VAT Prod. Posting Group")
            {
            }
            column(AdditionalCurrencyAmount_VATEntry; "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(AdditionalCurrencyBase_VATEntry; "VAT Entry"."Additional-Currency Base")
            {
            }
            column(AddCurrencyUnrealizedAmt_VATEntry; "VAT Entry"."Add.-Currency Unrealized Amt.")
            {
            }
            column(AddCurrencyUnrealizedBase_VATEntry; "VAT Entry"."Add.-Currency Unrealized Base")
            {
            }
            column(VATBaseDiscount_VATEntry; "VAT Entry"."VAT Base Discount %")
            {
            }
            column(AddCurrRemUnrealAmount_VATEntry; "VAT Entry"."Add.-Curr. Rem. Unreal. Amount")
            {
            }
            column(AddCurrRemUnrealBase_VATEntry; "VAT Entry"."Add.-Curr. Rem. Unreal. Base")
            {
            }
            column(VATDifference_VATEntry; "VAT Entry"."VAT Difference")
            {
            }
            column(AddCurrVATDifference_VATEntry; "VAT Entry"."Add.-Curr. VAT Difference")
            {
            }
            column(ShiptoOrderAddressCode_VATEntry; "VAT Entry"."Ship-to/Order Address Code")
            {
            }
            column(DocumentDate_VATEntry; "VAT Entry"."Document Date")
            {
            }
            column(VATRegistrationNo_VATEntry; "VAT Entry"."VAT Registration No.")
            {
            }
            column(Reversed_VATEntry; "VAT Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_VATEntry; "VAT Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_VATEntry; "VAT Entry"."Reversed Entry No.")
            {
            }
            column(EUService_VATEntry; "VAT Entry"."EU Service")
            {
            }

            trigger OnAfterGetRecord()
            begin
                WITH "VAT Entry" DO BEGIN
                    CrMemoNo := '';
                    CrMemoDate := 0D;
                    Desc := '';
                    IF "VAT Entry"."Bill-to/Pay-to No." <> '' THEN
                        Vendors.GET("Bill-to/Pay-to No.");
                    GLEnt.RESET;
                    GLEnt.SETRANGE(GLEnt."Document No.", "VAT Entry"."Document No.");
                    GLEnt.SETRANGE(GLEnt."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                    GLEnt.FINDFIRST;

                    //******CHeck Credit Memo
                    IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                        SalesCrMemoHeader.RESET;
                        SalesCrMemoHeader.SETRANGE(SalesCrMemoHeader."No.", "VAT Entry"."Document No.");
                        IF SalesCrMemoHeader.FIND('-') THEN BEGIN
                            CrMemoNo := SalesCrMemoHeader."Applies-to Doc. No.";
                            IF SalesInvoiceHeader.GET(CrMemoNo) THEN
                                CrMemoDate := SalesInvoiceHeader."Document Date";
                        END;
                    END;
                    //***
                    IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                        SalesInvoiceLine.RESET;
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "VAT Entry"."Document No.");
                        SalesInvoiceLine.SETRANGE(SalesInvoiceLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                            Desc := SalesInvoiceLine.Description;
                        END;
                    END ELSE BEGIN
                        SalesCrMemoLine.RESET;
                        SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Document No.", "VAT Entry"."Document No.");
                        SalesCrMemoLine.SETRANGE(SalesCrMemoLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                        IF SalesCrMemoLine.FINDFIRST THEN BEGIN
                            Desc := SalesCrMemoLine.Description;
                        END;

                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                Setup.GET();
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
        Vendors: Record Vendor;
        GLEnt: Record "G/L Entry";
        Setup: Record "Import/Export Setup";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        CrMemoNo: Code[50];
        CrMemoDate: Date;
        SalesAmntWithVAT: Decimal;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Desc: Text[250];
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
}

