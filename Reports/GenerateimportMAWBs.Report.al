report 50087 "Generate import MAWBs"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table113)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Sales Invoice Line"."Posting Date");
                MAWBReceipt.RESET;
                MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "Sales Invoice Line"."MAWB No.");
                IF MAWBReceipt.FINDFIRST THEN BEGIN
                END ELSE BEGIN
                    Window.UPDATE(2, "Sales Invoice Line"."MAWB No.");
                    MAWBReceipt.INIT;
                    MAWBReceipt."Airline Code" := "Sales Invoice Line"."Airline Code";
                    MAWBReceipt."MAWB No." := "Sales Invoice Line"."MAWB No.";
                    MAWBReceipt."Receipt Date" := "Sales Invoice Line"."Posting Date";
                    MAWBReceipt.INSERT;
                END;
                SLEEP(10);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('Generated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Creating MAWBs \Date #1### \MAWB #2###');
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
        MAWBReceipt: Record "50039";
}

