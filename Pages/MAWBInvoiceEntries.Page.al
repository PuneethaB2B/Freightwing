page 50155 "MAWB Invoice Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = Table17;
    SourceTableView = WHERE(Document Type=FILTER(Invoice),
                            System-Created Entry=FILTER(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No.";"Document No.")
                {
                }
                field("Document Date";"Document Date")
                {
                }
                field("External Document No.";"External Document No.")
                {
                }
                field(Description;Description)
                {
                }
                field(FormattedAmount;FormattedAmount)
                {
                    Caption = 'Amount';
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
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
        FormattedAmount:=ABS(Amount);
    end;

    var
        FormattedAmount: Decimal;
}

