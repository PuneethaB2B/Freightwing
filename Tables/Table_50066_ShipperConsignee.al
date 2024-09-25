table 50066 "Shipper Consignee"
{

    fields
    {
        field(1; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Consignee No."; Code[20])
        {
            TableRelation = Consignee;

            trigger OnValidate()
            begin
                Consignee.GET("Consignee No.");
                "Consignee Name" := Consignee.Name;
            end;
        }
        field(3; "Consignee Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Shipper Code", "Consignee No.", "Consignee Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Consignee: Record 50015;
}

