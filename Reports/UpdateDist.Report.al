report 50040 "Update Dist"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50040)
        {

            trigger OnAfterGetRecord()
            begin
                WITH "Dl. Weight Dist. Header" DO BEGIN
                    "Dl. Weight Dist. Header"."Week No" := DATE2DWY("Dl. Weight Dist. Header"."Distribution Date", 2);
                    "Dl. Weight Dist. Header".MODIFY;
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
}

