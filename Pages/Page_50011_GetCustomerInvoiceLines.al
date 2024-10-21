page 50011 "Get Customer Invoice Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    ApplicationArea = All;
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    HideValue = "Customer No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Open; Rec.Open)
                {
                }
                field("User ID"; Rec."User ID")
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
        "Customer No.HideValue" := FALSE;
        CustomerNoOnFormat;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction IN [ACTION::OK, ACTION::LookupOK] THEN
            CreateLines;
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        TempCustLedgerEntry: Record "Cust. Ledger Entry" temporary;

        "Customer No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        TempCustLedgerEntry.RESET;
        TempCustLedgerEntry.COPYFILTERS(Rec);
        TempCustLedgerEntry.SETRANGE("Customer No.", Rec."Customer No.");
        IF NOT TempCustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.COPYFILTERS(Rec);
            CustLedgerEntry.SETRANGE("Customer No.", Rec."Customer No.");
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                TempCustLedgerEntry := CustLedgerEntry;
                TempCustLedgerEntry.INSERT;
            END;
        END;
        IF Rec."Document No." = TempCustLedgerEntry."Document No." THEN
            EXIT(TRUE);
    end;

    local procedure CustomerNoOnFormat()
    begin
        IF NOT IsFirstDocLine THEN
            "Customer No.HideValue" := TRUE;
    end;

    local procedure CreateLines()
    begin
        CurrPage.SETSELECTIONFILTER(Rec);
    end;
}

