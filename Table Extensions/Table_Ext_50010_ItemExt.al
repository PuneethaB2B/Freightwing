tableextension 50010 ItemExt extends Item
{
    fields
    {
        field(50000; "HS Code"; Code[50])
        {
            TableRelation = "HS Codes".Code;
        }
    }


    
}

