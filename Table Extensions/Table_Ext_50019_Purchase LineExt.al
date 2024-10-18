tableextension 50019 PurchaseLineExt extends "Purchase Line"
{
    fields
    {
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
        PurchLine: Record "Purchase Line";
        DimVal: Record "Dimension Value";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        Charges: Record "Freight Charge";
}

