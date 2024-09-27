pageextension 50015 GLAccountCardExt extends "G/L Account Card"
{
    layout
    {
        addafter(Name)
        {
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = all;
            }
        }
    }
}