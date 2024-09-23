page 50038 "Freight Item Charge Matrix"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Matrix Daywise,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table50029;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Weight"; "From Weight")
                {
                }
                field("To Weight"; "To Weight")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Rate Amount"; "Rate Amount")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Calculation; Calculation)
                {
                }
                field(Difference; Difference)
                {
                    Caption = 'Difference';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Matrix Daywise")
            {
                Caption = 'Matrix Daywise';
                Image = Print;
            }
        }
    }
}

