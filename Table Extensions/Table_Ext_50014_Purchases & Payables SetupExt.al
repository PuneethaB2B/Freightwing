tableextension 50014 PurchasePayableSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purchase Requisition Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Item Journal Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Item journal Template"));
        }
        field(50002; "Item journal Template"; Code[10])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(50003; "Request for Quotation Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
    }
}

