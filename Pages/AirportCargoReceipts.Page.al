page 50119 "Airport Cargo Receipts"
{
    CardPageID = "Airport Goods Receipt Header";
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50030;
    SourceTableView = WHERE(Status = CONST("Airport Receipt"));

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

