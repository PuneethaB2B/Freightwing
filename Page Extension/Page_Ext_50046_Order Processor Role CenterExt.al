pageextension 50046 OrderProcessorRoleCenterExt extends "Order Processor Role Center"
{
    actions
    {
        addafter("Posted Purchase Invoices")
        {
            action("Page Posted Purchase Credit Memo")
            {
                CaptionML = ENU = 'Page Posted Purchase Credit Memo';
                RunObject = Page 147;
                ApplicationArea = All;
            }
        }
        moveafter("Page Posted Purchase Credit Memo"; "Posted Sales Shipments")
        moveafter("Posted Sales Shipments"; "Posted Purchase Receipts")
        moveafter("Posted Purchase Receipts"; "Posted Return Receipts")
    }
}