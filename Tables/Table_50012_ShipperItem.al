table 50012 "Shipper Item"
{

    fields
    {
        field(1; "Shipper Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Item No."; Code[10])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                Description := Item.Description;
            end;
        }
        field(3; Description; Text[50])
        {
            Editable = false;
        }
        field(4; "Kilo Rate"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Shipper Code", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
}

