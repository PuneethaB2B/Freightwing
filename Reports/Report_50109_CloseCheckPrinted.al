report 50109 "Close Check Printed"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
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

