page 50024 "Shipment Update Subform"
{
    PageType = List;
    SourceTable = Table50008;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activity Code"; "Activity Code")
                {
                }
                field("Pre Alert No"; "Pre Alert No")
                {
                    Visible = false;
                }
                field(Date; Date)
                {
                }
                field(Status; Status)
                {
                }
                field(Remarks; Remarks)
                {
                }
                field("Collected By"; "Collected By")
                {
                }
                field("Send Notification"; "Send Notification")
                {
                }
            }
        }
    }

    actions
    {
    }
}

