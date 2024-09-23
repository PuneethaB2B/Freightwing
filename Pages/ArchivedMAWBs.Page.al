page 50077 "Archived MAWBs"
{
    Caption = 'Master Airway Bills';
    CardPageID = "Archived MAWB";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    ShowFilter = true;
    SourceTable = 50077;
    SourceTableView = WHERE(Status = FILTER(Archived));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                }
                field("Phyto Certificate"; "Phyto Certificate")
                {
                }
                field("Custom Entry No"; "Custom Entry No")
                {
                }
                field("Euro Form No"; "Euro Form No")
                {
                }
                field("Commercial Invoice No"; "Commercial Invoice No")
                {
                }
                field("Has Houses"; "Has Houses")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Processed By"; "Processed By")
                {
                }
                field("Total Weight"; "Total Weight")
                {
                }
                field("Total Quantity"; "Total Quantity")
                {
                }
                field("House Nos"; "House Nos")
                {
                }
                field(Status; Status)
                {
                }
                field("Gate Pass Prepared"; "Gate Pass Prepared")
                {
                }
                field("Preparation Date"; "Preparation Date")
                {
                }
                field("Processed At"; "Processed At")
                {
                }
                field("Item Description"; "Item Description")
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Gate Pass Done")
            {

                trigger OnAction()
                begin
                    "Gate Pass Prepared" := TRUE;
                    Rec.MODIFY;
                end;
            }
        }
    }
}

