table 50039 "MAWB Receipt"
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = "MAWB By Airline"."Airline Code";
        }
        field(2; "MAWB No."; Code[20])
        {

            trigger OnValidate()
            begin
                MAWBByAirline.RESET;
                MAWBByAirline.SETRANGE(MAWBByAirline."Airline Code", "Airline Code");
                IF MAWBByAirline.FINDFIRST THEN BEGIN
                    "Receipt Date" := TODAY;
                    "MAWB Fees" := MAWBByAirline."MAWB Fees";
                    "Freight Charge Code" := MAWBByAirline."Freight Charge Code"
                END;
            end;
        }
        field(3; "Receipt Date"; Date)
        {
        }
        field(4; "MAWB Fees"; Decimal)
        {
            Editable = false;
        }
        field(5; Assigned; Boolean)
        {
            Editable = false;
        }
        field(6; "Freight Charge Code"; Code[20])
        {
            TableRelation = "Freight Charge";
        }
        field(7; Prepared; Boolean)
        {
            Editable = false;
        }
        field(8; "Prefix Code"; Code[10])
        {
        }
        field(9; "Bill No."; Code[10])
        {
        }
        field(10; "Start No."; Integer)
        {
        }
        field(11; "End No."; Integer)
        {
        }
        field(12; "KAA Fees"; Decimal)
        {
        }
        field(13; Invoiced; Boolean)
        {
            Editable = true;
        }
        field(14; "Assigned Date"; Date)
        {
        }
        field(15; "Invioced Date"; Date)
        {
        }
        field(16; "Prepared Date"; Date)
        {
        }
        field(17; "Created By"; Code[100])
        {
            Editable = false;
        }
        field(18; "Created On"; Date)
        {
            Editable = false;
        }
        field(19; "Lat Updated By"; Code[100])
        {
            Editable = false;
        }
        field(20; "Last Updated On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Airline Code", "MAWB No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Airline Code", "MAWB No.")
        {
        }
    }

    trigger OnDelete()
    begin
        TESTFIELD(Assigned, FALSE);
        TESTFIELD(Prepared, FALSE);
    end;

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created On" := TODAY;
        "Lat Updated By" := USERID;
        "Last Updated On" := TODAY;
        //MODIFY;
    end;

    trigger OnModify()
    begin
        "Lat Updated By" := USERID;
        "Last Updated On" := TODAY;
        //MODIFY;
    end;

    var
        MAWBByAirline: Record 50038;
}

