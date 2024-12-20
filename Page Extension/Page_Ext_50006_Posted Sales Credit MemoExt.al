pageextension 50006 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addbefore(Control1900383207)
        {
            part(CrQRCode; "Cr. QR Code.")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("Create Tims")
            {
                Caption = 'Create Tims';
                ApplicationArea = all;
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                 trigger OnAction()
                 var
                     TIMSManager: Codeunit "TIMS Manager.";
                 begin
                     TIMSManager.ProcessSalesDocument(Rec);
                 end; //B2BUPG Integration
            }
            action("Generate JSON")
            {
                Caption = 'Generate JSON';
                ApplicationArea = all;
                Image = GetActionMessages;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    TIMSManager: Codeunit "TIMS Manager.";
                begin
                    TIMSManager.GetJSONData(Rec);
                end; //B2BUPG Integration
            }
        }
    }
}