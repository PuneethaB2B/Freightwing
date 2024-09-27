report 50063 "Update MAWB Dates"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50076)
        {

            trigger OnAfterGetRecord()
            begin
                bookingsheetmawb.RESET;
                bookingsheetmawb.SETRANGE(bookingsheetmawb."MAWB No", "MAWB Line"."MAWB No.");
                //bookingsheetmawb.SETRANGE(bookingsheetmawb."Item No","MAWB Line"."Item No.");
                // bookingsheetmawb.SETRANGE(bookingsheetmawb."Shipper Code","MAWB Line"."Shipper Code");
                //bookingsheetmawb.SETRANGE(bookingsheetmawb."Flight No","MAWB Line"."Flight Code");
                IF bookingsheetmawb.FINDFIRST THEN BEGIN
                    IF "MAWB Line"."Airline Code" <> '' THEN BEGIN
                        Airlines.GET("MAWB Line"."Airline Code");
                    END ELSE BEGIN
                        "MAWB Line"."Airline Code" := bookingsheetmawb."Airline Code";
                        Airlines.GET(bookingsheetmawb."Airline Code");
                    END;
                    Window.UPDATE(1, Airlines.Name);
                    Window.UPDATE(2, bookingsheetmawb."MAWB No");
                    Window.UPDATE(3, 'Booking Sheet');
                    SLEEP(100);
                    BookingSheet.GET(bookingsheetmawb."Booking Sheet No");
                    "MAWB Line"."Flight Date" := BookingSheet."Booking Date";
                    //"MAWB Line"."Shipper Code":=bookingsheetmawb."Shipper Code";
                    "MAWB Line"."Flight Code" := bookingsheetmawb."Flight No";
                    "MAWB Line".MODIFY();
                END ELSE BEGIN
                END;
                //Window.CLOSE;

                //END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('MAWB Lines Updated');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Updating MAWB Lines \Airline #1##### \MAWB No. #2##### \Getting Details From #3####');
                "MAWB Line".SETFILTER("MAWB Line"."Flight Date", '');
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
        bookingsheetmawb: Record "50070";
        BookingSheet: Record "50053";
        LoadingSheet: Record "50060";
        Window: Dialog;
        Airlines: Record "50021";
}

