report 50028 "General Purchase Zero VAT"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GeneralPurchaseZeroVAT.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = WHERE(Type = FILTER(Purchase),
                                      "Source Code" = FILTER(<> REVERSAL),
                                      "VAT Prod. Posting Group" = FILTER(NOVAT | VAT0));
            column(VendorName; Vendors.Name)
            {
            }
            column(VAT; Vendors."VAT Registration No.")
            {
            }
            column(Desc; GLEnt.Description)
            {
            }
            column(Description; Desc)
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
                IncludeCaption = true;
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
            column(InvDate; "Inv date")
            {
            }
            column(InvNo; InvNo)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Inv date" := 0D;
                InvNo := '';
                Desc := '';
                IF "VAT Entry"."Bill-to/Pay-to No." <> '' THEN
                    Vendors.GET("VAT Entry"."Bill-to/Pay-to No.");
                GLEnt.RESET;
                GLEnt.SETRANGE(GLEnt."Document No.", "VAT Entry"."Document No.");
                GLEnt.SETRANGE(GLEnt."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                GLEnt.FINDFIRST;
                IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" THEN BEGIN
                    PurchCrMemoHdr.RESET;
                    PurchCrMemoHdr.SETRANGE(PurchCrMemoHdr."No.", "VAT Entry"."Document No.");
                    IF PurchCrMemoHdr.FINDFIRST THEN BEGIN
                        InvNo := PurchCrMemoHdr."Applies-to Doc. No.";
                        IF PurchInvHeader.GET(InvNo) THEN
                            "Inv date" := PurchInvHeader."Document Date";
                    END;
                END;

                IF "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice THEN BEGIN
                    PurchInvLine.RESET;
                    PurchInvLine.SETRANGE(PurchInvLine."Document No.", "VAT Entry"."Document No.");
                    PurchInvLine.SETRANGE(PurchInvLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                    IF PurchInvLine.FINDFIRST THEN BEGIN

                        Desc := PurchInvLine.Description;
                    END;
                END ELSE BEGIN
                    PurchCrMemoLine.RESET;
                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Document No.", "VAT Entry"."Document No.");
                    PurchCrMemoLine.SETRANGE(PurchCrMemoLine."VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                    IF PurchCrMemoLine.FINDFIRST THEN BEGIN
                        Desc := PurchCrMemoLine.Description;
                    END;

                END;
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
        InvNo: Code[50];
        "Inv date": Date;
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        Desc: Text[250];
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvLine: Record "Purch. Inv. Line";
}

