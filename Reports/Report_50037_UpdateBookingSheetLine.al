report 50037 "Update Booking Sheet Line"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(Flight; Flight)
        {

            trigger OnAfterGetRecord()
            begin
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
        BkLine: Record "Booking Sheet Line";
        BKMawb: Record "Booking Sheet MAWB Allocation";
}

