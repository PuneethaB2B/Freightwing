tableextension 50030 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE(Assigned = FILTER(false));
        }
        field(50001; "Airline Code"; Code[20])
        {
            TableRelation = Airline;
        }
        field(50002; "Consignee Code"; Code[20])
        {
            TableRelation = Consignee;
        }
        field(50003; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE("Airline Code" = FIELD("Airline Code"));
        }
        field(50004; "Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(50005; "Flight Date"; Date)
        {

        }
        field(50006; "Chargeable Weight"; Decimal)
        {

        }
        field(50007; "Gross Weight"; Decimal)
        {

        }
        field(50008; "HAWB No."; Code[20])
        {
            Editable = false;
        }
        field(50009; Posted; Boolean)
        {

        }
        field(50010; "Import MAWB No."; Code[20])
        {
            TableRelation = "Pre Alert Header"."MAWB No" WHERE(Invoiced = FILTER(false));
        }
        field(500011; "CC/PP"; Code[20])
        {

        }
        field(50013; "Total Weight"; Decimal)
        {

        }
        field(50015; "Agreed Rate"; Decimal)
        {
            Editable = false;
        }
        field(50016; Commodity; Text[150])
        {

        }
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
        field(60020; "Link Text"; Text[250])
        {

        }
        field(60021; "Deivice Code"; Code[50])
        {

        }
        field(70000; "VAT Amount"; Decimal)
        {
            CaptionML = ENU = 'VAT Amount';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."VAT Amount" WHERE("Document No." = FIELD("No.")));
            Editable = false;
            AutoFormatExpression = "Currency Code";
        }
        field(70001; "TIMS Time"; DateTime)
        {

        }
    }

}