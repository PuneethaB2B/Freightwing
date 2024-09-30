page 50155 "MAWB Invoice Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = 17;
    SourceTableView = WHERE("Document Type" = FILTER(Invoice),
                            "System-Created Entry" = FILTER(false));
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("External Document No."; Rec."External Document No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(FormattedAmount; FormattedAmount)
                {
                    Caption = 'Amount';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
        FormattedAmount := ABS(Rec.Amount);
    end;

    var
        FormattedAmount: Decimal;
}

