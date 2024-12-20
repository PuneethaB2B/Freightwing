page 50053 "Dl. Weight Dist. By Item"
{
    Caption = 'Daily Weight Distribution By Item';
    PageType = List;
    SourceTable = "Dl. Weight Dist. By Item";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Shipped Weight"; Rec."Shipped Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

