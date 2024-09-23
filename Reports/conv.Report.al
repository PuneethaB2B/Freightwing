report 50111 conv
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50016)
        {

            trigger OnAfterGetRecord()
            begin
                "IATA Purchase Invoice".Converted := FALSE;
                "IATA Purchase Invoice"."Purchase Invoice No." := '';
                "IATA Purchase Invoice".MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('');
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
}

