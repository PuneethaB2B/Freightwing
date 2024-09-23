page 50032 "Shipment Update Header"
{
    SourceTable = Table50030;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Caption = 'Pre-Alert  No.';
                }
                field("Pre-Alert Date"; "Pre-Alert Date")
                {
                }
                field("Scheduled Date"; "Scheduled Date")
                {
                }
                field("Scheduled Time"; "Scheduled Time")
                {
                }
                field("Actual Arrival Date"; "Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; "Actual Arrival Time")
                {
                }
            }
            part(; 50024)
            {
                SubPageLink = Pre Alert No=FIELD(No.);
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
                    RunPageView = WHERE (Type = CONST (Management));
                    Visible = true;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

