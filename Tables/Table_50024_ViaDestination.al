table 50024 "Via Destination"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = Flight."Airline Code";
        }
        field(2; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No.";
        }
        field(3; "Via Destination Code"; Code[20])
        {
            TableRelation = "Country/Region";
        }
        field(7; "Departure Time"; Time)
        {

            trigger OnValidate()
            begin
                ValidateTime;
            end;
        }
        field(8; "Arrival Time"; Time)
        {

            trigger OnValidate()
            begin
                ValidateTime;
            end;
        }
        field(10; "FS Departure Date"; Time)
        {
            TableRelation = Flight."Departure Time";
        }
        field(11; "FS Destination Code"; Code[20])
        {
            TableRelation = Flight."Destination Code";
        }
        field(12; "FS Source Code"; Code[20])
        {
            TableRelation = Flight."Source Code";
        }
        field(13; Reason; Option)
        {
            OptionCaption = ' ,Bad weather,Delay in shipment of cargo';
            OptionMembers = " ","Bad weather","Delay in shipment of cargo";
        }
        field(14; Description; Text[50])
        {
        }
        field(15; Status; Option)
        {
            OptionCaption = 'On time,Delayed,Cancelled';
            OptionMembers = "On time",Delayed,Cancelled;
        }
        field(16; "Source Airport"; Code[50])
        {
            TableRelation = Flight."Source Airport" WHERE("Flight No." = FIELD("Flight Code"));
        }
        field(17; "Destination Airport"; Code[50])
        {
            TableRelation = Flight."Destination Airport" WHERE("Flight No." = FIELD("Flight Code"));
        }
        field(18; "Via Destination Airport"; Code[50])
        {
            TableRelation = Airport.Code WHERE("Country Code" = FIELD("Via Destination Code"));

            trigger OnValidate()
            begin
                Flights.RESET;
                Flights.SETRANGE(Flights."Airline Code", "Airline Code");
                Flights.SETRANGE(Flights."Flight Code", "Flight Code");
                Flights.SETRANGE(Flights."Source Code", "FS Source Code");
                Flights.SETRANGE(Flights."Destination Code", "FS Destination Code");
                Flights.SETRANGE(Flights."Source Airport", "Source Airport");
                Flights.SETRANGE(Flights."Destination Airport", "Destination Airport");
                IF Flights.FINDFIRST THEN BEGIN
                    IF "Via Destination Airport" = Flights."Destination Airport" THEN
                        ERROR(Text001, FIELDCAPTION("Via Destination Code"), Flights.TABLENAME, Flights.FIELDCAPTION("Source Code"))
                    ELSE IF "Via Destination Code" = Flights."Destination Code" THEN
                        ERROR(Text001, FIELDCAPTION("Via Destination Code"), Flights.TABLENAME, Flights.FIELDCAPTION("Destination Code"));
                END;
            end;
        }
        field(19; "Connecting Airline"; Code[50])
        {
            TableRelation = Airline.Code;
        }
        field(20; "Connecting Flight"; Code[50])
        {
            TableRelation = Flight."Flight No." WHERE("Airline Code" = FIELD("Connecting Airline"));
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Flight Code", "Via Destination Code", "Via Destination Airport", "Source Airport", "Destination Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Flights.RESET;
        Flights.SETRANGE(Flights."Airline Code", xRec."Airline Code");
        Flights.SETRANGE(Flights."Flight No.", xRec."Flight Code");
        IF Flights.FIND('-') THEN BEGIN
            Flights."Has Connection" := TRUE;
            Flights.MODIFY;
        END ELSE BEGIN
            Flights."Has Connection" := FALSE;
            Flights.MODIFY;

        END;
    end;

    trigger OnInsert()
    begin
        Flights.RESET;
        Flights.SETRANGE(Flights."Airline Code", "Airline Code");
        Flights.SETRANGE(Flights."Flight No.", "Flight Code");
        IF Flights.FIND('-') THEN BEGIN
            Flights."Has Connection" := TRUE;
            Flights.MODIFY;
        END;
    end;

    var
        Text001: Label '%1 cannot be the same as %2 %3';
        Text002: Label '%1 %2 cannot be less than %3 %4';
        Text003: Label '%1 %2 cannot be less than %3 %4';
        Text004: Label '%1 %2 cannot be greater than %3 %4';
        Text005: Label '%1 %2 cannot be blank';
        Flights: Record 50022;

    local procedure ValidateTime()
    begin
        /*IF ("Arrival Time"=0T)THEN
          ERROR(Text005,TABLENAME,FIELDCAPTION("Arrival Time"))
        ELSE IF  ("Departure Time"=0T) THEN
          ERROR(Text005,TABLENAME,FIELDCAPTION("Departure Time"))
        ELSE IF "Arrival Date"="Departure Date"THEN BEGIN
          IF "Departure Time"<"Arrival Time" THEN
            ERROR(Text002,TABLENAME,FIELDCAPTION("Departure Time"),TABLENAME,FIELDCAPTION("Arrival Time"))
        END; */

    end;
}

