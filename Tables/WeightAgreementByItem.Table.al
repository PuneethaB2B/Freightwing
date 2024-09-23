table 50036 "Weight Agreement By Item"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "Weight Agreement By Day"."Airline Code";
        }
        field(2; "Source Code"; Code[20])
        {
            TableRelation = "Weight Agreement By Day"."Source Code";
        }
        field(3; "Destination Code"; Code[20])
        {
            TableRelation = "Weight Agreement By Day"."Destination Code";
        }
        field(4; "Day of Week"; Option)
        {
            OptionCaption = 'Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday';
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
            TableRelation = "Weight Agreement By Day"."Day of Week";
        }
        field(5; "Item No."; Code[20])
        {
            TableRelation = Item.No.;

            trigger OnValidate()
            begin
                Item.GET("Item No.");
                "Unit of Measure" := Item."Base Unit of Measure";
            end;
        }
        field(6;Description;Text[50])
        {
            CalcFormula = Lookup(Item.Description WHERE (No.=FIELD(Item No.)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7;"Unit of Measure";Code[20])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(8;"Min. Chargeable Weight";Decimal)
        {
        }
        field(9;"Rate Amount";Decimal)
        {
        }
        field(10;"Currency Code";Code[20])
        {
            TableRelation = Currency;
        }
        field(11;"Destination Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));
        }
        field(12;"Source Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Source Code));
        }
    }

    keys
    {
        key(Key1;"Airline Code","Source Code","Destination Code","Day of Week","Item No.","Destination Airport","Source Airport")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record "27";
}

