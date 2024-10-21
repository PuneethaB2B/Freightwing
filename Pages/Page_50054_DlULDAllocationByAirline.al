page 50054 "Dl. ULD Allocation By Airline"
{
    Caption = 'Daily ULD Allocation By Airline';
    PageType = List;
    SourceTable = "Dl. ULD Allocation By Airline";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ULD Type"; Rec."ULD Type")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
            }
        }
    }

    actions
    {
    }
}

