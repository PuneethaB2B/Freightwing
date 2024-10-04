page 50102 "Posted Loading Sheets"
{
    CardPageID = "Posted Loading Sheet";
    Editable = false;
    PageType = List;
    SourceTable = "Loading Sheet Header";
    SourceTableView = WHERE(Shipped = FILTER(true));
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
                field("Loading Date"; Rec."Loading Date")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Prepared By"; Rec."Prepared By")
                {
                }
                field("Posted By"; Rec."Posted By")
                {
                }
                field("Posted Time"; Rec."Posted Time")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Run Batch")
            {
                AccessByPermission = TableData "Company Information" = I;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Validate Mawbs";
            }
        }
    }
}

