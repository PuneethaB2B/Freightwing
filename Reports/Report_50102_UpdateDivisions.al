report 50102 "Update Divisions"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Sales Invoice Line"."Document No.");
                "Sales Invoice Line".VALIDATE("Sales Invoice Line"."Division Code");
                SLEEP(100);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                //MESSAGE('Updated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating Sales Invoice\Invoice No. #1##');
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
        MAWBLine: Record "MAWB Line";
        Window: Dialog;
        SalesInvoiceLine: Record "Sales Invoice Line";
}

