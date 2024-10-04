report 50101 "Update Test"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {

            trigger OnAfterGetRecord()
            begin
                MAWBHeader2.RESET;
                MAWBHeader2.SETRANGE(MAWBHeader2."No.", "MAWB Receipt"."MAWB No.");
                IF MAWBHeader2.FINDFIRST THEN BEGIN
                    IF MAWBHeader2.Status = MAWBHeader2.Status::Archived THEN BEGIN
                        "MAWB Receipt".Prepared := TRUE;
                        "MAWB Receipt"."Prepared Date" := MAWBHeader2."Preparation Date";
                        "MAWB Receipt".MODIFY;
                    END;
                END;
                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    IF "MAWB Receipt".Prepared THEN BEGIN
                    END ELSE BEGIN
                        "MAWB Receipt".Prepared := TRUE;
                        "MAWB Receipt"."Prepared Date" := SalesInvoiceHeader."Document Date";
                        "MAWB Receipt".MODIFY;
                    END;
                END ELSE BEGIN
                    "MAWB Receipt".Prepared := FALSE;
                    "MAWB Receipt"."Prepared Date" := 0D;
                    "MAWB Receipt".MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Úpdated Successfully');
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
        MAWBHeader2: Record "MAWB Header 2";
        SalesInvoiceHeader: Record "Sales Invoice Header";
}

