table 50041 "Dl. Weight Dist. By Airline"
{

    fields
    {
        field(1; "Daily No."; Code[20])
        {
            TableRelation = "Dl. Weight Dist. Header"."No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;

            trigger OnValidate()
            begin
                DailyWeightDistHeader.RESET;
                DailyWeightDistHeader.SETRANGE(DailyWeightDistHeader."No.", "Daily No.");
                IF DailyWeightDistHeader.FINDFIRST THEN BEGIN
                    DailyWeightDistHeader.TESTFIELD("Distribution Date");
                    DailyWeightDistHeader.TESTFIELD(Description);
                    EVALUATE(DayofWeek, DailyWeightDistHeader."Day of Week");
                    "Day of Week" := DayofWeek;
                    "Distribution Date" := DailyWeightDistHeader."Distribution Date";
                    Airline.RESET;
                    Airline.SETRANGE(Airline.Code, "Airline Code");
                    IF Airline.FINDFIRST THEN BEGIN
                        "Airline Name" := Airline.Name;
                    END;
                END;
            end;
        }
        field(3; "Airline Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Total Capacity Planned"; Decimal)
        {
            CalcFormula = Sum("Weight Agreement By Item"."Min. Chargeable Weight" WHERE("Airline Code" = FIELD("Airline Code"),
                                                                                         "Destination Code" = FIELD("Destination Code"),
                                                                                         "Day of Week" = FIELD("Day of Week"),
                                                                                         "Destination Airport" = FIELD("Destination Airport"),
                                                                                         "Source Airport" = FIELD("Source Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Actual Weight Booked"; Decimal)
        {
            Editable = false;
        }
        field(6; "Cut-off Time"; Time)
        {
            Editable = true;
        }
        field(7; "Capacity Available"; Decimal)
        {
            Editable = false;
        }
        field(8; Difference; Decimal)
        {
        }
        field(9; "Total Weight Allocated"; Decimal)
        {
            CalcFormula = Sum("Dl. Weight Dist. By Item"."Gross Weight" WHERE("Daily No." = FIELD("Daily No."),
                                                                               "Airline Code" = FIELD("Airline Code"),
                                                                               "Flight Code" = FIELD("Flight Code"),
                                                                               "Destination Code" = FIELD("Destination Code"),
                                                                               "Destination Airport" = FIELD("Destination Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Day of Week"; Option)
        {
            Editable = true;
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(11; "Destination Code"; Code[20])
        {
            Editable = true;
            TableRelation = "Country/Region".Code;
        }
        field(12; "Actual Departure Time"; Time)
        {
        }
        field(13; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No." WHERE("Airline Code" = FIELD("Airline Code"));

            trigger OnValidate()
            begin
                Flights.RESET;
                Flights.SETRANGE(Flights."Airline Code", "Airline Code");
                Flights.SETRANGE(Flights."Flight No.", "Flight Code");
                IF Flights.FINDSET THEN BEGIN
                    REPEAT
                        WtByAirline.RESET;
                        WtByAirline.SETRANGE(WtByAirline."Daily No.", "Daily No.");
                        WtByAirline.SETRANGE(WtByAirline."Airline Code", Flights."Airline Code");
                        WtByAirline.SETRANGE(WtByAirline."Flight Code", Flights."Flight No.");
                        WtByAirline.SETRANGE(WtByAirline."Destination Code", Flights."Destination Code");
                        WtByAirline.SETRANGE(WtByAirline."Destination Airport", Flights."Destination Airport");
                        IF WtByAirline.FIND('-') THEN BEGIN
                            Flights1.RESET;
                            Flights1.SETRANGE(Flights1."Flight No.", "Flight Code");
                            Flights1.SETFILTER(Flights1."Destination Airport", '<>%1', WtByAirline."Destination Airport");
                            Flights1.SETFILTER(Flights1."Source Airport", '<>%1', WtByAirline."Source Airport");
                            IF Flights1.FINDFIRST THEN BEGIN
                                "Flight Code" := Flights1."Flight No.";
                                "Scheduled Departure Time" := Flights1."Departure Time";
                                //"Destination Code":=Flights1."Destination Code";
                                "Source Code" := Flights1."Source Code";
                                "Source Airport" := Flights1."Source Airport";
                                //"Destination Airport":=Flights1."Destination Airport";
                                "Shipment Delivery Time" := Flights1."Shipment Delivery Time";
                                "Cut-off Time" := Flights1."Cut Off Time";
                            END;
                        END ELSE BEGIN
                            "Flight Code" := Flights."Flight No.";
                            "Scheduled Departure Time" := Flights."Departure Time";
                            //"Destination Code":=Flights."Destination Code";
                            "Source Code" := Flights."Source Code";
                            "Source Airport" := Flights."Source Airport";
                            //"Destination Airport":=Flights."Destination Airport";
                            "Shipment Delivery Time" := Flights."Shipment Delivery Time";
                            "Cut-off Time" := Flights."Cut Off Time";
                        END;
                    UNTIL Flights.NEXT = 0;
                END;
            end;
        }
        field(14; "Distribution Date"; Date)
        {
        }
        field(15; "Scheduled Departure Time"; Time)
        {

            trigger OnValidate()
            begin
                ImportExportSetup.GET();
                "Cut-off Time" := "Scheduled Departure Time" - (ImportExportSetup."CutOff Time" * (60 * 60 * 1000));
            end;
        }
        field(16; "Source Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Country/Region";
        }
        field(17; "Source Airport"; Code[50])
        {
            Editable = true;
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Source Code"));
        }
        field(18; "Destination Airport"; Code[50])
        {
            Editable = true;
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Destination Code"));
        }
        field(19; "Shipment Delivery Time"; Decimal)
        {
            Editable = false;
        }
        field(20; "Actual Departure Date"; Date)
        {
        }
        field(21; "Total Shipped Weight"; Decimal)
        {
            CalcFormula = Sum("Dl. Weight Dist. By Item"."Shipped Weight" WHERE("Daily No." = FIELD("Daily No."),
                                                                                 "Airline Code" = FIELD("Airline Code"),
                                                                                 "Flight Code" = FIELD("Flight Code"),
                                                                                 "Destination Code" = FIELD("Destination Code"),
                                                                                 "Destination Airport" = FIELD("Destination Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Scheduled Arrival Time"; Time)
        {
        }
        field(23; "Actual Arrival Time"; Time)
        {
        }
        field(24; "Actual Arrival Date"; Date)
        {
        }
        field(25; "Scheduled Arrival Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Daily No.", "Airline Code", "Flight Code", "Destination Code", "Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DailyWeightDistHeader: Record 50040;
        DayofWeek: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        Airline: Record 50021;
        DailyWeightDistByCustomer: Record 50042;
        Flights: Record 50022;
        WtByAirline: Record 50041;
        viaDest: Record 50024;
        Flights1: Record 50022;
        ImportExportSetup: Record 50010;
}

