pageextension 50033 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Number Series")
        {
            group("Purchase  Requisition")
            {
                Caption = 'Purchase  Requisition';
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