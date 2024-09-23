report 50071 "Close Invoiced MAWBs"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {

            trigger OnAfterGetRecord()
            begin
                mawball.RESET;
                mawball.SETRANGE(mawball."MAWB No", "MAWB Receipt"."MAWB No.");
                IF mawball.FINDFIRST THEN BEGIN
                    IF BookingSheetHeader.GET(mawball."Booking Sheet No") THEN BEGIN
                        "MAWB Receipt"."Assigned Date" := BookingSheetHeader."Booking Date";
                        IF NOT "MAWB Receipt".Assigned THEN BEGIN
                            "MAWB Receipt".Assigned := TRUE;
                        END;
                        "MAWB Receipt".MODIFY;
                    END;
                END;

                MAWBHeader2.RESET;
                MAWBHeader2.SETRANGE(MAWBHeader2."No.", "MAWB Receipt"."MAWB No.");
                IF MAWBHeader2.FINDFIRST THEN BEGIN
                    "MAWB Receipt".Prepared := TRUE;
                    "MAWB Receipt"."Prepared Date" := MAWBHeader2."Preparation Date";
                    "MAWB Receipt".MODIFY;
                END;

                SalesInvoiceHeader.RESET;
                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."External Document No.", "MAWB Receipt"."MAWB No.");
                IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
                    Window.UPDATE(1, SalesInvoiceHeader."External Document No.");
                    IF (CountMawb(SalesInvoiceHeader."External Document No.") = 1) THEN BEGIN
                        "MAWB Receipt".Invoiced := TRUE;
                        "MAWB Receipt"."Invioced Date" := SalesInvoiceHeader."Document Date";
                        "MAWB Receipt".MODIFY;
                        BookingSheetMAWBAllocation1.RESET;
                        BookingSheetMAWBAllocation1.SETRANGE(BookingSheetMAWBAllocation1."MAWB No", "MAWB Receipt"."MAWB No.");
                        IF BookingSheetMAWBAllocation1.FINDFIRST THEN BEGIN
                            BookingSheetMAWBAllocation1.Invoiced := TRUE;
                            BookingSheetMAWBAllocation1.MODIFY;
                        END;
                    END ELSE BEGIN
                        BookingSheetMAWBAllocation.RESET;
                        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", SalesInvoiceHeader."MAWB No.");
                        BookingSheetMAWBAllocation.SETRANGE(Invoiced, FALSE);
                        BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."Shipper Code", SalesInvoiceHeader."Sell-to Customer No.");
                        IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                            BookingSheetMAWBAllocation.Invoiced := TRUE;
                            BookingSheetMAWBAllocation.MODIFY;
                        END;
                    END;
                END ELSE BEGIN
                    "MAWB Receipt".Invoiced := FALSE;
                    "MAWB Receipt".MODIFY;
                END;
                SLEEP(50);
            end;

            trigger OnPostDataItem()
            begin
                //REPORT.RUN(50072,FALSE,FALSE,"MAWB Receipt");
                MESSAGE('Updated');
            end;

            trigger OnPreDataItem()
            begin
                //"MAWB Receipt".SETRANGE("MAWB Receipt".Invoiced,FALSE);
                Window.OPEN('Checking MAWBS \#1###');
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
        SalesInvoiceHeader: Record "112";
        BookingSheetMAWBAllocation: Record "50070";
        Window: Dialog;
        MAWBReceipt: Record "50039";
        BookingSheetMAWBAllocation1: Record "50070";
        BookingSheetHeader: Record "50053";
        mawball: Record "50070";
        MAWBHeader2: Record "50077";

    local procedure CountMawb(MAWBno: Code[50]) "No.": Integer
    var
        BsMawb: Record "50070";
        int: Integer;
    begin
        "No." := 0;
        BsMawb.RESET;
        BsMawb.SETRANGE(BsMawb."MAWB No", MAWBno);
        IF BsMawb.FINDSET THEN BEGIN
            REPEAT
                "No." += 1;
                //MESSAGE('%1 MWAB  %2',"No.",MAWBno);
            UNTIL BsMawb.NEXT = 0;
        END;
        //MESSAGE('Shippers %1',"No.");
        EXIT("No.");
    end;
}

