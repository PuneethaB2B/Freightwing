report 50105 "Trial Item"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Layout/TrialItem.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                IF Item."Item Category Code" = '' THEN
                    Item."Item Category Code" := Item."Inventory Posting Group";
                Item."Item Category Code" := Item."Inventory Posting Group";
                //B2BUPG
                Item.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Item."Item Category Code", '');
                //B2BUPG
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

