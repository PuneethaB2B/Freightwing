page 50006 "Delivered Imports List"
{
    CardPageID = "Delivered Imports Header";
    PageType = List;
    SourceTable = Table50030;
    SourceTableView = WHERE (Status = CONST (Delivered));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Manifest No"; "Manifest No")
                {
                }
                field("MAWB No"; "MAWB No")
                {
                }
                field("MAWB Date"; "MAWB Date")
                {
                }
                field("Delivery Agent"; "Delivery Agent")
                {
                }
                field("Flight No"; "Flight No")
                {
                }
                field("Port of Origin"; "Port of Origin")
                {
                }
                field("Port of Discharge"; "Port of Discharge")
                {
                }
                field("Pre-Alert Date"; "Pre-Alert Date")
                {
                }
                field("Menifest Date"; "Menifest Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

