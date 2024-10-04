page 50100 MAWBs
{
    Caption = 'Master Airway Bills';
    CardPageID = MAWB;
    PageType = List;
    SourceTable = "MAWB Header 2";
    SourceTableView = WHERE(Status = FILTER(<> Archived));
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
                field("Agent Code"; Rec."Agent Code")
                {
                }
                field("Preparation Date"; Rec."Preparation Date")
                {
                }
                field("Has Houses"; Rec."Has Houses")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Processed By"; Rec."Processed By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

