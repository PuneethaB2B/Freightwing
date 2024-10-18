pageextension 50032 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            group("Purchase  Requisition")
            {
                CaptionML = ENU = 'Purchase  Requisition';
                field("Purchase Requisition Nos."; Rec."Purchase Requisition Nos.")
                {
                    ApplicationArea = all;
                }
                field("Request for Quotation Nos."; Rec."Request for Quotation Nos.")
                {
                    ApplicationArea = all;
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    ApplicationArea = all;
                }
                field("Item journal Template"; Rec."Item journal Template")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}