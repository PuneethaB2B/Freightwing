page 50082 "FWL Cargo Receipts"
{
    CardPageID = "FWL Goods Receipt Header";
    InsertAllowed = false;
    PageType = List;
    SourceTable = 50030;
    SourceTableView = WHERE(Status = CONST("FWL Receipt"));
    ApplicationArea = All;

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
                field("MAWB Date"; Rec."MAWB Date")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = true;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                }
                field(Quantity; Rec.Quantity)
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
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                }
                field("Pre-Alert Date"; Rec."Pre-Alert Date")
                {
                }
                field("Menifest Date"; Rec."Menifest Date")
                {
                }
                field("CIF Value"; Rec."CIF Value")
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
}

