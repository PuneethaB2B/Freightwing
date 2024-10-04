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
    SourceTable = "MAWB Header 2";
    SourceTableView = WHERE(Status = FILTER(Archived));
    ApplicationArea = All;

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
                field("Phyto Certificate"; Rec."Phyto Certificate")
                {
                }
                field("Custom Entry No"; Rec."Custom Entry No")
                {
                }
                field("Euro Form No"; Rec."Euro Form No")
                {
                }
                field("Commercial Invoice No"; Rec."Commercial Invoice No")
                {
                }
                field("Has Houses"; Rec."Has Houses")
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Processed By"; Rec."Processed By")
                {
                }
                field("Total Weight"; Rec."Total Weight")
                {
                }
                field("Total Quantity"; Rec."Total Quantity")
                {
                }
                field("House Nos"; Rec."House Nos")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Gate Pass Prepared"; Rec."Gate Pass Prepared")
                {
                }
                field("Preparation Date"; Rec."Preparation Date")
                {
                }
                field("Processed At"; Rec."Processed At")
                {
                }
                field("Item Description"; Rec."Item Description")
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
                    Rec."Gate Pass Prepared" := TRUE;
                    Rec.MODIFY;
                end;
            }
        }
    }
}

