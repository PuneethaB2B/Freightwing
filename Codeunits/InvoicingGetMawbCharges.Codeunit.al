codeunit 50029 "Invoicing Get Mawb Charges"
{

    trigger OnRun()
    begin
    end;


    procedure GetCalculatedCharges(SalesLine: Record 113; MawbNo: Code[50])
    var
        MawbInvoiceCharge: Record 50073;
    begin
        MawbInvoiceCharge.RESET;
        MawbInvoiceCharge.SETRANGE(MawbInvoiceCharge."MAWB No.", MawbNo);
        IF MawbInvoiceCharge.FINDSET THEN BEGIN
            REPEAT
                /* SalesLine."No.":=
                 SalesLine."Location Code":=
                 SalesLine."Posting Group":=
                 SalesLine.Description:=
                 SalesLine."Unit of Measure":=
                 SalesLine.Quantity:=
                 SalesLine."Unit Price":=
                 SalesLine."VAT %":=
                 SalesLine.Amount:=
                 SalesLine."Freight Charge Code":=
                 SalesLine."MAWB No.":=
                 SalesLine."HAWB No.":=
                 SalesLine."Division Code":=
                 SalesLine."Split Weight":=
                 SalesLine."Airline Code":=
                 SalesLine."Consignee Code":=
                 SalesLine."Flight Code":=
                 SalesLine."Destination Code":=
                 SalesLine."Flight Date":=  */
                SalesLine.MODIFY;
            UNTIL MawbInvoiceCharge.NEXT = 0;
        END;

    end;
}

