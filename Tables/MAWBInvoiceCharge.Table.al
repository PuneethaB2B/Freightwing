table 50073 "MAWB Invoice Charge"
{

    fields
    {
        field(1; "Invoice No."; Code[20])
        {
            TableRelation = "Sales Line"."Document No." WHERE (Document Type=FILTER(Invoice));
        }
        field(3;"Item No.";Code[20])
        {
            TableRelation = Item;
        }
        field(4;Description;Text[50])
        {
        }
        field(5;"Freight Charge Code";Code[20])
        {
            TableRelation = "Freight Charge".Code;
        }
        field(6;"Unit Of Measure";Code[20])
        {
            TableRelation = "Unit of Measure";
        }
        field(7;"Base Unit Price";Decimal)
        {

            trigger OnValidate()
            begin
                 Charges.GET("Freight Charge Code");
                 IF NOT Charges."Freight Cost" THEN
                 BEGIN ERROR('The Charge cannot be Modified'); END ELSE BEGIN
                 "Agreed Rate":="Base Unit Price"/"Chargeable Weight";
                END;
            end;
        }
        field(8;"Cost Amount";Decimal)
        {
        }
        field(9;"Sales Amount Ex. VAT";Decimal)
        {
        }
        field(10;"MAWB No.";Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No.";
        }
        field(11;"VAT Amount";Decimal)
        {
        }
        field(12;"Line No.";Integer)
        {
        }
        field(13;"Currency Code";Code[10])
        {
            TableRelation = Currency;
        }
        field(14;"Margin %";Decimal)
        {

            trigger OnValidate()
            begin
                IF "Margin %">0 THEN BEGIN
                 "Sales Amount Inc. Margin":=(("Margin %"/100)*"Invoice Unit Price")+"Invoice Unit Price";
                  "Sales Amount Ex. VAT":="Sales Amount Inc. Margin";
                END ELSE BEGIN
                  "Sales Amount Inc. Margin":="Invoice Unit Price";
                  "Sales Amount Ex. VAT":="Invoice Unit Price";

                END;
            end;
        }
        field(15;"Sales Amount Inc. VAT";Decimal)
        {
        }
        field(16;"VAT %";Decimal)
        {

            trigger OnValidate()
            begin
                "Sales Amount Inc. VAT":=(("VAT %"/100)*"Sales Amount Ex. VAT")+"Sales Amount Ex. VAT";
                 "VAT Amount":=("VAT %"/100)*"Sales Amount Ex. VAT";
            end;
        }
        field(17;"Transaction Date";Date)
        {
        }
        field(18;"Freight Cost";Boolean)
        {
            CalcFormula = Lookup("Freight Charge"."Freight Cost" WHERE (Code=FIELD("Freight Charge Code")));
            FieldClass = FlowField;
        }
        field(19;"Purchase A/C Code";Code[20])
        {
            CalcFormula = Lookup("Freight Charge"."Purchase A/C Code" WHERE (Code=FIELD("Freight Charge Code")));
            FieldClass = FlowField;
        }
        field(20;"Purchase Invoice No.";Code[20])
        {
        }
        field(21;"Sales Amount Inc. Margin";Decimal)
        {
        }
        field(22;"Invoice Unit Price";Decimal)
        {
        }
        field(23;"Prepared By";Code[50])
        {
        }
        field(24;"Prepared On";Date)
        {
        }
        field(25;"Contract Rate";Decimal)
        {
        }
        field(26;"Agreed Rate";Decimal)
        {

            trigger OnValidate()
            begin
                 Charges.GET("Freight Charge Code");
                 IF NOT Charges."Freight Cost" THEN
                 BEGIN ERROR('The Charge cannot be Modified'); END ELSE BEGIN

                 "Base Unit Price":="Agreed Rate"*"Chargeable Weight";
                END;
            end;
        }
        field(27;"Chargeable Weight";Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF "Chargeable Weight" <> 0 THEN
                "Base Unit Price":="Chargeable Weight"*"Agreed Rate";
            end;
        }
    }

    keys
    {
        key(Key1;"MAWB No.","Item No.","Freight Charge Code","Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Prepared By":=USERID;
        "Prepared On":=TODAY;
    end;

    var
        Charges: Record 50018;
}

