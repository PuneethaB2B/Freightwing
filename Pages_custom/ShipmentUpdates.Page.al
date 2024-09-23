page 50015 "Shipment Updates"
{
    CardPageID = "Shipment Update Header";
    PageType = List;
    SourceTable = Table50030;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Caption = 'Pre-Alert  No.';
                }
                field("Pre-Alert Date"; "Pre-Alert Date")
                {
                }
                field("MAWB No"; "MAWB No")
                {
                }
                field("Scheduled Date"; "Scheduled Date")
                {
                }
                field("Scheduled Time"; "Scheduled Time")
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
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

