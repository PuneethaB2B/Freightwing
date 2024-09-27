page 50015 "Shipment Updates"
{
    CardPageID = "Shipment Update Header";
    PageType = List;
    SourceTable = 50030;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Pre-Alert  No.';
                }
                field("Pre-Alert Date"; Rec."Pre-Alert Date")
                {
                }
                field("MAWB No"; Rec."MAWB No")
                {
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                }
                field("Scheduled Time"; Rec."Scheduled Time")
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
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

