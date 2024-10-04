codeunit 50032 "Update Log"
{
    TableNo = "MAWB Header 2";

    trigger OnRun()
    begin
        Rec.TESTFIELD("Flight Code");
        Rec.TESTFIELD("Source Airport");
        Rec.TESTFIELD("Destination Airport");
        Rec.TESTFIELD("Airline Code");
        BKMawb.RESET;
        BKMawb.SETRANGE(BKMawb."MAWB No", Rec."No.");
        IF BKMawb.FINDSET THEN BEGIN
            REPEAT
                IF ((Rec."Destination Airport" <> BKMawb."Destination Airport") OR (BKMawb."Airline Code" <> Rec."Airline Code")) THEN BEGIN
                    IF CONFIRM('Do you want to rename the MAWB Details?') THEN BEGIN
                        BKMawb.RENAME(BKMawb."Booking Sheet No", BKMawb."Line No.", BKMawb."Item No", Rec."No.", Rec."Airline Code", Rec."Flight Code", Rec."Source Airport", Rec."Destination Airport", BKMawb."Shipper Code");
                        BKLine.RESET;
                        BKLine.SETRANGE(BKLine."Booking Sheet No.", BKMawb."Booking Sheet No");
                        IF BKLine.FINDSET THEN BEGIN
                            REPEAT
                                BKLine.RENAME(BKLine."Booking Sheet No.", BKLine."Line No.", Rec."Airline Code", Rec."Flight Code");
                                BKLine1.RESET;
                                BKLine1.SETRANGE(BKLine1."Booking Sheet No.", BKLine."Booking Sheet No.");
                                BKLine1.SETRANGE(BKLine1."Line No.", BKLine."Line No.");
                                BKLine1.SETRANGE(BKLine1."Airline Code", BKLine."Airline Code");
                                BKLine1.SETRANGE(BKLine1."Flight Code", BKLine."Flight Code");
                                IF BKLine1.FINDFIRST THEN BEGIN
                                    BKLine1."Source Airport" := Rec."Source Airport";
                                    BKLine1."Destination Airport" := Rec."Destination Airport";
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
        BKMawb: Record "Booking Sheet MAWB Allocation";
        BKLine: Record "Booking Sheet Line";
        BKLine1: Record "Booking Sheet Line";
}

