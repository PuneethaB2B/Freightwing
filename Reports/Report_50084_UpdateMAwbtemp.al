report 50084 "Update MAwb temp"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("MAWB Receipt"; "MAWB Receipt")
        {

            trigger OnAfterGetRecord()
            begin
                MAWBReceipt.RESET;
                MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.", "MAWB Receipt"."MAWB No.");
                IF MAWBReceipt.FINDSET THEN BEGIN
                    i := 0;
                    recd := '';
                    REPEAT
                        i += 1;
                        recd := recd + ' & ' + MAWBReceipt."Airline Code"
                    UNTIL MAWBReceipt.NEXT = 0;
                END;

                TempMAWB.RESET;
                TempMAWB.SETRANGE(TempMAWB.MAW, "MAWB Receipt"."MAWB No.");
                IF NOT TempMAWB.FINDFIRST THEN BEGIN
                    IF i > 1 THEN BEGIN
                        IF TempMAWB.FINDLAST THEN
                            LineNO := TempMAWB.LineNo + 1000
                        ELSE
                            LineNO := 1000;

                        TempMAWB.INIT;
                        TempMAWB.MAW := "MAWB Receipt"."MAWB No.";
                        TempMAWB.LineNo := LineNO;
                        TempMAWB.Airline := "MAWB Receipt"."Airline Code";
                        TempMAWB.Occurence := i;
                        TempMAWB."Recorded in" := recd;
                        TempMAWB.INSERT;
                        LineNO += 1000;
                    END;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Validating MAWBS#1##');
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
        MAWBReceipt: Record 50039;
        Window: Dialog;
        i: Integer;
        TempMAWB: Record 50002;
        LineNO: Integer;
        recd: Text[30];
}

