page 50100 MAWBs
{
    Caption = 'Master Airway Bills';
    CardPageID = MAWB;
    PageType = List;
    SourceTable = Table50077;
    SourceTableView = WHERE(Status = FILTER(<> Archived));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                }
                field("Agent's IATA Code"; "Agent's IATA Code")
                {
                }
                field("Agent Code"; "Agent Code")
                {
                }
                field("Preparation Date"; "Preparation Date")
                {
                }
                field("Has Houses"; "Has Houses")
                {
                    Editable = false;
                }
                field(Status; Status)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field("Processed By"; "Processed By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

