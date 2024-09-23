tableextension 70000007 tableextension70000007 extends "G/L Account"
{
    fields
    {
        field(50000; "HS Code"; Code[50])
        {
            TableRelation = "HS Codes".Code;
        }
    }
}

