tableextension 50004 GLAccountExt extends "G/L Account"
{
    fields
    {
        field(50000; "HS Code"; Code[50])
        {
            TableRelation = "HS Codes".Code;
        }
    }
}

