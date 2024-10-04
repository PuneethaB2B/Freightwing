page 50038 "Freight Item Charge Matrix"
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Matrix Daywise,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Freight Item Charge Matrix";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("From Weight"; Rec."From Weight")
                {
                }
                field("To Weight"; Rec."To Weight")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Rate Amount"; Rec."Rate Amount")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Calculation; Rec.Calculation)
                {
                }
                field(Difference; Rec.Difference)
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

