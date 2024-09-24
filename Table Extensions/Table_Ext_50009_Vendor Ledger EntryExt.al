tableextension 50009 VendorLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "Payment Voucher No."; Code[20])
        {
        }
        field(50001; "MAWB No."; Code[20])
        {
        }
    }

    local procedure "..FWL..."()
    begin
    end;
}

