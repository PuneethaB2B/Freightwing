page 50151 "Handling Slab Matrix"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Matrix Daywise,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Handling Slab Matrix";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Weight"; Rec."From Weight")
                {
                    Caption = 'From';
                }
                field("To Weight"; Rec."To Weight")
                {
                    Caption = 'To';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Visible = false;
                }
                field("Rate Amount"; Rec."Rate Amount")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

