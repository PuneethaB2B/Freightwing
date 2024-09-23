page 50079 "Weight Dist by airline"
{
    PageType = ListPart;
    SourceTable = Table50041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Daily No."; "Daily No.")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Airline Name"; "Airline Name")
                {
                }
                field("Total Capacity Planned"; "Total Capacity Planned")
                {
                }
                field("Actual Weight Booked"; "Actual Weight Booked")
                {
                }
                field("Cut-off Time"; "Cut-off Time")
                {
                }
                field("Capacity Available"; "Capacity Available")
                {
                }
                field(Difference; Difference)
                {
                }
                field("Total Weight Allocated"; "Total Weight Allocated")
                {
                }
                field("Day of Week"; "Day of Week")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Actual Departure Time"; "Actual Departure Time")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Distribution Date"; "Distribution Date")
                {
                }
                field("Scheduled Departure Time"; "Scheduled Departure Time")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("Shipment Delivery Time"; "Shipment Delivery Time")
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
                                  Destination Code=FIELD(Destination Code);

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
                                  Airline Code=FIELD(Airline Code);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalCapacityBalance;
    end;

    var
        [InDataSet]
        CapBal: Boolean;

    local procedure CalCapacityBalance()
    begin
        CALCFIELDS("Total Capacity Planned");
        CALCFIELDS("Total Weight Allocated");
        SETRANGE("Daily No.","Daily No.");
        SETRANGE("Airline Code","Airline Code");
        IF FINDFIRST THEN BEGIN
        "Capacity Available":="Total Capacity Planned"-("Total Weight Allocated");
        IF "Capacity Available"<0 THEN
          CapBal:=TRUE
        ELSE
          CapBal:=FALSE;
        END;
    end;
}

