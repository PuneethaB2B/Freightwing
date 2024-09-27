pageextension 50040 FixedAssetCardExt extends "Fixed Asset Card"
{
    actions
    {
        addfirst("Main Asset")
        {
            action("Fixed Asset Journal")
            {
                CaptionML = ENU = 'Fixed Asset Journal';
                RunObject = Page 5629;
                Promoted = true;
                PromotedIsBig = true;
                Image = Journal;
                PromotedCategory = Process
            }
            action("Fixed Asset G/L Journal")
            {
                CaptionML = ENU = 'Fixed Asset G/L Journal';
                RunObject = Page 5628;
                Promoted = true;
                PromotedIsBig = true;
                Image = Journal;
                PromotedCategory = Process
            }
        }
    }
}