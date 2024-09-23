tableextension 70000006 tableextension70000006 extends "Purch. Cr. Memo Line"
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

