page 50111 "Offloaded Gate Pass"
{
    CardPageID = "Offloaded Gate Pass Form";
    Editable = false;
    PageType = List;
    SourceTable = Table50071;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                }
                field("Gate Pass No"; "Gate Pass No")
                {
                }
                field("Created By"; "Created By")
                {
                }
                field("Created On"; "Created On")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Process)
            {

                trigger OnAction()
                begin
                    Process;
                    MESSAGE('Processed');
                    CurrPage.CLOSE;
                end;
            }
        }
    }
}

