table 50026 "Freight Charge By Flight"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
        }
        field(2; "Flight Code"; Code[20])
        {
            TableRelation = Flight."Flight No." WHERE(Airline Code=FIELD(Airline Code));
        }
        field(3;Transist;Code[20])
        {
            TableRelation = Country/Region;
        }
        field(4;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;

            trigger OnValidate()
            begin
                //FreightChargeByAirline.GET("Airline Code");
                //FreightChargeByAirline.TESTFIELD("Effective Start Date");
                //FreightChargeByAirline.TESTFIELD("Effective End Date");

                CountryRegion.GET("Destination Code");
                "Destination Name":=CountryRegion.Name;
                 "Destination Country":=CountryRegion.Name;
            end;
        }
        field(5;"Destination Name";Text[50])
        {
            Editable = false;
        }
        field(6;"Source Airport";Text[50])
        {
        }
        field(7;"Destination Airport";Text[50])
        {
        }
        field(8;"Source Country";Text[50])
        {
        }
        field(9;"Destination Country";Text[50])
        {
        }
        field(10;"Effective Start Date";Date)
        {
            NotBlank = true;
        }
        field(11;"Effective End Date";Date)
        {
            NotBlank = true;
        }
    }

    keys
    {
        key(Key1;"Airline Code","Flight Code","Destination Airport","Source Airport","Effective Start Date","Effective End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ByItem.RESET;
        ByItem.SETRANGE(ByItem."Flight Code","Flight Code");
        ByItem.SETRANGE(ByItem."Destination Airport","Destination Airport");
        ByItem.SETRANGE(ByItem."Source Airport","Source Airport");
        ByItem.SETRANGE(ByItem."Effective Start Date","Effective Start Date");
        ByItem.SETRANGE(ByItem."Effective End Date","Effective End Date");
        IF ByItem.FIND('-') THEN
        ByItem.DELETEALL;
    end;

    trigger OnInsert()
    begin
        IF (("Effective Start Date"=0D)OR("Effective End Date"=0D)) THEN ERROR('');
    end;

    var
        FreightChargeByAirline: Record "50025";
        CountryRegion: Record "9";
        Flight: Record "50022";
        ByFlight: Record "50026";
        ViaDest: Record "50024";
        ByFlight2: Record "50026";
        ByItem: Record "50027";

    local procedure GetDestinations(FlightNo: Code[50])
    begin
        Flight.RESET;
        Flight.SETRANGE( Flight."Flight No.",FlightNo);
        IF Flight.FIND('-') THEN
        BEGIN
          ByFlight.RESET;
          ByFlight.SETRANGE(ByFlight."Flight Code",FlightNo);
          IF ByFlight.FIND('-') THEN
          BEGIN
            MESSAGE('Found Some By Flight');
            ViaDest.RESET;
            ViaDest.SETRANGE(ViaDest."Flight Code",FlightNo);
            IF ViaDest.FIND('-') THEN
            BEGIN
            MESSAGE('Via Dest');
                REPEAT
                  ByFlight2.INIT;
                  ByFlight2."Airline Code":=ViaDest."Airline Code";
                  ByFlight2."Flight Code":=ViaDest."Flight Code";
                  ByFlight2.VALIDATE(ByFlight2."Destination Airport",ViaDest."Destination Airport");
                  ByFlight2."Source Airport":=ViaDest."Source Airport";
                  ByFlight2.Transist:='';
                  ByFlight2."Destination Code":=ViaDest."Via Destination Code";
                  ByFlight2."Destination Name":='';
                  ByFlight2."Source Country":='';
                  ByFlight2."Destination Country":='';
                  ByFlight2.INSERT;
                UNTIL ViaDest.NEXT = 0;
              END;//End repeat
            END
            ELSE
            BEGIN
              ByFlight2.INIT;
              ByFlight2."Source Country":=Flight."Source Code";
              ByFlight2."Destination Country" :=Flight."Destination Code";
              ByFlight2."Source Airport":=Flight."Source Airport";
              ByFlight2."Destination Airport":=Flight."Destination Airport";
              ByFlight2.VALIDATE("Destination Code",Flight."Destination Code");
              ByFlight2.INSERT;
              ViaDest.RESET;
              ViaDest.SETRANGE(ViaDest."Flight Code",FlightNo);
              IF ViaDest.FIND('-') THEN
              BEGIN
              MESSAGE('Via Dest');
                  REPEAT
                    ByFlight2.INIT;
                    ByFlight2."Airline Code":=ViaDest."Airline Code";
                    ByFlight2."Flight Code":=ViaDest."Flight Code";
                    ByFlight2.VALIDATE(ByFlight2."Destination Airport",ViaDest."Destination Airport");
                    ByFlight2."Source Airport":=ViaDest."Source Airport";
                    ByFlight2.Transist:='';
                    ByFlight2."Destination Code":=ViaDest."Via Destination Code";
                    ByFlight2."Destination Name":='';
                    ByFlight2."Source Country":='';
                    ByFlight2."Destination Country":='';
                    ByFlight2.INSERT;
                  UNTIL ViaDest.NEXT = 0;
              END; //End Repeat
          END;//END ELse
        END;
    end;
}

