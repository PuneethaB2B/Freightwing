page 50006 "Delivered Imports List"
{
    CardPageID = "Delivered Imports Header";
    PageType = List;
    SourceTable = 50030;
    SourceTableView = WHERE(Status = CONST(Delivered));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Manifest No"; Rec."Manifest No")
                {
                }
                field("MAWB No"; Rec."MAWB No")
                {
                }
                field("MAWB Date"; "MAWB Date")
                {
                }
                field("Delivery Agent"; Rec."Delivery Agent")
                {
                }
                field("Flight No"; Rec."Flight No")
                {
                }
                field("Port of Origin"; Rec."Port of Origin")
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

