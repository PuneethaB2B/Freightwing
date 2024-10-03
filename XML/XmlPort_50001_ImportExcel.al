xmlport 50001 "Import Excel"
{
    Caption = 'Import AV';
    Direction = Import;
    FieldDelimiter = '<None>';
    Format = VariableText;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement("TEST AV"; "Booking Sheet FAM Allocations")
            {
                XmlName = 'AVLines';
                fieldelement(AVEntryType; "TEST AV"."Booking Sheet No")
                {
                }
                fieldelement(EntryType; "TEST AV"."Shipper Code")
                {
                }
                fieldelement(PostingDate; "TEST AV"."Farm Code")
                {
                }
                fieldelement(Category; "TEST AV"."Shipper Name")
                {
                }
                fieldelement(Description; "TEST AV"."FAM Name")
                {
                }
                fieldelement(TransType; "TEST AV".Weight)
                {
                }
                fieldelement(SubawardNo; "TEST AV"."Item No")
                {
                }
                fieldelement(DocNo; "TEST AV"."Line No")
                {
                }
                fieldelement(Currency; "TEST AV"."Airline Code")
                {
                }
                fieldelement(Amount; "TEST AV"."Flight Code")
                {
                }
                fieldelement(Fund; "TEST AV"."Source Airport")
                {
                }
                fieldelement(Dim1; "TEST AV"."Destination Airport")
                {
                }
                fieldelement(Dim2; "TEST AV"."MAWB No")
                {
                }
                fieldelement(Dim3; "TEST AV"."Consignee Code")
                {
                }
                fieldelement(Dim4; "TEST AV".Field15)
                {
                }
                fieldelement(Dim5; "TEST AV".Field16)
                {
                }
                fieldelement(Dim6; "TEST AV".Field17)
                {
                }
                fieldelement(EntryNo; "TEST AV".Field18)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

