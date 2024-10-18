pageextension 50021 VendorListExt extends "Vendor List"
{
    layout
    {
        addafter("Balance (LCY)")
        {

            field(Balance; Rec.Balance)
            {
                ApplicationArea = all;
            }
        }
        moveafter("Lead Time Calculation"; "Balance (LCY)")
    }
}