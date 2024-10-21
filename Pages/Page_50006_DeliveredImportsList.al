page 50006 "Delivered Imports List"
{
    CardPageID = "Delivered Imports Header";
    PageType = List;
    SourceTable = "Pre Alert Header";
    SourceTableView = WHERE(Status = CONST(Delivered));
    ApplicationArea = All;
    UsageCategory=Lists;

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
            }
        }
    }

    actions
    {
    }
}

