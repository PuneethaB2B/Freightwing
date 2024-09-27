report 50007 "Create HAWB 2"
{
    Caption = 'Create House Airway Bill No.';
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrefixCode; PrefixCode)
                    {
                        Caption = 'Prefix Code';
                        ApplicationArea = All;
                    }
                    field("BillNo."; BillNo)
                    {
                        Caption = 'Bill No.';
                        ApplicationArea = All;
                    }
                    field(StartNo; StartNo)
                    {
                        Caption = 'Start No.';
                        ApplicationArea = All;
                    }
                    field("End No."; EndNo)
                    {
                        Caption = 'End No.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF HAWBReceipt.FINDLAST THEN BEGIN
                PrefixCode := HAWBReceipt."Prefix Code";
                BillNo := HAWBReceipt."Bill No.";
                StartNo := HAWBReceipt."End No.";
                StartNo := INCSTR(StartNo);
                EndNo := '';
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF PrefixCode = '' THEN
            ERROR(Text000)
        ELSE
            IF BillNo = '' THEN
                ERROR(Text001)
            ELSE
                IF StartNo = '' THEN
                    ERROR(Text005)
                ELSE
                    IF EndNo = '' THEN
                        ERROR(Text002)
                    ELSE
                        IF EndNo < StartNo THEN
                            ERROR(Text003)
                        ELSE BEGIN
                            //NextNo:=StartNoInt-1;
                            // EVALUATE(StartNoInt,StartNo);
                            //NextNo:=StartNoInt-1;
                            // CNextNo:=FORMAT(NextNo);
                            CNextNo := StartNo;
                            ProgressWindow.OPEN('Creating HAWB number #1###############');
                            IF CONFIRM(Text004, FALSE, (PrefixCode + BillNo + StartNo), (PrefixCode + BillNo + EndNo)) THEN
                                IF NOT HAWBReceipt.FINDFIRST OR HAWBReceipt.FINDLAST THEN BEGIN
                                    REPEAT
                                        SLEEP(500);
                                        HAWBReceipt.INIT;
                                        //NextNo:=NextNo+1;
                                        CNextNo := INCSTR(CNextNo);
                                        ProgressWindow.UPDATE(1, PrefixCode + BillNo + CNextNo);

                                        HAWBReceipt."HAWB No." := (PrefixCode + BillNo + CNextNo);
                                        HAWBReceipt."Receipt Date" := TODAY;
                                        HAWBReceipt."Prefix Code" := PrefixCode;
                                        HAWBReceipt."Bill No." := BillNo;
                                        HAWBReceipt."Start No." := CNextNo;
                                        HAWBReceipt."End No." := CNextNo;

                                        HAWBReceipt.INSERT;
                                    UNTIL HAWBReceipt."End No." = EndNo;
                                    ProgressWindow.CLOSE;
                                END
                                ELSE
                                    EXIT;
                        END;
    end;

    var
        Text000: Label 'Prefix Code cannot be blank';
        Text001: Label 'Start No. cannot be blank';
        Text002: Label 'End No. cannot be blank';
        Text004: Label 'Do you want to create HAWB No. %1 to %2';
        Text003: Label 'End No. cannot be less than Start No.';
        PrefixCode: Code[10];
        StartNoInt: Integer;
        EndNoInt: Integer;
        HAWBReceipt: Record "50037";
        NextNo: Integer;
        ProgressWindow: Dialog;
        NewStartNo: Code[10];
        BillNo: Code[10];
        Text005: Label 'Bill No. cannot be blank';
        StartNo: Code[10];
        EndNo: Code[10];
        CNextNo: Code[10];
}

