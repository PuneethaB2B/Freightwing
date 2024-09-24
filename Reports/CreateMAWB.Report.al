report 50001 "Create MAWB"
{
    Caption = 'Create Master Airway Bill No.';
    ProcessingOnly = true;

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
                    field(AirlineCode; AirlineCode)
                    {
                        Caption = 'Airline Code';
                        Editable = false;
                    }
                    field(PrefixCode; PrefixCode)
                    {
                        Caption = 'Prefix Code';
                        Visible = false;
                    }
                    field(BillNo; BillNo)
                    {
                        Caption = 'Bill No.';
                    }
                    field(StartNo; StartNo)
                    {
                        Caption = 'Start No.';
                    }
                    field("Numbers to Generate"; "Numbers To Generate")
                    {
                    }
                    field("Incremental Value"; "Incremental Value")
                    {
                        Visible = false;
                    }
                    field("End No."; EndNo)
                    {
                        Caption = 'End No.';
                        Editable = false;
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            MAWBReceipt.RESET;
            MAWBReceipt.SETRANGE("Airline Code", AirlineCode);
            IF MAWBReceipt.FINDLAST THEN BEGIN
                PrefixCode := MAWBReceipt."Prefix Code";
                BillNo := MAWBReceipt."Bill No.";
                StartNo := MAWBReceipt."End No.";
                StartNo := StartNo + 1;
                EndNo := 0;
            END;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('MAWBs Created');
    end;

    trigger OnPreReport()
    begin
        Count := 0;
        IF PrefixCode = '' THEN BEGIN
            rec.GET(AirlineCode);
            IF rec."Prefix Code" = '' THEN
                ERROR('The Airline %1 has no Prefix Defined on Master Data', rec.Name);
        END
        ELSE BEGIN
        END;
        rec.GET(AirlineCode);
        PrefixCode := rec."Prefix Code";
        MAWBCount := "Numbers To Generate";
        NextNo := StartNo;
        ProgressWindow.OPEN('Creating MAWB number #1#######');
        IF CONFIRM(Text004, FALSE, FORMAT("Numbers To Generate"), (PrefixCode + BillNo + FORMAT(StartNo))) THEN
            IF NOT MAWBReceipt.FINDFIRST OR MAWBReceipt.FINDLAST THEN BEGIN
                REPEAT
                    SLEEP(100);
                    Count := Count + 1;
                    MAWBReceipt.INIT;
                    //NextNo:=NextNo+"Incremental Value";
                    ProgressWindow.UPDATE(1, PrefixCode + BillNo + FORMAT(NextNo));
                    MAWBReceipt."Airline Code" := AirlineCode;
                    MAWBChargesByAirline.RESET;
                    MAWBChargesByAirline.SETRANGE("Airline Code", AirlineCode);
                    IF MAWBChargesByAirline.FINDSET THEN BEGIN
                        REPEAT
                            MAWBLineCharge."Airline Code" := MAWBChargesByAirline."Airline Code";
                            MAWBLineCharge."MAWB No." := PrefixCode + BillNo + FORMAT(NextNo);
                            MAWBLineCharge.Code := '4';
                            MAWBLineCharge.Description := MAWBChargesByAirline.Description;
                            MAWBLineCharge.Amount := "Cost Per One Airway Bill";
                            MAWBLineCharge."Currency Code" := MAWBChargesByAirline."Currency Code";
                            MAWBLineCharge."G/L Account" := MAWBChargesByAirline."G/L Account";
                            MAWBLineCharge.INSERT;
                        UNTIL MAWBChargesByAirline.NEXT = 0;
                    END;
                    MAWBReceipt."MAWB No." := PrefixCode + BillNo + FORMAT(NextNo);
                    MAWBReceipt."Receipt Date" := TODAY;
                    MAWBReceipt."MAWB Fees" := rec."AWB Fee";
                    MAWBReceipt."Prefix Code" := PrefixCode;
                    MAWBReceipt."Bill No." := BillNo;
                    MAWBReceipt."Start No." := NextNo;
                    MAWBReceipt."End No." := NextNo;

                    MAWBReceipt.INSERT;
                    IF COPYSTR(FORMAT(NextNo), STRLEN(FORMAT(NextNo))) = '6' THEN BEGIN
                        "Incremental Value" := 4;
                        NextNo := NextNo + "Incremental Value";
                    END
                    ELSE BEGIN
                        "Incremental Value" := 11;
                        NextNo := NextNo + "Incremental Value";
                    END;
                UNTIL Count = "Numbers To Generate";
                ProgressWindow.CLOSE;
            END;
    end;

    var
        Text000: Label 'Prefix Code cannot be empty';
        Text001: Label 'Start No. cannot be zero';
        Text002: Label 'End No. cannot be zero';
        Text004: Label 'Do you want to create %1 MAWB No.''s From %2';
        Text003: Label 'End No. cannot be less than Start No.';
        PrefixCode: Code[10];
        StartNo: Integer;
        EndNo: Integer;
        MAWBReceipt: Record "50039";
        NextNo: Integer;
        ProgressWindow: Dialog;
        NewStartNo: Code[20];
        AirlineCode: Code[10];
        MAWBFees: Decimal;
        FreightChargeCode: Code[10];
        BillNo: Code[10];
        KAAFees: Decimal;
        MAWBCount: Integer;
        MAWBChargesByAirline: Record "50005";
        MAWBLineCharge: Record "50004";
        "Incremental Value": Integer;
        "Numbers To Generate": Integer;
        "Count": Integer;
        "Cost Per One Airway Bill": Decimal;
        rec: Record "50021";


    procedure SetPar(pAirlineCode: Code[20]; pMAWBFees: Decimal; pKAAFees: Decimal; pFreightChargeCode: Code[20]; Prefix: Code[10])
    var
        Airlines: Record "50021";
    begin
        PrefixCode := Prefix;
        AirlineCode := pAirlineCode;
        Airlines.GET(AirlineCode);
        MAWBFees := pMAWBFees;
        KAAFees := pKAAFees;
        FreightChargeCode := pFreightChargeCode;
        //Message(PrefixCode);
        StartNo := 0;
        EndNo := 0;
        BillNo := '';
    end;
}

