report 50109 "Close Check Printed"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table81)
        {

            trigger OnAfterGetRecord()
            begin
                IF "Gen. Journal Line"."Bank Payment Type" = "Gen. Journal Line"."Bank Payment Type"::"Computer Check" THEN BEGIN
                    "Gen. Journal Line"."Check Printed" := TRUE;
                    "Gen. Journal Line".MODIFY;
                END;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Gen. Journal Line"."Journal Batch Name", 'GEORGE');
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

