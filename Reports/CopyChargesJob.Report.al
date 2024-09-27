report 50104 "Copy Charges -Job"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1000000000; Table50025)
        {
            DataItemTableView = SORTING(Airline Code, Effective Start Date, Effective End Date)
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "Freight Charge By Airline"."Airline Name");
                FreightChargeByAirline.RESET;
                FreightChargeByAirline.INIT;
                FreightChargeByAirline."Airline Code" := "Freight Charge By Airline"."Airline Code";
                FreightChargeByAirline."Airline Name" := "Freight Charge By Airline"."Airline Name";
                FreightChargeByAirline."Effective Start Date" := StartDate;
                FreightChargeByAirline."Effective End Date" := EndDate;
                FreightChargeByAirline.INSERT;
                FreightChargeByFlight.RESET;
                FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Airline Code", FreightChargeByAirline."Airline Code");
                FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Effective Start Date", FreightChargeByAirline."Effective Start Date");
                FreightChargeByFlight.SETRANGE(FreightChargeByFlight."Effective End Date", FreightChargeByAirline."Effective End Date");
                IF FreightChargeByFlight.FINDSET THEN BEGIN
                    REPEAT
                        Window.UPDATE(2, FreightChargeByFlight."Destination Airport");
                        FreightChargeByFlight1.INIT;
                        FreightChargeByFlight1."Airline Code" := FreightChargeByFlight."Airline Code";
                        FreightChargeByFlight1."Flight Code" := FreightChargeByFlight."Flight Code";
                        FreightChargeByFlight1."Destination Airport" := FreightChargeByFlight."Destination Airport";
                        FreightChargeByFlight1."Source Airport" := FreightChargeByFlight."Source Airport";
                        FreightChargeByFlight1."Effective Start Date" := StartDate;
                        FreightChargeByFlight1."Effective End Date" := EndDate;
                        FreightChargeByFlight1.Transist := FreightChargeByFlight.Transist;
                        FreightChargeByFlight1."Destination Code" := FreightChargeByFlight."Destination Code";
                        FreightChargeByFlight1."Destination Name" := FreightChargeByFlight."Destination Name";
                        FreightChargeByFlight1."Source Country" := FreightChargeByFlight."Source Country";
                        FreightChargeByFlight1."Destination Country" := FreightChargeByFlight."Destination Country";
                        FreightChargeByFlight1.INSERT;
                        FreightChargeByItem.RESET;
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Airline Code", FreightChargeByFlight."Airline Code");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Flight Code", FreightChargeByFlight."Flight Code");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Effective Start Date", FreightChargeByFlight."Effective Start Date");
                        FreightChargeByItem.SETRANGE(FreightChargeByItem."Effective End Date", FreightChargeByFlight."Effective End Date");
                        IF FreightChargeByItem.FINDSET THEN BEGIN
                            REPEAT
                                Window.UPDATE(3, FreightChargeByItem.Description);
                                FreightChargeByItem1.INIT;
                                FreightChargeByItem1."Airline Code" := FreightChargeByItem."Airline Code";
                                FreightChargeByItem1."Flight Code" := FreightChargeByItem."Flight Code";
                                FreightChargeByItem1."No." := FreightChargeByItem."No.";
                                FreightChargeByItem1."Source Airport" := FreightChargeByItem."Source Airport";
                                FreightChargeByItem1."Destination Airport" := FreightChargeByItem."Destination Airport";
                                FreightChargeByItem1."Effective Start Date" := StartDate;
                                FreightChargeByItem1."Effective End Date" := EndDate;
                                FreightChargeByItem1.Description := FreightChargeByItem.Description;
                                FreightChargeByItem1.INSERT;
                                FreightItemCharge.RESET;
                                FreightItemCharge.SETRANGE(FreightItemCharge."Airline Code", FreightChargeByItem."Airline Code");
                                FreightItemCharge.SETRANGE(FreightItemCharge."Flight Code", FreightChargeByItem."Flight Code");
                                FreightItemCharge.SETRANGE(FreightItemCharge."Item No.", FreightChargeByItem."No.");
                                FreightItemCharge.SETRANGE(FreightItemCharge."Effective Start Date", FreightChargeByItem."Effective Start Date");
                                FreightItemCharge.SETRANGE(FreightItemCharge."Effective End Date", FreightChargeByItem."Effective End Date");
                                IF FreightItemCharge.FINDSET THEN BEGIN
                                    REPEAT
                                        FreightItemCharge1.INIT;
                                        FreightItemCharge1."Airline Code" := FreightItemCharge."Airline Code";
                                        FreightItemCharge1."Flight Code" := FreightItemCharge."Flight Code";
                                        FreightItemCharge1."Item No." := FreightItemCharge."Item No.";
                                        FreightItemCharge1.Code := FreightItemCharge.Code;
                                        FreightItemCharge1."Source Airport" := FreightItemCharge."Source Airport";
                                        FreightItemCharge1."Destination Airport" := FreightItemCharge."Destination Airport";
                                        FreightItemCharge1."Effective Start Date" := StartDate;
                                        FreightItemCharge1."Effective End Date" := EndDate;
                                        FreightItemCharge1.Description := FreightItemCharge.Description;
                                        FreightItemCharge1.Calculation := FreightItemCharge.Calculation;
                                        FreightItemCharge1.Source := FreightItemCharge.Source;
                                        FreightItemCharge1.INSERT;
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
                                                FreightItemChargeMatrix1.INIT;
                                                FreightItemChargeMatrix1."Airline Code" := FreightItemChargeMatrix."Airline Code";
                                                FreightItemChargeMatrix1."Flight Code" := FreightItemChargeMatrix."Flight Code";
                                                FreightItemChargeMatrix1."Item No." := FreightItemChargeMatrix."Item No.";
                                                FreightItemChargeMatrix1."Freight Charge Code" := FreightItemChargeMatrix."Freight Charge Code";
                                                FreightItemChargeMatrix1."From Weight" := FreightItemChargeMatrix."From Weight";
                                                FreightItemChargeMatrix1."To Weight" := FreightItemChargeMatrix."To Weight";
                                                FreightItemChargeMatrix1."Source airport" := FreightItemChargeMatrix."Source airport";
                                                FreightItemChargeMatrix1."Destination Airport" := FreightItemChargeMatrix."Destination Airport";
                                                FreightItemChargeMatrix1."Effective Start Date" := StartDate;
                                                FreightItemChargeMatrix1."Effective End Date" := EndDate;
                                                FreightItemChargeMatrix1."Unit of Measure Code" := FreightItemChargeMatrix."Unit of Measure Code";
                                                FreightItemChargeMatrix1."No. of Pallets" := FreightItemChargeMatrix."No. of Pallets";
                                                FreightItemChargeMatrix1."ULD Type" := FreightItemChargeMatrix."ULD Type";
                                                FreightItemChargeMatrix1."Rate Amount" := FreightItemChargeMatrix."Rate Amount";
                                                FreightItemChargeMatrix1."Currency Code" := FreightItemChargeMatrix."Currency Code";
                                                FreightItemChargeMatrix1.Calculation := FreightItemChargeMatrix.Calculation;
                                                FreightItemChargeMatrix1.Difference := FreightItemChargeMatrix.Difference;
                                                FreightItemChargeMatrix1.INSERT;
                                            UNTIL FreightItemChargeMatrix.NEXT = 0;
                                        END;//FreightItemChargeMatrix
                                    UNTIL FreightItemCharge.NEXT = 0;
                                END;//FreightItemCharge
                                SLEEP(100);
                            UNTIL FreightChargeByItem.NEXT = 0;
                        END;//FreightChargeByItem
                        SLEEP(100);
                    UNTIL FreightChargeByFlight.NEXT = 0;
                END;           //Freight Charge By Flight
                SLEEP(100);
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                MESSAGE('Copied Successfully');
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN('Copying Charges \Airline #1### \Destination #2## \Item #3###');
                IF ((StartDate = 0D) OR (EndDate = 0D)) THEN BEGIN
                    ERROR('Please Provide a Valid Date Range');
                END;
                //END
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date Range")
                {
                    field("Start Date"; StartDate)
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                    field("End Date"; EndDate)
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

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
}

