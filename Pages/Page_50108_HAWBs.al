page 50108 HAWBs
{
    Caption = 'House Airway Bills';
    CardPageID = HAWB;
    PageType = List;
    SourceTable = "HAWB Header";
    SourceTableView = WHERE(Status = FILTER(<> Archived));
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
                field(Status; Rec.Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

