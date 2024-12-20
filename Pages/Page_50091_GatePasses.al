page 50091 "Gate Passes"
{
    CardPageID = "Gate Pass";
    PageType = List;
    SourceTable = "Gate Pass Header";
    SourceTableView = WHERE(Status = FILTER(<> Released));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Gate-Pass Date"; Rec."Gate-Pass Date")
                {
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                }
                field("Driver Name"; Rec."Driver Name")
                {
                }
                field("Escort Vehicle No."; Rec."Escort Vehicle No.")
                {
                }
                field("Supervisor Name"; Rec."Supervisor Name")
                {
                }
                field("Prepared By"; Rec."Prepared By")
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

