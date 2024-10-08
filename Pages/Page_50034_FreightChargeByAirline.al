page 50034 "Freight Charge By Airline"
{
    PageType = Card;
    SourceTable = "Freight Charge By Airline";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                }
            }
            part(Page; "Freight Charge Flight Subform")
            {
                SubPageLink = "Airline Code" = FIELD("Airline Code"),
                              "Effective Start Date" = FIELD("Effective Start Date"),
                              "Effective End Date" = FIELD("Effective End Date");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(GetDesstinations)
            {
                Caption = 'Get Airline Destinations';
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GetAirlineDestinations(Rec."Airline Code");
                end;
            }
            action(ValidateDates)
            {
                Promoted = true;

                trigger OnAction()
                begin
                    ChargeByFlight.RESET;
                    ChargeByFlight.SETRANGE(ChargeByFlight."Airline Code", Rec."Airline Code");
                    IF ChargeByFlight.FINDSET THEN BEGIN
                        REPEAT
                            ChargeByFlight.RENAME(ChargeByFlight."Airline Code", ChargeByFlight."Flight Code", ChargeByFlight."Destination Airport", ChargeByFlight."Source Airport", Rec."Effective Start Date", Rec."Effective End Date");
                            ChargeByItem.RESET;
                            ChargeByItem.SETRANGE(ChargeByItem."Airline Code", ChargeByFlight."Airline Code");
                            ChargeByItem.SETRANGE(ChargeByItem."Flight Code", ChargeByFlight."Flight Code");
                            IF ChargeByItem.FINDSET THEN BEGIN
                                REPEAT
                                    ChargeByItem.RENAME(ChargeByItem."Airline Code", ChargeByItem."Flight Code", ChargeByItem."No.", ChargeByItem."Source Airport", ChargeByItem."Destination Airport", Rec."Effective Start Date", Rec."Effective End Date");
                                    ItemCharge.RESET;
                                    ItemCharge.SETRANGE(ItemCharge."Airline Code", ChargeByItem."Airline Code");
                                    ItemCharge.SETRANGE(ItemCharge."Flight Code", ChargeByItem."Flight Code");
                                    ItemCharge.SETRANGE(ItemCharge."Item No.", ChargeByItem."No.");
                                    IF ItemCharge.FINDSET THEN BEGIN
                                        REPEAT
                                            ItemCharge.RENAME(ItemCharge."Airline Code", ItemCharge."Flight Code", ItemCharge."Item No.", ItemCharge.Code, ItemCharge."Source Airport", ItemCharge."Destination Airport", Rec."Effective Start Date", Rec."Effective End Date");
                                            It.RESET;
                                            It.SETRANGE(It."Airline Code", ItemCharge."Airline Code");
                                            It.SETRANGE(It."Flight Code", ItemCharge."Flight Code");
                                            It.SETRANGE(It."Item No.", ItemCharge."Item No.");
                                            It.SETRANGE(It."Freight Charge Code", ItemCharge.Code);
                                            IF It.FINDSET THEN BEGIN
                                                REPEAT
                                                    It.RENAME(It."Airline Code", It."Flight Code", It."Item No.", It."Freight Charge Code", It."From Weight", It."To Weight", It."Source airport", It."Destination Airport", Rec."Effective Start Date", Rec."Effective End Date");
                                                UNTIL It.NEXT = 0;
                                            END;
                                        UNTIL ItemCharge.NEXT = 0;
                                    END;
                                UNTIL ChargeByItem.NEXT = 0;
                            END;
                        UNTIL ChargeByFlight.NEXT = 0;
                    END;
                end;
            }
            action("Duplicate Charges")
            {
                Image = CopyItem;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(CopyCharges);
                    CopyCharges.initParam(Rec);
                    CopyCharges.RUN;
                end;
            }
        }
    }

    var
        Flights: Record Flight;
        ViaDest: Record "Via Destination";
        ChargeByFlight: Record "Freight Charge By Flight";
        WeightByDest: Record "Weight Agreement Destination";
        ChargeByItem: Record "Freight Charge By Item";
        ItemCharge: Record "Freight Item Charge";
        It: Record "Freight Item Charge Matrix";
        FreightChargeByAirline: Record "Freight Charge By Airline";
        CopyCharges: Page "Copy Charges";

    local procedure GetAirlineDestinations(AirlineCode: Code[50])
    begin
        Flights.RESET;
        Flights.SETFILTER(Flights."Flight No.", '<>%1', '');
        Flights.SETRANGE(Flights."Airline Code", AirlineCode);
        IF Flights.FINDSET THEN BEGIN
            REPEAT
                ChargeByFlight.RESET;
                ChargeByFlight.SETRANGE(ChargeByFlight."Airline Code", Flights."Airline Code");
                ChargeByFlight.SETRANGE(ChargeByFlight."Flight Code", Flights."Flight No.");
                ChargeByFlight.SETRANGE(ChargeByFlight."Destination Airport", Flights."Destination Airport");
                ChargeByFlight.SETRANGE(ChargeByFlight."Source Airport", Flights."Source Airport");
                ChargeByFlight.SETFILTER(ChargeByFlight."Effective Start Date", '<=%1', Rec."Effective Start Date");
                ChargeByFlight.SETFILTER(ChargeByFlight."Effective End Date", '>=%1', Rec."Effective End Date");
                IF ChargeByFlight.FINDFIRST THEN BEGIN
                END ELSE BEGIN
                    ChargeByFlight.INIT;
                    ChargeByFlight."Airline Code" := AirlineCode;
                    ChargeByFlight."Flight Code" := Flights."Flight No.";
                    ChargeByFlight.VALIDATE(ChargeByFlight."Destination Airport", Flights."Destination Airport");
                    ChargeByFlight."Source Airport" := Flights."Source Airport";
                    ChargeByFlight.VALIDATE(ChargeByFlight."Destination Code", Flights."Destination Code");
                    ChargeByFlight."Destination Name" := Flights."Destination Code";
                    ChargeByFlight."Source Country" := Flights."Source Code";
                    ChargeByFlight."Destination Country" := Flights."Destination Code";
                    ChargeByFlight."Effective Start Date" := Rec."Effective Start Date";
                    ChargeByFlight."Effective End Date" := Rec."Effective End Date";
                    ChargeByFlight.INSERT;
                END;
            UNTIL Flights.NEXT = 0;
        END;



        WeightByDest.RESET;
        WeightByDest.SETRANGE(WeightByDest."Airline Code", AirlineCode);
        IF WeightByDest.FINDSET THEN BEGIN
            REPEAT
                ChargeByFlight.RESET;
                ChargeByFlight.SETRANGE(ChargeByFlight."Airline Code", WeightByDest."Airline Code");
                ChargeByFlight.SETRANGE(ChargeByFlight."Destination Airport", WeightByDest."Destination Airport");
                ChargeByFlight.SETRANGE(ChargeByFlight."Source Airport", WeightByDest."Source Airport");
                ChargeByFlight.SETFILTER(ChargeByFlight."Effective Start Date", '<=%1', Rec."Effective Start Date");
                ChargeByFlight.SETFILTER(ChargeByFlight."Effective End Date", '>=%1', Rec."Effective End Date");
                IF ChargeByFlight.FINDFIRST THEN BEGIN
                END ELSE BEGIN
                    MESSAGE('Charge by flight for %1 Not inserted', ChargeByFlight."Destination Name");
                END;
            UNTIL WeightByDest.NEXT = 0;
        END;
    end;

    local procedure GetCountry(AirportCode: Code[50]) Country: Text[50]
    var
        Airports: Record Airport;
    begin
        Airports.RESET;
        Airports.SETRANGE(Airports.Code, AirportCode);
        IF Airports.FINDFIRST THEN BEGIN
            Country := Airports."Country Code";

            EXIT(Country);
            MESSAGE(Country);
        END;
    end;
}

