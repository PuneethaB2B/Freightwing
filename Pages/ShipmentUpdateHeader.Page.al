page 50032 "Shipment Update Header"
{
    SourceTable = 50030;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Pre-Alert  No.';
                }
                field("Pre-Alert Date"; Rec."Pre-Alert Date")
                {
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                }
                field("Actual Arrival Date"; Rec."Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                }
            }
            part(Page; 50024)
            {
                SubPageLink = "Pre Alert No" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Notifications)
            {
                Caption = 'Notifications';
                Image = Print;
                action("Email Recipients")
                {
                    Caption = 'Email Recipients';
                    Ellipsis = false;
                    Image = Email;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50026;
                    RunPageView = WHERE(Type = CONST(Management));
                    Visible = true;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

