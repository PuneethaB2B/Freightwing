tableextension 50031 SalesCrMemoHeaderExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(60017; "QR Code"; Blob)
        {
            Subtype = Bitmap;
        }
        field(60018; "Invoice Number"; Code[50])
        {

        }
        field(60019; "Exemption Number"; Code[20])
        {

        }
        field(60020; Link; Text[250])
        {

        }
        field(60021; "Device Code"; Code[50])
        {

        }
        field(70001; "Tims Time"; DateTime)
        {

        }
    }

}
