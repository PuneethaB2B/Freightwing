page 50061 "Wk. Customer Wgt. Requirement"
{
    Caption = 'Weekly Customer Weight  Requirement';
    PageType = Card;
    SourceTable = 50047;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Destination Name"; Rec."Destination Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Start Day"; Rec."Start Day")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("End Day"; Rec."End Day")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Week No."; Rec."Week No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Year; Rec.Year)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Description; Rec.Description)
                {
                }
            }
            part(Page; 50062)
            {
                SubPageLink = "Weekly No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

