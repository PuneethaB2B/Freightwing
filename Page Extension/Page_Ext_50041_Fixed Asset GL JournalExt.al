pageextension 50041 FixedAssetGLJournalExt extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter("FA Reclassification Entry")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
        }
    }

}