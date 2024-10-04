page 50103 "Archived HAWBs"
{
    Caption = 'House Airway Bills';
    CardPageID = "Archived HAWB";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HAWB Header";
    SourceTableView = WHERE(Status = FILTER(Archived));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Address"; Rec."Shipper Address")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; Rec."Carrier Agent Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
            }
        }
    }

    actions
    {
    }
}

