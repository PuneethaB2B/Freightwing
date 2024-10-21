page 50124 "Shipper Notify Parties"
{
    PageType = List;
    SourceTable = "Shipper Notify Party";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Notify-Party No."; Rec."Notify-Party No.")
                {
                }
                field("Notify-Party Name"; Rec."Notify-Party Name")
                {
                }
            }
        }
    }

    actions
    {
    }
}

