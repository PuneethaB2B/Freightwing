report 50068 "Divisions Batch"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50076)
        {

            trigger OnAfterGetRecord()
            begin

                SalesInvoiceLine.RESET;
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."MAWB No.", "MAWB Line"."MAWB No.");
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."HAWB No.", "MAWB Line"."HAWB No.");
                //SalesInvoiceLine.SETFILTER(SalesInvoiceLine."Division Code",'<>%1','');
                IF SalesInvoiceLine.FINDSET THEN BEGIN
                    Div1 := FORMAT("MAWB Line"."Division Code");
                    Window.UPDATE(1, "MAWB Line"."MAWB No.");
                    Window.UPDATE(2, "MAWB Line"."HAWB No.");
                    Window.UPDATE(3, Div1);
                    //MESSAGE('Division %1',"MAWB Line"."Division Code");
                    REPEAT
                        EVALUATE(SalesInvoiceLine."Division Code", Div1);
                        SalesInvoiceLine.MODIFY;
                        SLEEP(100);
                    UNTIL SalesInvoiceLine.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                MESSAGE('Posted Invoices Updated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Initializing \Updating MAWB #1##\ HAWB No. #2##\ Division #3##');
                //"MAWB Line".SETFILTER("MAWB Line"."Division Code",'<>%1','');
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
        MAWBLine: Record "50076";
        Window: Dialog;
        SalesInvoiceLine: Record "113";
        Div1: Text[250];
}

