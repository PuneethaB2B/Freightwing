report 50092 "Restore Deleted MAWBs"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table112)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Sales Invoice Header"."MAWB No.");
                MAWBHeader.RESET;
                MAWBHeader.SETRANGE(MAWBHeader."No.", "Sales Invoice Header"."MAWB No.");
                IF MAWBHeader.FIND('-') THEN BEGIN
                END ELSE BEGIN
                    MAWBRec.RESET;
                    MAWBRec.SETRANGE(MAWBRec."MAWB No.", "Sales Invoice Header"."MAWB No.");
                    MAWBRec.SETRANGE(MAWBRec.Prepared, TRUE);
                    IF MAWBRec.FINDFIRST THEN BEGIN
                        MAWBRec.Prepared := FALSE;
                        MAWBRec.MODIFY;
                    END;

                    MAWBHeader.INIT;
                    MAWBHeader.VALIDATE(MAWBHeader."No.", "Sales Invoice Header"."MAWB No.");
                    MAWBHeader.Status := MAWBHeader.Status::Archived;
                    MAWBHeader."Prepared By" := USERID;
                    MAWBHeader."Processed By" := USERID;
                    MAWBHeader."Preparation Date" := "Sales Invoice Header"."Document Date";
                    MAWBHeader."Processed At" := TIME;
                    MAWBHeader."Gate Pass Prepared" := TRUE;
                    MAWBHeader.INSERT;
                    MAWBRec.RESET;
                    MAWBRec.SETRANGE(MAWBRec."MAWB No.", "Sales Invoice Header"."MAWB No.");
                    MAWBRec.SETRANGE(MAWBRec.Prepared, TRUE);
                    IF MAWBRec.FINDFIRST THEN BEGIN
                        MAWBRec.Prepared := TRUE;
                        MAWBRec.MODIFY;
                    END;


                END;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating \MAWB #1###');
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
        MAWBHeader: Record "50077";
        MAWBLine: Record "50076";
        HAWBHeader: Record "50075";
        HAWBLine: Record "50074";
        Window: Dialog;
        MAWBRec: Record "50039";
}

