table 50067 "Shipper Notify Party"
{

    fields
    {
        field(1; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Notify-Party No."; Code[20])
        {
            TableRelation = "Notify Party";

            trigger OnValidate()
            begin
                NotifyParty.GET("Notify-Party No.");
                "Notify-Party Name" := NotifyParty.Name;
            end;
        }
        field(3; "Notify-Party Name"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Shipper Code", "Notify-Party No.", "Notify-Party Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        NotifyParty: Record 50017;
}

