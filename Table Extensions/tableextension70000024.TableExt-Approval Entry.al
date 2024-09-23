tableextension 70000024 tableextension70000024 extends "Approval Entry"
{
    fields
    {
        modify("Document Type")
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Payment Voucher,Receipt Voucher,Purchase Requisition,Petty Cash Voucher,Request for Quotation';

            //Unsupported feature: Property Modification (OptionString) on ""Document Type"(Field 2)".

        }
    }
}

