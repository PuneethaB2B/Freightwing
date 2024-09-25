table 50011 "Shipper Agent"
{
    Caption = 'Shipping Agents';

    fields
    {
        field(1; "Shipper Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = Customer."No.";
        }
        field(2; "Agent Code"; Code[20])
        {
            Caption = 'Agent Code';
            TableRelation = "Shipping Agent".Code;

            trigger OnValidate()
            begin
                ShippingAgent.GET("Agent Code");
                "Agent Name" := ShippingAgent.Name;
            end;
        }
        field(3; "Agent Name"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Shipper Code", "Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record 225;
        ShippingAgent: Record 291;
}

