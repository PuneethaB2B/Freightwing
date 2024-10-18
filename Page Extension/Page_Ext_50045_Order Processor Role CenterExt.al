pageextension 50045 OrderProcessorRoleCenterExt extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Purchase Invoices")
        {
            action("Page Posted Purchase Credit Memo")
            {
                CaptionML = ENU = 'Page Posted Purchase Credit Memo';
                RunObject = Page "Posted Purchase Credit Memos";
                ApplicationArea = All;
            }
        }
        moveafter("Page Posted Purchase Credit Memo"; "Posted Sales Shipments")
        moveafter("Posted Sales Shipments"; "Posted Purchase Receipts")
        moveafter("Posted Purchase Receipts"; "Posted Return Receipts")
    }
}