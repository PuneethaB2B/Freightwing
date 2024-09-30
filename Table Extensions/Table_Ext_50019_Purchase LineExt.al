tableextension 50019 PurchaseLineExt extends "Purchase Line"
{
    fields
    {

        //Unsupported feature: Property Insertion (Editable) on ""Line Discount %"(Field 27)".


        //Unsupported feature: Property Insertion (Editable) on ""Line Discount Amount"(Field 28)".


        //Unsupported feature: Property Insertion (Editable) on ""Line Amount"(Field 103)".

        field(50000; "MAWB No."; Code[20])
        {
            TableRelation = "MAWB Receipt"."MAWB No.";
        }
        field(50001; "Freight Handling Type"; Option)
        {
            OptionCaption = 'Custom bond fees, Handling charges Agent, Security Screening Charges, Export BUP charges, Other charges';
            OptionMembers = "Custom bond fees"," Handling charges Agent"," Security Screening Charges"," Export BUP charges"," Other charges";
        }
        field(50002; "Charge Code"; Code[10])
        {
            TableRelation = "Freight Charge".Code;

            trigger OnValidate()
            begin
                Charges.GET("Charge Code");
                "No." := Charges."Purchase A/C Code";
                Description := Charges.Description;
            end;
        }
    }

    var
        PurchLine: Record 39;
        DimVal: Record 349;
        TempDimensionSetEntry: Record 480 temporary;
        Charges: Record 50018;
}

