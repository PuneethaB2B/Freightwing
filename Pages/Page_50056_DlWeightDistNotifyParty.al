page 50056 "Dl. Weight Dist. Notify Party"
{
    PageType = List;
    SourceTable = "Handling Slab Matrix";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Freight Charge Code"; Rec."Freight Charge Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("From Weight"; Rec."From Weight")
                {
                }
                field("To Weight"; Rec."To Weight")
                {
                }
            }
        }
    }

    actions
    {
    }
}

