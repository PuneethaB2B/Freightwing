page 50024 "Shipment Update Subform"
{
    PageType = List;
    SourceTable = "Shipment Update Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Activity Code"; Rec."Activity Code")
                {

                }
                field("Pre Alert No"; Rec."Pre Alert No")
                {
                    Visible = false;
                }
                field(Date; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                }
                field("Collected By"; Rec."Collected By")
                {
                }
                field("Send Notification"; Rec."Send Notification")
                {
                }
            }
        }
    }

    actions
    {
    }
}

