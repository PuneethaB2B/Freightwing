report 50033 "Flight Performance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './FlightPerformance.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Dl. Weight Dist. By Airline"; "Dl. Weight Dist. By Airline")
        {
            RequestFilterFields = "Airline Code", "Flight Code";
            column(Company_Name; gRecCompanyInfo.Name)
            {
            }
            column(Company_Picture; gRecCompanyInfo.Picture)
            {
            }
            column(Flight_AirLine_Code; "Dl. Weight Dist. By Airline"."Airline Code")
            {
            }
            column(Flight_Code; "Dl. Weight Dist. By Airline"."Flight Code")
            {
            }
            column(Destination_Code; "Dl. Weight Dist. By Airline"."Destination Code")
            {
            }
            column(Destination_Airport; "Dl. Weight Dist. By Airline"."Destination Airport")
            {
            }
            column(Airline_Name; "Dl. Weight Dist. By Airline"."Airline Name")
            {
            }
            column(Actual_Weight_Booked; "Dl. Weight Dist. By Airline"."Actual Weight Booked")
            {
            }
            column(Cut_off_Time; "Dl. Weight Dist. By Airline"."Cut-off Time")
            {
            }
            column(Scheduled_Dept_Time; "Dl. Weight Dist. By Airline"."Scheduled Departure Time")
            {
            }
            column(Shipment_Delivery_Time; "Dl. Weight Dist. By Airline"."Shipment Delivery Time")
            {
            }
            column(Actual_Dept_Date; "Dl. Weight Dist. By Airline"."Actual Departure Date")
            {
            }
            column(Actual_Dept_Time; "Dl. Weight Dist. By Airline"."Actual Departure Time")
            {
            }
            column(Scheduled_Arrival_Date; "Dl. Weight Dist. By Airline"."Scheduled Arrival Date")
            {
            }
            column(Scheduled_Arrival_Time; "Dl. Weight Dist. By Airline"."Scheduled Arrival Time")
            {
            }
            column(Actual_Arrival_Date; "Dl. Weight Dist. By Airline"."Actual Arrival Date")
            {
            }
            column(Actual_Arrival_Time; "Dl. Weight Dist. By Airline"."Actual Arrival Time")
            {
            }
            column(Delayed; gTxtDelayed)
            {
            }
            column(TotalCapacityPlanned_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Total Capacity Planned")
            {
            }
            column(TotalWeightAllocated_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Total Weight Allocated")
            {
            }
            column(TotalShippedWeight_DlWeightDistByAirline; "Dl. Weight Dist. By Airline"."Total Shipped Weight")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(gTxtDelayed);
                IF ("Dl. Weight Dist. By Airline"."Actual Departure Time" <> 0T) AND ("Dl. Weight Dist. By Airline"."Scheduled Departure Time" <> 0T) THEN BEGIN
                    // "gTimeDepart.Delayed" := 000000T + ("Dl. Weight Dist. By Airline"."Actual Departure Time" - "Dl. Weight Dist. By Airline"."Scheduled Departure Time");

                    Time1 := "Dl. Weight Dist. By Airline"."Scheduled Departure Time";
                    Time2 := "Dl. Weight Dist. By Airline"."Actual Departure Time";

                    IF (Time1 <= 235959T) AND (Time2 >= 000000T) THEN BEGIN
                        t2 := 235959T - Time1 + 2000;
                        t3 := Time2 - 000000T;
                        t2 := t2 + t3;
                    END ELSE
                        IF (Time1 >= 000000T) AND (Time2 >= 000000T) THEN
                            t2 := Time2 - Time1
                        ELSE
                            IF (Time1 < 235959T) AND (Time2 < 235959T) THEN
                                t2 := Time2 - Time1;

                    Hours := ROUND(((t2 / 1000) / 60) / 60, 1);
                    Min := ROUND((t2 / 1000) / 60, 1);
                    gTxtDelayed := FORMAT(Hours) + ' Hours ' + FORMAT(Min) + ' Minutes';
                END;
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

    trigger OnPreReport()
    begin
        gRecCompanyInfo.GET;
        gRecCompanyInfo.CALCFIELDS(gRecCompanyInfo.Picture);
    end;

    var
        gRecCompanyInfo: Record "Company Information";
        "gTimeDepart.Delayed": Time;
        gTxtDelayed: Text;
        "gIntDepart.Delayed": Integer;
        Time1: Time;
        Time2: Time;
        t1: Time;
        t2: Integer;
        t3: Integer;
        Hours: Integer;
        "Min": Integer;
}

