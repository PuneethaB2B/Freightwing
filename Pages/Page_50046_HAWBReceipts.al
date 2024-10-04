page 50046 "HAWB Receipts"
{
    Caption = 'HAWB Receipts';
    PageType = List;
    SourceTable = "HAWB Receipt";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; Rec."HAWB No.")
                {
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                }
                field(Assigned; Rec.Assigned)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(HAWB)
            {
                Caption = 'HAWB';
                Image = Print;
                action("&Create HAWB")
                {
                    Caption = '&Create HAWB';
                    Image = CreateSerialNo;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Create HAWB";

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin

        gRecUserAccess.RESET;
        gRecUserAccess.SETRANGE(gRecUserAccess.UserID, USERID);
        IF NOT gRecUserAccess.FINDFIRST THEN
            ERROR('You do not have access');
    end;

    var
        gRecUserAccess: Record "User Access to Cust Service";
}

