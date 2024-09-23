tableextension 70000021 tableextension70000021 extends "Purchase Header"
{
    fields
    {

        //Unsupported feature: Property Modification (Editable) on "Status(Field 120)".

        field(50000; "Purchase Requisition No."; Code[20])
        {
        }
        field(50001; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No." WHERE(Assigned = FILTER(Yes));
        }
        field(50002; "Request for Quotation No."; Code[20])
        {
            Editable = false;
        }
        field(50003; "Validity Date"; Date)
        {
        }
        field(50004; "Freight Handling Type"; Option)
        {
            OptionCaption = 'Custom bond fees, Handling charges Agent, Security Screening Charges, Export BUP charges, Other charges';
            OptionMembers = "Custom bond fees"," Handling charges Agent"," Security Screening Charges"," Export BUP charges"," Other charges";
        }
    }
}

