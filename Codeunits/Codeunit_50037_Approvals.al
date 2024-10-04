codeunit 50037 CustomCode
{
    trigger OnRun()
    begin

    end;

    procedure InsertCheck(var CheckLedgEntry: Record "Check Ledger Entry")
    var
        GenJnlLine2: Record "Gen. Journal Line";
        BankAcc: Record "Bank Account";
        BankAccLedgEntry2: Record "Bank Account Ledger Entry";
        CheckLedgEntry2: Record "Check Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
        VendorLedgEntry: Record "Vendor Ledger Entry";
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        FALedgEntry: Record "FA Ledger Entry";
        BankAccLedgEntry3: Record "Bank Account Ledger Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        NextCheckEntryNo: Integer;
        AppliesIDCounter: Integer;
        Text000: Label 'Check %1 already exists for this %2.';
    begin

        IF NextCheckEntryNo = 0 THEN BEGIN
            CheckLedgEntry2.LOCKTABLE;
            CheckLedgEntry2.RESET;
            IF CheckLedgEntry2.FINDLAST THEN
                NextCheckEntryNo := CheckLedgEntry2."Entry No." + 1
            ELSE
                NextCheckEntryNo := 1;
        END;

        CheckLedgEntry2.RESET;
        CheckLedgEntry2.SETCURRENTKEY("Bank Account No.", "Entry Status", "Check No.");
        CheckLedgEntry2.SETRANGE("Bank Account No.", CheckLedgEntry."Bank Account No.");
        CheckLedgEntry2.SETFILTER(
          "Entry Status", '%1|%2|%3',
          CheckLedgEntry2."Entry Status"::Printed,
          CheckLedgEntry2."Entry Status"::Posted,
          CheckLedgEntry2."Entry Status"::"Financially Voided");
        CheckLedgEntry2.SETRANGE("Check No.", CheckLedgEntry."Document No.");
        IF CheckLedgEntry2.FINDFIRST THEN
            ERROR(Text000, CheckLedgEntry."Document No.", BankAcc.TABLECAPTION);

        CheckLedgEntry.Open := CheckLedgEntry.Amount <> 0;
        CheckLedgEntry."User ID" := USERID;
        CheckLedgEntry."Entry No." := NextCheckEntryNo;
        CheckLedgEntry.INSERT;
        NextCheckEntryNo := NextCheckEntryNo + 1;
    end;

   



    var
        myInt: Integer;
}