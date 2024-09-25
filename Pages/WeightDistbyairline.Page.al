page 50079 "Weight Dist by airline"
{
    PageType = ListPart;
    SourceTable = 50041;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Daily No."; Rec."Daily No.")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Airline Name"; Rec."Airline Name")
                {
                }
                field("Total Capacity Planned"; Rec."Total Capacity Planned")
                {
                }
                field("Actual Weight Booked"; Rec."Actual Weight Booked")
                {
                }
                field("Cut-off Time"; Rec."Cut-off Time")
                {
                }
                field("Capacity Available"; Rec."Capacity Available")
                {
                }
                field(Difference; Rec.Difference)
                {
                }
                field("Total Weight Allocated"; Rec."Total Weight Allocated")
                {
                }
                field("Day of Week"; Rec."Day of Week")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Actual Departure Time"; Rec."Actual Departure Time")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Distribution Date"; Rec."Distribution Date")
                {
                }
                field("Scheduled Departure Time"; Rec."Scheduled Departure Time")
                {
                }
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field("Shipment Delivery Time"; Rec."Shipment Delivery Time")
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
                                  "Destination Code" = FIELD("Destination Code");

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
                                  "Airline Code" = FIELD("Airline Code");

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

        CapBal: Boolean;

    local procedure CalCapacityBalance()
    begin
        Rec.CALCFIELDS("Total Capacity Planned");
        Rec.CALCFIELDS("Total Weight Allocated");
        Rec.SETRANGE("Daily No.", Rec."Daily No.");
        Rec.SETRANGE("Airline Code", Rec."Airline Code");
        IF Rec.FINDFIRST THEN BEGIN
            Rec."Capacity Available" := Rec."Total Capacity Planned" - (Rec."Total Weight Allocated");
            IF Rec."Capacity Available" < 0 THEN
                CapBal := TRUE
            ELSE
                CapBal := FALSE;
        END;
    end;
}

