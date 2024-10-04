table 50028 "Freight Item Charge"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "Freight Charge By Item"."Airline Code";
        }
        field(2; "Flight Code"; Code[20])
        {
            TableRelation = "Freight Charge By Item"."Flight Code";
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = "Freight Charge By Item"."No.";
        }
        field(4; "Code"; Code[20])
        {
            TableRelation = "Freight Charge".Code;

            trigger OnValidate()
            begin
                FreightCharge.GET(Code);
                Description := FreightCharge.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(6; Calculation; Option)
        {
            OptionMembers = " ",Calculated,"Flat Rate";
        }
        field(7; Source; Option)
        {
            OptionMembers = System,Purchase;
        }
        field(8; "Source Airport"; Code[50])
        {
        }
        field(9; "Destination Airport"; Code[50])
        {
        }
        field(10; "Effective Start Date"; Date)
        {
        }
        field(11; "Effective End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Airline Code", "Flight Code", "Item No.", "Code", "Source Airport", "Destination Airport", "Effective Start Date", "Effective End Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ChargeMatrix.RESET;
        ChargeMatrix.SETRANGE(ChargeMatrix."Airline Code", "Airline Code");
        ChargeMatrix.SETRANGE(ChargeMatrix."Flight Code", "Flight Code");
        ChargeMatrix.SETRANGE(ChargeMatrix."Item No.", "Item No.");
        ChargeMatrix.SETRANGE(ChargeMatrix."Effective Start Date", "Effective Start Date");
        ChargeMatrix.SETRANGE(ChargeMatrix."Effective End Date", "Effective End Date");
        IF ChargeMatrix.FIND('-') THEN BEGIN
            ChargeMatrix.DELETEALL;
        END;
    end;

    var
        FreightCharge: Record "Freight Charge";
        ChargeMatrix: Record "Freight Item Charge Matrix";
}

