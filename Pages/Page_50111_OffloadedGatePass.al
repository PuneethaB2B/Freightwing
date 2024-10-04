page 50111 "Offloaded Gate Pass"
{
    CardPageID = "Offloaded Gate Pass Form";
    Editable = false;
    PageType = List;
    SourceTable = "Offloaded Gatepass Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field("Gate Pass No"; Rec."Gate Pass No")
                {
                }
                field("Created By"; Rec."Created By")
                {
                }
                field("Created On"; Rec."Created On")
                {
                }
                field(Status; Rec.Status)
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
                    Rec.Process;
                    MESSAGE('Processed');
                    CurrPage.CLOSE;
                end;
            }
        }
    }
}

