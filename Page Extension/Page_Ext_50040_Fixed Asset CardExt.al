pageextension 50040 FixedAssetCardExt extends "Fixed Asset Card"
{
    actions
    {
        addfirst("Main Asset")
        {
            action("Fixed Asset Journal")
            {
                CaptionML = ENU = 'Fixed Asset Journal';
                RunObject = Page "Fixed Asset Journal";
                Promoted = true;
                PromotedIsBig = true;
                Image = Journal;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
            action("Fixed Asset G/L Journal")
            {
                CaptionML = ENU = 'Fixed Asset G/L Journal';
                RunObject = Page "Fixed Asset G/L Journal";
                Promoted = true;
                PromotedIsBig = true;
                Image = Journal;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
        }
    }
}