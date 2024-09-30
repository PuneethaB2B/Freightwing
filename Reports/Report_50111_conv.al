report 50111 conv
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("IATA Purchase Invoice"; "IATA Purchase Invoice")
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

