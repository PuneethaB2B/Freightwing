page 50082 "FWL Cargo Receipts"
{
    CardPageID = "FWL Goods Receipt Header";
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50030;
    SourceTableView = WHERE(Status = CONST(FWL Receipt));

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
                field("Item No."; "Item No.")
                {
                    Editable = true;
                }
                field(Weight; Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                }
                field(Quantity; Quantity)
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
                field("CIF Value"; "CIF Value")
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
}

