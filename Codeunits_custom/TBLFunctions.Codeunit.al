codeunit 50018 "TBL Functions"
{

    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure UpdateBookingDetails(ArchiveMAWB: Record "50077")
    var
        lRecBookingSheetMAWBAlloc: Record "50070";
        lRecBookingSheetHr: Record "50053";
        lRecBookingSheetLine: Record "50054";
        lRecBookingSheetMAWBAlloc2: Record "50070";
        lRecBookingSheetLine2: Record "50054";
        lRecArchiveMAWBLine: Record "50076";
        lRecBookingSheetHAWBAlloc: Record "50056";
        lRecBookingSheetHAWBAlloc2: Record "50056";
        lRecBookingSheetULDAlloc: Record "50055";
        lRecBookingSheetULDAlloc2: Record "50055";
        lRecLoadingSheetLine: Record "50061";
    begin
        //Update Booking sheets TBLBT
        lRecBookingSheetMAWBAlloc.RESET;
        lRecBookingSheetMAWBAlloc.SETCURRENTKEY(lRecBookingSheetMAWBAlloc."MAWB No");
        lRecBookingSheetMAWBAlloc.SETRANGE("MAWB No", ArchiveMAWB."No.");
        IF lRecBookingSheetMAWBAlloc.FINDSET THEN
            REPEAT
                //Update Bookingsheet details
                lRecBookingSheetHr.RESET;
                lRecBookingSheetHr.SETRANGE("No.", lRecBookingSheetMAWBAlloc."Booking Sheet No");
                lRecBookingSheetHr.SETRANGE(Status, lRecBookingSheetHr.Status::Received);
                IF lRecBookingSheetHr.FIND('-') THEN BEGIN
                    //Update Booking Sheet MAWB Allocations
                    IF lRecBookingSheetMAWBAlloc2.GET(lRecBookingSheetMAWBAlloc."Booking Sheet No", lRecBookingSheetMAWBAlloc."Line No."
                                                  , lRecBookingSheetMAWBAlloc."Item No", lRecBookingSheetMAWBAlloc."MAWB No", lRecBookingSheetMAWBAlloc."Airline Code"
                                                  , lRecBookingSheetMAWBAlloc."Flight No", lRecBookingSheetMAWBAlloc."Source Airport", lRecBookingSheetMAWBAlloc."Destination Airport"
                                                  , lRecBookingSheetMAWBAlloc."Shipper Code") THEN BEGIN
                        //Fetch MAWB Lines
                        lRecArchiveMAWBLine.RESET;
                        lRecArchiveMAWBLine.SETRANGE("MAWB No.", ArchiveMAWB."No.");
                        IF lRecArchiveMAWBLine.FINDSET THEN
                            REPEAT
                                lRecBookingSheetMAWBAlloc2.RENAME(lRecBookingSheetMAWBAlloc."Booking Sheet No", lRecBookingSheetMAWBAlloc."Line No."
                                                            , lRecArchiveMAWBLine."Item No.", lRecBookingSheetMAWBAlloc."MAWB No", ArchiveMAWB."Airline Code"
                                                            , ArchiveMAWB."Flight Code", ArchiveMAWB."Source Airport", ArchiveMAWB."Destination Airport"
                                                            , lRecBookingSheetMAWBAlloc."Shipper Code");

                                // Update Loading Sheet Lines
                                lRecLoadingSheetLine.RESET;
                                lRecLoadingSheetLine.SETRANGE("MAWB No.", lRecArchiveMAWBLine."MAWB No.");
                                IF lRecLoadingSheetLine.FINDSET THEN
                                    REPEAT
                                        lRecLoadingSheetLine."Item No." := lRecArchiveMAWBLine."Item No.";
                                        lRecLoadingSheetLine.MODIFY;
                                    UNTIL lRecLoadingSheetLine.NEXT = 0;

                            UNTIL lRecArchiveMAWBLine.NEXT = 0;
                    END;//BSMAWB End

                    lRecBookingSheetHr."MAWB No." := ArchiveMAWB."No.";
                    lRecBookingSheetHr."Airline Code" := ArchiveMAWB."Airline Code";
                    lRecBookingSheetHr."Flight Code" := ArchiveMAWB."Flight Code";
                    lRecBookingSheetHr."Destination Code" := ArchiveMAWB."Destination Code";
                    lRecBookingSheetHr.MODIFY;
                    //Update Lines
                    lRecBookingSheetLine.RESET;
                    lRecBookingSheetLine.SETRANGE("Booking Sheet No.", lRecBookingSheetHr."No.");
                    IF lRecBookingSheetLine.FINDSET THEN
                        REPEAT
                            //Fetch MAWB Lines
                            lRecArchiveMAWBLine.RESET;
                            lRecArchiveMAWBLine.SETRANGE("MAWB No.", ArchiveMAWB."No.");
                            IF lRecArchiveMAWBLine.FINDSET THEN
                                REPEAT
                                    //HAWB Allocations
                                    lRecBookingSheetHAWBAlloc.RESET;
                                    lRecBookingSheetHAWBAlloc.SETRANGE("Booking Sheet No.", lRecBookingSheetLine."Booking Sheet No.");
                                    lRecBookingSheetHAWBAlloc.SETRANGE("MAWB No.", ArchiveMAWB."No.");
                                    IF lRecBookingSheetHAWBAlloc.FINDSET THEN
                                        REPEAT
                                            IF lRecBookingSheetHAWBAlloc2.GET(lRecBookingSheetHAWBAlloc."Booking Sheet No.", lRecBookingSheetHAWBAlloc."Airline Code", lRecBookingSheetHAWBAlloc."Flight Code",
                                                                             lRecBookingSheetHAWBAlloc."Shipper Code", lRecBookingSheetHAWBAlloc."Item No.", lRecBookingSheetHAWBAlloc."Consignee Code",
                                                                             lRecBookingSheetHAWBAlloc."Source Airport", lRecBookingSheetHAWBAlloc."Destination Airport", lRecBookingSheetHAWBAlloc."MAWB No.") THEN
                                                lRecBookingSheetHAWBAlloc2.RENAME(lRecBookingSheetHAWBAlloc."Booking Sheet No.", ArchiveMAWB."Airline Code", ArchiveMAWB."Flight Code",
                                                                                 lRecBookingSheetHAWBAlloc."Shipper Code", lRecArchiveMAWBLine."Item No.", lRecBookingSheetHAWBAlloc."Consignee Code",
                                                                                 ArchiveMAWB."Source Airport", ArchiveMAWB."Destination Airport", lRecBookingSheetHAWBAlloc."MAWB No.");
                                        UNTIL lRecBookingSheetHAWBAlloc.NEXT = 0; //HAWB End
                                                                                  //ULD Allocations
                                    lRecBookingSheetULDAlloc.RESET;
                                    lRecBookingSheetULDAlloc.SETRANGE("Booking Sheet No.", lRecBookingSheetLine."Booking Sheet No.");
                                    lRecBookingSheetULDAlloc.SETRANGE("MAVB No.", ArchiveMAWB."No.");
                                    IF lRecBookingSheetULDAlloc.FINDSET THEN
                                        REPEAT
                                            IF lRecBookingSheetULDAlloc2.GET(lRecBookingSheetULDAlloc."Booking Sheet No.", lRecBookingSheetULDAlloc."Airline Code",
                                                                            lRecBookingSheetULDAlloc."Flight Code", lRecBookingSheetULDAlloc."Shipper Code",
                                                                            lRecBookingSheetULDAlloc."Item No.", lRecBookingSheetULDAlloc."ULD Type Code",
                                                                            lRecBookingSheetULDAlloc."Destination Airport", lRecBookingSheetULDAlloc."Source Airport",
                                                                            lRecBookingSheetULDAlloc."MAVB No.", lRecBookingSheetULDAlloc.Consignee) THEN
                                                lRecBookingSheetULDAlloc2.RENAME(lRecBookingSheetULDAlloc."Booking Sheet No.", ArchiveMAWB."Airline Code",
                                                                              ArchiveMAWB."Flight Code", lRecBookingSheetULDAlloc."Shipper Code",
                                                                              lRecArchiveMAWBLine."Item No.", lRecBookingSheetULDAlloc."ULD Type Code",
                                                                              ArchiveMAWB."Destination Airport", ArchiveMAWB."Source Airport",
                                                                              lRecBookingSheetULDAlloc."MAVB No.", lRecBookingSheetULDAlloc.Consignee);
                                        UNTIL lRecBookingSheetULDAlloc.NEXT = 0;//ULD END


                                    lRecBookingSheetLine.Description := ArchiveMAWB."Item Description";
                                    lRecBookingSheetLine."Destination Code" := ArchiveMAWB."Destination Code";
                                    lRecBookingSheetLine."Source Airport" := ArchiveMAWB."Source Airport";
                                    lRecBookingSheetLine."Destination Airport" := ArchiveMAWB."Destination Airport";
                                    lRecBookingSheetLine.Type := lRecArchiveMAWBLine.Type;
                                    lRecBookingSheetLine."Item No." := lRecArchiveMAWBLine."Item No.";
                                    lRecBookingSheetLine.Description := lRecArchiveMAWBLine.Description;
                                    lRecBookingSheetLine.MODIFY;
                                UNTIL lRecArchiveMAWBLine.NEXT = 0;

                            COMMIT;

                            IF lRecBookingSheetLine2.GET(lRecBookingSheetLine."Booking Sheet No.", lRecBookingSheetLine."Line No.",
                                                         lRecBookingSheetLine."Airline Code", lRecBookingSheetLine."Flight Code") THEN BEGIN
                                lRecBookingSheetLine2.RENAME(lRecBookingSheetLine."Booking Sheet No.", lRecBookingSheetLine."Line No.",
                                                             ArchiveMAWB."Airline Code", ArchiveMAWB."Flight Code");
                            END;
                        UNTIL lRecBookingSheetLine.NEXT = 0;
                END;
            UNTIL lRecBookingSheetMAWBAlloc.NEXT = 0;
    end;
}

