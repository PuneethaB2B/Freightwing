table 50027 "Freight Charge By Item"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "Freight Charge By Flight"."Airline Code";
        }
        field(2; "Flight Code"; Code[20])
        {
            TableRelation = "Freight Charge By Flight"."Flight Code";
        }
        field(3; "No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(4; Description; Text[50])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Source Airport"; Code[50])
        {
        }
        field(6; "Destination Airport"; Code[50])
        {
        }
        field(7; "Effective Start Date"; Date)
        {
        }
        field(8; "Effective End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Flight Code", "No.", "Source Airport", "Destination Airport", "Effective Start Date", "Effective End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ItemCharge.RESET;
        ItemCharge.SETRANGE(ItemCharge."Airline Code", "Airline Code");
        ItemCharge.SETRANGE(ItemCharge."Flight Code", "Flight Code");
        ItemCharge.SETRANGE(ItemCharge."Item No.", "No.");
        ItemCharge.SETRANGE(ItemCharge."Source Airport", "Source Airport");
        ItemCharge.SETRANGE(ItemCharge."Destination Airport", "Destination Airport");
        ItemCharge.SETRANGE(ItemCharge."Effective Start Date", "Effective Start Date");
        ItemCharge.SETRANGE(ItemCharge."Effective End Date", "Effective End Date");
        IF ItemCharge.FIND('-') THEN
            ItemCharge.DELETEALL;
    end;

    var
        ItemCharge: Record 50028;
}

