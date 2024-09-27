pageextension 50025 BankAccountCardExt extends "Bank Account Card"
{
    layout
    {
        addafter("Search Name")
        {
            field("Payment Limit"; Rec."Payment Limit")
            {
                ApplicationArea = all;
            }
        }
        addafter("Last Date Modified")
        {
            field("Customer Payments"; Rec."Customer Payments")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter("Online Map")
        {
            action("Add Beneficiary")
            {
                RunObject = Page 50141;
                RunPageLink = "Intermediary Bank" = FIELD("No.");
                Image = AddAction;
            }
        }
    }
}