page 50061 "Wk. Customer Wgt. Requirement"
{
    Caption = 'Weekly Customer Weight  Requirement';
    PageType = Card;
    SourceTable = Table50047;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Destination Name"; "Destination Name")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Start Day"; "Start Day")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("End Day"; "End Day")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Week No."; "Week No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Year; Year)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Description; Description)
                {
                }
            }
            part(; 50062)
            {
                SubPageLink = Weekly No.=FIELD(No.);
            }
        }
    }

    actions
    {
    }
}

