report 50040 "Update Dist"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Dl. Weight Dist. Header"; "Dl. Weight Dist. Header")
        {

            trigger OnAfterGetRecord()
            begin
                "Dl. Weight Dist. Header"."Week No" := DATE2DWY("Dl. Weight Dist. Header"."Distribution Date", 2);
                "Dl. Weight Dist. Header".MODIFY;
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

