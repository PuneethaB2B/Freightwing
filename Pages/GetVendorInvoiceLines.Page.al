page 50004 "Get Vendor Invoice Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = 25;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                }
                field(Open; Rec.Open)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        "Document No.HideValue" := FALSE;
        DocumentNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        PurchInvHeader: Record 122;
        TempVendorLedgerEntry: Record 25 temporary;

        "Document No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        VendorLedgerEntry: Record 25;
    begin
        TempVendorLedgerEntry.RESET;
        TempVendorLedgerEntry.COPYFILTERS(Rec);
        TempVendorLedgerEntry.SETRANGE("Document No.", Rec."Document No.");
        IF NOT TempVendorLedgerEntry.FINDFIRST THEN BEGIN
            VendorLedgerEntry.COPYFILTERS(Rec);
            VendorLedgerEntry.SETRANGE("Document No.", Rec."Document No.");
            VendorLedgerEntry.SETFILTER("Remaining Amount", '<>0');
            // VendorLedgerEntry.SETFILTER("Qty. Rcd. Not Invoiced",'<>0');
            IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                TempVendorLedgerEntry := VendorLedgerEntry;
                TempVendorLedgerEntry.INSERT;
            END;
        END;
        IF Rec."Entry No." = TempVendorLedgerEntry."Entry No." THEN
            EXIT(TRUE);
    end;

    local procedure DocumentNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Document No.HideValue" := TRUE;
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
    end;
}

