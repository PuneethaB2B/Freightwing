pageextension 50017 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(Name)
        {
            field("Customer Type"; Rec."Customer Type")
            {
                ApplicationArea = all;
            }
            field("Contact Person"; Rec."Contact Person")
            {
                ApplicationArea = all;
            }
        }
        addafter("E-Mail")
        {
            field("Email/CC"; Rec."Email/CC")
            {
                ApplicationArea = all;
            }
        }
        addafter("Block Payment Tolerance")
        {
            field("Margin %"; Rec."Margin %")
            {
                ApplicationArea = all;
            }
        }
        addafter("Base Calendar Code")
        {
            field("Weight Type"; Rec."Weight Type")
            {
                ApplicationArea = all;
            }
        }
    }
}