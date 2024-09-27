report 50105 "Trial Item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './TrialItem.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {

            trigger OnAfterGetRecord()
            begin
                IF Item."Product Group Code" = '' THEN
                    Item."Item Category Code" := Item."Inventory Posting Group";
                Item."Product Group Code" := Item."Inventory Posting Group";
                Item.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Item."Product Group Code", '');
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

