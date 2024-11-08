pageextension 50014 GLAccountCardExt extends "G/L Account Card"
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
        modify("Review Policy")
        {
            Visible = false;
        }
    }

}