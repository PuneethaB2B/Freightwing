table 50021 Airline
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Shade; Text[50])
        {
        }
        field(4; "Prefix Code"; Code[10])
        {
        }
        field(5; "AWB Fee"; Decimal)
        {
        }
        field(6; "Default Vendor No"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                Ok := Vendor.GET("Default Vendor No");
                "Vendor Name" := Vendor.Name;
            end;
        }
        field(7; "Vendor Name"; Text[250])
        {
            Editable = false;
        }
        field(8; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(9; "Created On"; Date)
        {
            Editable = false;
        }
        field(10; "Last Updated By"; Code[50])
        {
            Editable = false;
        }
        field(11; "Last Updated On"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Flight.RESET;
        Flight.SETRANGE("Airline Code", Code);
        IF Flight.FINDFIRST THEN
            ERROR(Text001, Code, Flight.TABLENAME);
    end;

    trigger OnInsert()
    begin
        "Created By" := USERID;
        "Created On" := TODAY;
        "Last Updated By" := USERID;
        "Last Updated On" := TODAY;
    end;

    trigger OnModify()
    begin
        "Last Updated By" := USERID;
        "Last Updated On" := TODAY;
        MODIFY;
    end;

    var
        Flight: Record Flight;
        Text001: Label 'You cannot delete Airline %1 because there is at least one %2  associated with it.';
        Vendor: Record Vendor;
        Ok: Boolean;
}

