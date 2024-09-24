tableextension 50025 ItemJournalLineExt extends "Item Journal Line"
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

