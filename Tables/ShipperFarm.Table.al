table 50014 "Shipper Farm"
{
    Caption = 'Shipping Agents';

    fields
    {
        field(1; "Shipper Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = Customer.No.;
        }
        field(2; "Farm Code"; Code[20])
        {
            Caption = 'Farm Code';
            TableRelation = Division/Farm.Code;

            trigger OnValidate()
            begin
                Farm.GET("Farm Code");
                Description:=Farm.Description;
            end;
        }
        field(3;Description;Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"Shipper Code","Farm Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Farm: Record "50013";
}

