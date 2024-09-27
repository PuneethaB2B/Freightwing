report 50083 "test mawb"
{
    DefaultLayout = RDLC;
    RDLCLayout = './testmawb.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50002)
        {

            trigger OnAfterGetRecord()
            begin
                mawbreceipt.RESET;
                mawbreceipt.SETRANGE(mawbreceipt."MAWB No.", "Temp MAWB".MAW);
                mawbreceipt.SETRANGE(mawbreceipt.Assigned, FALSE);
                IF mawbreceipt.FIND('-') THEN
                    mawbreceipt.DELETEALL;
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
        mawbreceipt: Record "50039";
}

