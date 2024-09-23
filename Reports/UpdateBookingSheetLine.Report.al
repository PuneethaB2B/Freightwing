report 50037 "Update Booking Sheet Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50022)
        {

            trigger OnAfterGetRecord()
            begin
                WITH Flight DO BEGIN
                    BKMawb.RESET;
                    BKMawb.SETRANGE(BKMawb."Flight No", Flight."Flight No.");
                    IF BKMawb.FINDSET THEN BEGIN
                        REPEAT
                            BKMawb."Source Airport" := Flight."Source Airport";
                            //BkMawb."Source Code":= Flight."Source Code";
                            //BkMawb."Destination Code":=  Flight."Destination Code";
                            BKMawb."Destination Airport" := Flight."Destination Airport";
                            BKMawb.MODIFY;
                            MESSAGE('Updated %1', Flight."Flight No.");
                        UNTIL BKMawb.NEXT = 0;
                    END;
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

    var
        BkLine: Record "50054";
        BKMawb: Record "50070";
}

