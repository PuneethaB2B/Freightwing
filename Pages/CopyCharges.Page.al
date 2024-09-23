page 50002 "Copy Charges"
{
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field("Airline Code"; Airline)
            {
                Editable = false;
            }
            field("Original Start Date"; Start)
            {
                Editable = false;
            }
            field("Original End Date"; Endd)
            {
                Editable = false;
            }
            field("New Start Date"; StartDate)
            {
            }
            field("New End Date"; EndDate)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF ((StartDate = 0D) OR (EndDate = 0D)) THEN BEGIN END;
        FreightChargeByAirline.RESET;
        FreightChargeByAirline.SETRANGE(FreightChargeByAirline."Airline Code", Airline);
        FreightChargeByAirline.SETRANGE(FreightChargeByAirline."Effective Start Date", Start);
        FreightChargeByAirline.SETRANGE(FreightChargeByAirline."Effective End Date", Endd);
        IF FreightChargeByAirline.FINDFIRST THEN BEGIN
            Window.OPEN('Copying Charges \Airline #1### \Destination #2## \Item #3### \Charge #4###');
            CopyFreightChargeByAirline(FreightChargeByAirline, FreightChargeByAirline1, StartDate, EndDate);
            FreightChargeByFlight.RESET;
            FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Airline Code", FreightChargeByAirline."Airline Code");
            FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Effective Start Date", FreightChargeByAirline."Effective Start Date");
            FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Effective End Date", FreightChargeByAirline."Effective End Date");
            IF FreightChargeByFlight.FINDSET THEN BEGIN
                REPEAT
                    CopyFreightChargeByFlight(FreightChargeByFlight, FreightChargeByFlight1, StartDate, EndDate);
                    Window.UPDATE(2, FreightChargeByFlight."Flight Code" + '.-.' + FreightChargeByFlight."Destination Airport");
                    SLEEP(100);
                    FreightChargeByItem.RESET;
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Airline Code", FreightChargeByFlight."Airline Code");
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Flight Code", FreightChargeByFlight."Flight Code");
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Effective Start Date", FreightChargeByFlight."Effective Start Date");
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Effective End Date", FreightChargeByFlight."Effective End Date");
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Source Airport", FreightChargeByFlight."Source Airport");
                    FreightChargeByItem.SETRANGE(FreightChargeByItem."Destination Airport", FreightChargeByFlight."Destination Airport");
                    IF FreightChargeByItem.FINDSET THEN BEGIN
                        REPEAT
                            CopyFreightChargeByItem(FreightChargeByItem, FreightChargeByItem1, StartDate, EndDate);
                            Window.UPDATE(3, FreightChargeByItem.Description);
                            SLEEP(100);
                            FreightItemCharge.RESET;
                            FreightItemCharge.SETRANGE(FreightItemCharge."Airline Code", FreightChargeByItem."Airline Code");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Flight Code", FreightChargeByItem."Flight Code");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Item No.", FreightChargeByItem."No.");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Effective Start Date", FreightChargeByItem."Effective Start Date");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Effective End Date", FreightChargeByItem."Effective End Date");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Source Airport", FreightChargeByItem."Source Airport");
                            FreightItemCharge.SETRANGE(FreightItemCharge."Destination Airport", FreightChargeByItem."Destination Airport");
                            IF FreightItemCharge.FINDSET THEN BEGIN
                                REPEAT
                                    CopyFreightItemCharge(FreightItemCharge, FreightItemCharge1, StartDate, EndDate);
                                    FreightItemChargeMatrix.RESET;
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Airline Code", FreightItemCharge."Airline Code");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Flight Code", FreightItemCharge."Flight Code");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Item No.", FreightItemCharge."Item No.");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Freight Charge Code", FreightItemCharge.Code);
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Effective Start Date", FreightItemCharge."Effective Start Date");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Effective End Date", FreightItemCharge."Effective End Date");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Source airport", FreightItemCharge."Source Airport");
                                    FreightItemChargeMatrix.SETRANGE(FreightItemChargeMatrix."Destination Airport", FreightItemCharge."Destination Airport");
                                    IF FreightItemChargeMatrix.FINDSET THEN BEGIN
                                        REPEAT
                                            CopyFreightItemChargeMatrix(FreightItemChargeMatrix, FreightItemChargeMatrix1, StartDate, EndDate);
                                            Window.UPDATE(4, FreightItemCharge.Description);
                                            SLEEP(100);

                                        UNTIL FreightItemChargeMatrix.NEXT = 0;
                                    END;//FreightItemChargeMatrix
                                UNTIL FreightItemCharge.NEXT = 0;
                            END;//FreightItemCharge
                            SLEEP(100);
                        UNTIL FreightChargeByItem.NEXT = 0;
                    END;//FreightChargeByItem

                UNTIL FreightChargeByFlight.NEXT = 0;
            END ELSE BEGIN
                MESSAGE('No Flights');
            END;           //Freight Charge By Flight

        END;
    end;

    var
        FreightChargeByAirline: Record "50025";
        FreightChargeByFlight: Record "50026";
        FreightChargeByItem: Record "50027";
        FreightItemCharge: Record "50028";
        FreightItemChargeMatrix: Record "50029";
        StartDate: Date;
        EndDate: Date;
        Window: Dialog;
        FreightChargeByAirline1: Record "50025";
        FreightChargeByFlight1: Record "50026";
        FreightChargeByItem1: Record "50027";
        FreightItemCharge1: Record "50028";
        FreightItemChargeMatrix1: Record "50029";
        j: Integer;
        CopyFromDate: Date;
        CopyToDate: Date;
        ByAirline: Record "50025";
        Airline: Code[10];
        Start: Date;
        Endd: Date;

    local procedure CopyFreightChargeByAirline(From: Record "50025"; CopyTo: Record "50025"; Strt: Date; Edd: Date)
    begin
        CopyTo.INIT;
        CopyTo."Airline Code" := From."Airline Code";
        CopyTo."Airline Name" := From."Airline Name";
        CopyTo."Effective Start Date" := Strt;
        CopyTo."Effective End Date" := Edd;
        CopyTo.INSERT;
        //MESSAGE('Inserted');
    end;

    local procedure CopyFreightChargeByFlight(From: Record "50026"; CopyTo: Record "50026"; Str: Date; Edd: Date)
    var
        i: Integer;
    begin
        CopyTo.INIT;
        CopyTo."Airline Code" := From."Airline Code";
        CopyTo."Flight Code" := From."Flight Code";
        CopyTo."Destination Airport" := From."Destination Airport";
        CopyTo."Source Airport" := From."Source Airport";
        CopyTo."Effective Start Date" := Str;
        CopyTo."Effective End Date" := Edd;
        CopyTo.Transist := From.Transist;
        CopyTo."Destination Code" := From."Destination Code";
        CopyTo."Destination Name" := From."Destination Name";
        CopyTo."Source Country" := From."Source Country";
        CopyTo."Destination Country" := From."Destination Country";
        CopyTo.INSERT;
    end;

    local procedure CopyFreightChargeByItem(From: Record "50027"; CopyTo: Record "50027"; str: Date; edd: Date)
    begin
        CopyTo.INIT;
        CopyTo."Airline Code" := From."Airline Code";
        CopyTo."Flight Code" := From."Flight Code";
        CopyTo."No." := From."No.";
        CopyTo."Source Airport" := From."Source Airport";
        CopyTo."Destination Airport" := From."Destination Airport";
        CopyTo."Effective Start Date" := StartDate;
        CopyTo."Effective End Date" := EndDate;
        CopyTo.Description := From.Description;
        CopyTo.INSERT;
    end;

    local procedure CopyFreightItemCharge(From: Record "50028"; CopyTo: Record "50028"; Strt: Date; Edd: Date)
    begin
        CopyTo.INIT;
        CopyTo."Airline Code" := From."Airline Code";
        CopyTo."Flight Code" := From."Flight Code";
        CopyTo."Item No." := From."Item No.";
        CopyTo.Code := From.Code;
        CopyTo."Source Airport" := From."Source Airport";
        CopyTo."Destination Airport" := From."Destination Airport";
        CopyTo."Effective Start Date" := Strt;
        CopyTo."Effective End Date" := Edd;
        CopyTo.Description := From.Description;
        CopyTo.Calculation := From.Calculation;
        CopyTo.Source := From.Source;
        CopyTo.INSERT;
    end;

    local procedure CopyFreightItemChargeMatrix(From: Record "50029"; CopyTo: Record "50029"; Strt: Date; Edd: Date)
    begin
        CopyTo.INIT;
        CopyTo."Airline Code" := From."Airline Code";
        CopyTo."Flight Code" := From."Flight Code";
        CopyTo."Item No." := From."Item No.";
        CopyTo."Freight Charge Code" := From."Freight Charge Code";
        CopyTo."From Weight" := From."From Weight";
        CopyTo."To Weight" := From."To Weight";
        CopyTo."Source airport" := From."Source airport";
        CopyTo."Destination Airport" := From."Destination Airport";
        CopyTo."Effective Start Date" := Strt;
        CopyTo."Effective End Date" := Edd;
        CopyTo."Unit of Measure Code" := From."Unit of Measure Code";
        CopyTo."No. of Pallets" := From."No. of Pallets";
        CopyTo."ULD Type" := From."ULD Type";
        CopyTo."Rate Amount" := From."Rate Amount";
        CopyTo."Currency Code" := From."Currency Code";
        CopyTo.Calculation := From.Calculation;
        CopyTo.Difference := From.Difference;
        CopyTo.INSERT;
    end;

    [Scope('Internal')]
    procedure initParam(pCharg: Record "50025")
    begin
        Start := pCharg."Effective Start Date";
        Endd := pCharg."Effective End Date";
        Airline := pCharg."Airline Code";
    end;
}

