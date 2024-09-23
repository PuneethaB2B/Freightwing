page 50046 "HAWB Receipts"
{
    Caption = 'HAWB Receipts';
    PageType = List;
    SourceTable = Table50037;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; "HAWB No.")
                {
                }
                field("Receipt Date"; "Receipt Date")
                {
                }
                field(Assigned; Assigned)
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
                    RunObject = Report 50000;

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
        gRecUserAccess: Record "50050";
}

