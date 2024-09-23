report 50014 "Itax Upload"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItaxUpload.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table254)
        {
            RequestFilterFields = "VAT Prod. Posting Group";
            column(EntryNo_VATEntry; "VAT Entry"."Entry No.")
            {
            }
            column(PostingDate_VATEntry; "VAT Entry"."Posting Date")
            {
            }
            column(DocumentNo_VATEntry; "VAT Entry"."Document No.")
            {
            }
            column(DocumentType_VATEntry; "VAT Entry"."Document Type")
            {
            }
            column(Amount_VATEntry; "VAT Entry".Amount)
            {
            }
            column(DocumentDate_VATEntry; "VAT Entry"."Document Date")
            {
            }
            column(VATRegistrationNo_VATEntry; "VAT Entry"."VAT Registration No.")
            {
            }
            column(Reversed_VATEntry; "VAT Entry".Reversed)
            {
            }
            column(Source_No; "VAT Entry"."Bill-to/Pay-to No.")
            {
            }
            column(Type; "VAT Entry".Type)
            {
            }
            column(VAT_Product_postinggroup; "VAT Entry"."VAT Prod. Posting Group")
            {
            }
            column(Companyinfo_VATRegistrationNo; Companyinfo."VAT Registration No.")
            {
            }
            column(Source_Name; "Source Name")
            {
            }
            column(Tax_Type; "VAT Entry"."Tax Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "VAT Entry".Type = "VAT Entry".Type::Sale THEN BEGIN
                    Customer.GET("VAT Entry"."Bill-to/Pay-to No.");
                    "Source Name" := Customer.Name;
                END;
                IF "VAT Entry".Type = "VAT Entry".Type::Purchase THEN BEGIN
                    Vendor.GET("VAT Entry"."Bill-to/Pay-to No.");
                    "Source Name" := Vendor.Name;
                END;
            end;
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

    labels
    {
    }

    var
        Companyinfo: Record "79";
        Customer: Record "18";
        Vendor: Record "23";
        "Source Name": Text;
}

