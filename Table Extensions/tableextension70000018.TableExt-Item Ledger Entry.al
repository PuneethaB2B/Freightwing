tableextension 70000018 tableextension70000018 extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Shipper Code"; Code[20])
        {
            TableRelation = Customer.No.;
        }
        field(50001;Weight;Decimal)
        {
        }
    }
}

