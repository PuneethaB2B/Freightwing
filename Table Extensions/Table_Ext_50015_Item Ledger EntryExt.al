tableextension 50015 ItemLedgerEntryExt extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "Shipper Code"; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(50001; Weight; Decimal)
        {
        }
    }
}

