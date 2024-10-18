pageextension 50031 ShippingAgentsExt extends "Shipping Agents"
{
    layout
    {
        addafter(Name)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = all;
            }
        }
        modify("Internet Address")
        {
            ApplicationArea = all;
            Caption = 'Home Page';
        }
        addafter("Account No.")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = all;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = all;
            }
            field(City; Rec.City)
            {
                ApplicationArea = all;
            }
            field("Phone No."; Rec."Phone No.")
            {
                ApplicationArea = all;
            }
            field("Country/Region Code"; Rec."Country/Region Code")
            {
                ApplicationArea = all;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = all;
            }
            field("Post Code"; Rec."Post Code")
            {
                ApplicationArea = all;
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field(County; Rec.County)
            {
                ApplicationArea = all;
            }
        }
    }
}