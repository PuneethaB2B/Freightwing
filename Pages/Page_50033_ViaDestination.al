page 50033 "Via Destination"
{
    PageType = List;
    SourceTable = "Via Destination";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Via Destination Code"; Rec."Via Destination Code")
                {
                }
                field("Via Destination Airport"; Rec."Via Destination Airport")
                {
                }
                field("Arrival Time"; Rec."Arrival Time")
                {
                }
                field("Departure Time"; Rec."Departure Time")
                {
                }
                field("Connecting Airline"; Rec."Connecting Airline")
                {
                }
                field("Connecting Flight"; Rec."Connecting Flight")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

