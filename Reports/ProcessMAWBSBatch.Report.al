report 50094 "Process MAWBS Batch"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50077)
        {

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "MAWB Header 2"."No.");
                IF "MAWB Header 2"."Has Houses" THEN BEGIN
                    Window.UPDATE(2, 'Ýes');
                    HAWBLine.RESET;
                    HAWBLine.SETRANGE(HAWBLine."MAWB No.", "MAWB Header 2"."No.");
                    HAWBLine.SETRANGE(HAWBLine."Custom Enrty No", '');
                    IF HAWBLine.FINDFIRST THEN BEGIN
                        DumpCustEnt.RESET;
                        DumpCustEnt.SETRANGE(DumpCustEnt."MAWB No.", HAWBLine."MAWB No.");
                        IF DumpCustEnt.FINDFIRST THEN BEGIN
                            DumpCustEnt.reconciled := TRUE;
                            HAWBLine."Custom Enrty No" := DumpCustEnt."Custom Ent";
                            DumpCustEnt.Located := TRUE;
                            HAWBLine.MODIFY;
                            DumpCustEnt.MODIFY;
                        END;
                    END;
                END ELSE BEGIN
                    Window.UPDATE(2, 'No Houses');
                    DumpCustEnt.RESET;
                    DumpCustEnt.SETRANGE(DumpCustEnt."MAWB No.", "MAWB Header 2"."No.");
                    IF DumpCustEnt.FINDFIRST THEN BEGIN
                        IF "MAWB Header 2"."Custom Entry No" <> DumpCustEnt."Custom Ent" THEN BEGIN
                            "MAWB Header 2"."Custom Entry No" := DumpCustEnt."Custom Ent";
                            DumpCustEnt.reconciled := TRUE;
                            DumpCustEnt.Located := TRUE;
                            DumpCustEnt.MODIFY;
                        END ELSE
                            IF "MAWB Header 2"."Custom Entry No" = '' THEN BEGIN
                                "MAWB Header 2"."Custom Entry No" := DumpCustEnt."Custom Ent";
                                DumpCustEnt.reconciled := TRUE;
                                DumpCustEnt.Located := TRUE;
                                DumpCustEnt.MODIFY;
                            END ELSE BEGIN
                                DumpCustEnt.reconciled := TRUE;
                                DumpCustEnt.Located := TRUE;
                                DumpCustEnt.MODIFY;
                            END;
                    END ELSE BEGIN
                        //DumpCustEnt.Located:=FALSE;
                        //DumpCustEnt.MODIFY;
                    END;
                    "MAWB Header 2".MODIFY;
                END;
                SLEEP(100);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Processing MAWBS \MAWB No #1### \Consolidated #2###');
                //SETRANGE("MAWB Header 2".Status,"MAWB Header 2".Status::Archived);
                //SETRANGE("MAWB Header 2"."Has Houses",FALSE);
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
        MAWBInvoiceCharge: Record "50073";
        DumpCustEnt: Record "50062";
        HAWBLine: Record "50074";
}

