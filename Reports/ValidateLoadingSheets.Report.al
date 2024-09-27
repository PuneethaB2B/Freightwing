report 50107 "Validate Loading Sheets"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateLoadingSheets.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50060)
        {

            trigger OnAfterGetRecord()
            begin
                BookingSheetMAWBAllocation.RESET;
                BookingSheetMAWBAllocation.SETRANGE(BookingSheetMAWBAllocation."MAWB No", "Loading Sheet Header"."MAWB No.");
                IF BookingSheetMAWBAllocation.FINDFIRST THEN BEGIN
                    "Loading Sheet Header"."Airline Code" := BookingSheetMAWBAllocation."Airline Code";
                END;
                "Loading Sheet Header".MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("Loading Sheet Header"."Airline Code", '');
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
        BookingSheetMAWBAllocation: Record "50070";
}

