pageextension 50024 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("HS Code"; Rec."HS Code")
            {
                ApplicationArea = all;
            }
        }
    }
}