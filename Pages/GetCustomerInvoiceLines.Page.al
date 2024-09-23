page 50011 "Get Customer Invoice Lines"
{
    Editable = false;
    PageType = List;
    SourceTable = Table21;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer No."; "Customer No.")
                {
                    HideValue = "Customer No.HideValue";
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; "Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field(Open; Open)
                {
                }
                field("User ID"; "User ID")
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
        SalesInvHeader: Record "112";
        TempCustLedgerEntry: Record "21" temporary;
        [InDataSet]
        "Customer No.HideValue": Boolean;

    local procedure IsFirstDocLine(): Boolean
    var
        CustLedgerEntry: Record "21";
    begin
        TempCustLedgerEntry.RESET;
        TempCustLedgerEntry.COPYFILTERS(Rec);
        TempCustLedgerEntry.SETRANGE("Customer No.", "Customer No.");
        IF NOT TempCustLedgerEntry.FINDFIRST THEN BEGIN
            CustLedgerEntry.COPYFILTERS(Rec);
            CustLedgerEntry.SETRANGE("Customer No.", "Customer No.");
            IF CustLedgerEntry.FINDFIRST THEN BEGIN
                TempCustLedgerEntry := CustLedgerEntry;
                TempCustLedgerEntry.INSERT;
            END;
        END;
        IF "Document No." = TempCustLedgerEntry."Document No." THEN
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

