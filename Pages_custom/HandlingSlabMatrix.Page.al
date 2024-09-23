page 50151 "Handling Slab Matrix"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Matrix Daywise,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table50045;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Weight"; "From Weight")
                {
                    Caption = 'From';
                }
                field("To Weight"; "To Weight")
                {
                    Caption = 'To';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                }
                field("Rate Amount"; "Rate Amount")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

