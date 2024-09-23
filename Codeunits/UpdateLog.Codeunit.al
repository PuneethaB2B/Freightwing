codeunit 50032 "Update Log"
{
    TableNo = 50077;

    trigger OnRun()
    begin
        TESTFIELD("Flight Code");
        TESTFIELD("Source Airport");
        TESTFIELD("Destination Airport");
        TESTFIELD("Airline Code");
        BKMawb.RESET;
        BKMawb.SETRANGE(BKMawb."MAWB No", "No.");
        IF BKMawb.FINDSET THEN BEGIN
            REPEAT
                IF (("Destination Airport" <> BKMawb."Destination Airport") OR (BKMawb."Airline Code" <> "Airline Code")) THEN BEGIN
                    IF CONFIRM('Do you want to rename the MAWB Details?') THEN BEGIN
                        BKMawb.RENAME(BKMawb."Booking Sheet No", BKMawb."Line No.", BKMawb."Item No", "No.", "Airline Code", "Flight Code", "Source Airport", "Destination Airport", BKMawb."Shipper Code");
                        BKLine.RESET;
                        BKLine.SETRANGE(BKLine."Booking Sheet No.", BKMawb."Booking Sheet No");
                        IF BKLine.FINDSET THEN BEGIN
                            REPEAT
                                BKLine.RENAME(BKLine."Booking Sheet No.", BKLine."Line No.", "Airline Code", "Flight Code");
                                BKLine1.RESET;
                                BKLine1.SETRANGE(BKLine1."Booking Sheet No.", BKLine."Booking Sheet No.");
                                BKLine1.SETRANGE(BKLine1."Line No.", BKLine."Line No.");
                                BKLine1.SETRANGE(BKLine1."Airline Code", BKLine."Airline Code");
                                BKLine1.SETRANGE(BKLine1."Flight Code", BKLine."Flight Code");
                                IF BKLine1.FINDFIRST THEN BEGIN
                                    BKLine1."Source Airport" := "Source Airport";
                                    BKLine1."Destination Airport" := "Destination Airport";
                                    BKLine1.MODIFY;
                                END;
                            UNTIL BKLine.NEXT = 0;
                        END;
                        MESSAGE('Booking Sheet Updated');
                    END;
                END;
            UNTIL BKMawb.NEXT = 0;
        END;
    end;

    var
        BKMawb: Record "50070";
        BKLine: Record "50054";
        BKLine1: Record "50054";
}

