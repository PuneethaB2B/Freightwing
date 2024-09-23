report 50066 "Update Loading Sheet Lines"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50060)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Loading Sheet Header"."No.");
                Window.UPDATE(2, "Loading Sheet Header"."Shipper Name");
                LSLine.RESET;
                LSLine.SETRANGE(LSLine."Loading Sheet No.", "Loading Sheet Header"."No.");
                LSLine.SETFILTER(LSLine."Shipper Code", '<>%1', "Loading Sheet Header"."Shipper Code");
                IF LSLine.FINDSET THEN BEGIN
                    REPEAT
                        Window.UPDATE(3, LSLine."Line No.");
                        SLEEP(200);
                        LSLine."Shipper Code" := "Loading Sheet Header"."Shipper Code";
                        LSLine.MODIFY;
                    UNTIL LSLine.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('All Loading Sheets Updated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating Loading Sheet \Loading Sheet No #1####\Shipper Code #2####\Line No #3###');
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
        LSLine: Record "50061";
        Window: Dialog;
}

