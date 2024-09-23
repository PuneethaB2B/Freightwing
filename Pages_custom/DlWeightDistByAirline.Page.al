page 50051 "Dl. Weight Dist. By Airline"
{
    Caption = 'Daily Weight Distribution By Airline';
    PageType = ListPart;
    SourceTable = Table50041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Airline Code"; "Airline Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Airline Name"; "Airline Name")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Scheduled Departure Time"; "Scheduled Departure Time")
                {
                }
                field("Cut-off Time"; "Cut-off Time")
                {
                }
                field("Total Capacity Planned"; "Total Capacity Planned")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Total Weight Allocated"; "Total Weight Allocated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Dl. Weight Dist.Cust. Per Item";
                }
                field("Total Shipped Weight"; "Total Shipped Weight")
                {
                }
                field("Capacity Available"; "Capacity Available")
                {
                    Style = Unfavorable;
                    StyleExpr = CapBal;
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("Actual Departure Time"; "Actual Departure Time")
                {
                }
                field("Actual Departure Date"; "Actual Departure Date")
                {
                }
                field("Scheduled Arrival Date"; "Scheduled Arrival Date")
                {
                }
                field("Scheduled Arrival Time"; "Scheduled Arrival Time")
                {
                }
                field("Actual Arrival Date"; "Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; "Actual Arrival Time")
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
                    RunPageLink = Daily No.=FIELD(Daily No.),
                                  Airline Code=FIELD(Airline Code),
                                  Flight Code=FIELD(Flight Code),
                                  Destination Code=FIELD(Destination Code),
                                  Destination Airport=FIELD(Destination Airport);

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
                                    RunPageLink = Daily No.=FIELD(Daily No.),
                                  Airline Code=FIELD(Airline Code),
                                  Flight=FIELD(Flight Code),
                                  Destination Airport=FIELD(Destination Airport);

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
        [InDataSet]
        CapBal: Boolean;
        Flights: Record "50022";

    local procedure CalCapacityBalance(WeighDistByAirline: Record "50041")
    begin
        CALCFIELDS("Total Capacity Planned");
        CALCFIELDS("Total Weight Allocated");
        "Capacity Available":="Total Capacity Planned"-("Total Weight Allocated");
        IF "Capacity Available" >= 0 THEN
        BEGIN
          CapBal:=FALSE;
        END
        ELSE
        BEGIN
          CapBal:=TRUE;
        END;
        //MESSAGE(' %1 planned, %2 Allocated %3 Ava',"Total Capacity Planned","Total Weight Allocated", "Capacity Available");
    end;

    local procedure GetDest("Flight no": Code[10]) Dest: Text[50]
    begin
        Flights.RESET;
        Flights.SETRANGE(Flights."Flight No.","Flight no");
        IF Flights.FINDFIRST THEN
        BEGIN
        Dest:= Flights."Destination Airport";
        EXIT(Dest);
        END;
    end;
}

