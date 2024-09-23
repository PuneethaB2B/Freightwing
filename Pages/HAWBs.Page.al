page 50108 HAWBs
{
    Caption = 'House Airway Bills';
    CardPageID = HAWB;
    PageType = List;
    SourceTable = Table50075;
    SourceTableView = WHERE(Status = FILTER(<> Archived));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Address"; "Shipper Address")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field("Consignee Code"; "Consignee Code")
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
                field(Status; Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

