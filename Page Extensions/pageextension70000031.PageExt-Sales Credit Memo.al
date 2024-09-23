pageextension 70000031 pageextension70000031 extends "Sales Credit Memo"
{
    actions
    {

        //Unsupported feature: Code Modification on "Post(Action 61).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        Post(CODEUNIT::"Sales-Post (Yes/No)");
        SalesInvoiceHeader.RESET;
        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.","Applies-to Doc. No.");
        IF SalesInvoiceHeader.FINDFIRST THEN BEGIN
          MAWBReceipt.RESET;
          MAWBReceipt.SETRANGE(MAWBReceipt."MAWB No.",SalesInvoiceHeader."External Document No.");
          IF MAWBReceipt.FINDFIRST THEN BEGIN
            MAWBReceipt.Invoiced:=FALSE;
            MAWBReceipt.MODIFY;
          END;
        END;
        */
        //end;
    }

    var
        MAWBReceipt: Record "50039";
        SalesInvoiceHeader: Record "112";
}

