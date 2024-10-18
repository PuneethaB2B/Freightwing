pageextension 50029 VendorBankAccountCardExt extends "Vendor Bank Account Card"
{
    layout
    {
        addafter("Bank Branch No.")
        {
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = all;
            }
        }
    }
}