page 50051 "Dl. Weight Dist. By Airline"
{
    Caption = 'Daily Weight Distribution By Airline';
    PageType = ListPart;
    SourceTable = 50041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Scheduled Departure Time"; Rec."Scheduled Departure Time")
                {
                }
                field("Cut-off Time"; Rec."Cut-off Time")
                {
                }
                field("Total Capacity Planned"; Rec."Total Capacity Planned")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Total Weight Allocated"; Rec."Total Weight Allocated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Dl. Weight Dist.Cust. Per Item";
                }
                field("Total Shipped Weight"; Rec."Total Shipped Weight")
                {
                }
                field("Capacity Available"; Rec."Capacity Available")
                {
                    Style = Unfavorable;
                    StyleExpr = CapBal;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field("Actual Departure Time"; Rec."Actual Departure Time")
                {
                }
                field("Actual Departure Date"; Rec."Actual Departure Date")
                {
                }
                field("Scheduled Arrival Date"; Rec."Scheduled Arrival Date")
                {
                }
                field("Scheduled Arrival Time"; Rec."Scheduled Arrival Time")
                {
                }
                field("Actual Arrival Date"; Rec."Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("& Weight By Customer")
                {
                    Caption = '& Weight By Customer';
                    Image = EntriesList;
                    RunObject = Page 50052;
                    RunPageLink = "Daily No." = FIELD("Daily No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Destination Code" = FIELD("Destination Code"),
                                  "Destination Airport" = FIELD("Destination Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("& ULD Allocation")
                {
                    Caption = '& ULD Allocation';
                    Image = EntriesList;
                    RunObject = Page 50054;
                    RunPageLink = "Daily No." = FIELD("Daily No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  Flight = FIELD("Flight Code"),
                                  "Destination Airport" = FIELD("Destination Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Get Dest")
                {

                    trigger OnAction()
                    begin
                        //Message(GetDest("Flight Code"));
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalCapacityBalance(Rec);
    end;

    var

        CapBal: Boolean;
        Flights: Record 50022;

    local procedure CalCapacityBalance(WeighDistByAirline: Record 50041)
    begin
        Rec.CALCFIELDS("Total Capacity Planned");
        Rec.CALCFIELDS("Total Weight Allocated");
        Rec."Capacity Available" := Rec."Total Capacity Planned" - (Rec."Total Weight Allocated");
        IF Rec."Capacity Available" >= 0 THEN BEGIN
            CapBal := FALSE;
        END
        ELSE BEGIN
            CapBal := TRUE;
        END;
        //MESSAGE(' %1 planned, %2 Allocated %3 Ava',"Total Capacity Planned","Total Weight Allocated", "Capacity Available");
    end;

    local procedure GetDest("Flight no": Code[10]) Dest: Text[50]
    begin
        Flights.RESET;
        Flights.SETRANGE(Flights."Flight No.", "Flight no");
        IF Flights.FINDFIRST THEN BEGIN
            Dest := Flights."Destination Airport";
            EXIT(Dest);
        END;
    end;
}

