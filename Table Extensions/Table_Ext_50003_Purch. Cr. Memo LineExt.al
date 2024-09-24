tableextension 50003 PurchCrMemoLineExt extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "Payment Voucher No."; Code[20])
        {
        }
        field(50002; "Charge Code"; Code[10])
        {
            TableRelation = "Freight Charge".Code;
        }
    }
}

