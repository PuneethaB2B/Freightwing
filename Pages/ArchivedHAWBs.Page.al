page 50103 "Archived HAWBs"
{
    Caption = 'House Airway Bills';
    CardPageID = "Archived HAWB";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = 50075;
    SourceTableView = WHERE(Status = FILTER(Archived));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("MAWB No."; "MAWB No.")
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
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("Agent's IATA Code"; "Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; "Carrier Agent Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
            }
        }
    }

    actions
    {
    }
}

