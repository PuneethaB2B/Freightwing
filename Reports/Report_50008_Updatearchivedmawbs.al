report 50008 "Update archived mawbs"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Header 2"; "MAWB Header 2")
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "MAWB Header 2"."No.");
                MAWBReceipt.RESET;
                MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "MAWB Header 2"."No.");
                IF MAWBReceipt.FINDFIRST THEN BEGIN
                    "MAWB Header 2".VALIDATE("MAWB Header 2"."No.");
                    "MAWB Header 2".MODIFY;
                    SLEEP(20);
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('MAWBS updated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('VALIDATING MAWBS \MAWB #1##');
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
        Window: Dialog;
        MAWBReceipt: Record 50039;
}

