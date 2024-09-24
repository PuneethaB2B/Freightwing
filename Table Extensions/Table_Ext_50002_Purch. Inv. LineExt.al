tableextension 50002 PurchInvoiceLineExt extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Payment Voucher No."; Code[20])
        {
        }
        field(50002; "Charge Code"; Code[10])
        {
            TableRelation = "Freight Charge".Code;
        }
    }

    local procedure "..FW..."()
    begin
    end;

    procedure GetPVLines(var TempPurchInvLine: Record 123 temporary)
    var
        PurchInvLine: Record 123;
        ItemLedgEntry: Record 32;
        ValueEntry: Record 5802;
    begin
        /*TempPurchInvLine.RESET;
        TempPurchInvLine.DELETEALL;
        
        IF Type <> Type::Item THEN
          EXIT;
        
        FilterPstdDocLnItemLedgEntries(ItemLedgEntry);
        ItemLedgEntry.SETFILTER("Invoiced Quantity",'<>0');
        IF ItemLedgEntry.FINDSET THEN BEGIN
          ValueEntry.SETCURRENTKEY("Item Ledger Entry No.","Entry Type");
          ValueEntry.SETRANGE("Entry Type",ValueEntry."Entry Type"::"Direct Cost");
          ValueEntry.SETFILTER("Invoiced Quantity",'<>0');
          REPEAT
            ValueEntry.SETRANGE("Item Ledger Entry No.",ItemLedgEntry."Entry No.");
            IF ValueEntry.FINDSET THEN
              REPEAT
                IF ValueEntry."Document Type" = ValueEntry."Document Type"::"Purchase Invoice" THEN
                  IF PurchInvLine.GET(ValueEntry."Document No.",ValueEntry."Document Line No.") THEN BEGIN
                    TempPurchInvLine.INIT;
                    TempPurchInvLine := PurchInvLine;
                    IF TempPurchInvLine.INSERT THEN;
                  END;
              UNTIL ValueEntry.NEXT = 0;
          UNTIL ItemLedgEntry.NEXT = 0;
        END;
         */

    end;

    var
        Text000: Label 'Invoice No. %1:';
        Text001: Label 'The program cannot find this purchase line.';
        Charges: Record 50018;
}

