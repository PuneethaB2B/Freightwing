report 50118 "MAWB Vali"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAWBVali.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50076)
        {

            trigger OnAfterGetRecord()
            begin
                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.", "MAWB Line"."MAWB No.");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Sell-to Customer No.", "MAWB Line"."Shipper Code");
                IF SalesInvoiceLine.FINDFIRST THEN BEGIN
                    "MAWB Line".RENAME("MAWB No.", "Line No.", "Shipper Code", SalesInvoiceLine."HAWB No.");
                END;
            end;

            trigger OnPreDataItem()
            begin
                "MAWB Line".SETFILTER("MAWB Line"."HAWB No.", '=%1', '');
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
        SalesInvoiceLine: Record "113";
}

