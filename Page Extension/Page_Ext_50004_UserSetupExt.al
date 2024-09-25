pageextension 50004 UserSetupExt extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }
        }
    }
}