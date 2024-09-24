table 50020 "Mailing Configuration"
{

    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Consignee,Shipper;
        }
        field(2; "No."; Code[10])
        {
            TableRelation = IF (Type = CONST (Shipper)) Customer."No."
                            ELSE IF (Type=CONST(Consignee)) Consignee."No.";

            trigger OnValidate()
            begin
                IF Type = Type::Shipper THEN BEGIN
                    Cust.GET("No.");
                    Name := Cust.Name;
                    //MODIFY;
                END ELSE BEGIN
                    Consignee.GET("No.");
                    Name := Consignee.Name;
                    //MODIFY;
                END;
            end;
        }
        field(3; Name; Text[250])
        {
        }
        field(4; Email; Text[250])
        {
            ExtendedDatatype = EMail;
        }
        field(5; "Exclude From Invoice"; Boolean)
        {
        }
        field(6; "Exclude From Pre Alert"; Boolean)
        {
        }
        field(7; "Exclude From Post Alert"; Boolean)
        {
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
        key(Key1; Type, "No.", Email)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

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
    end;

    var
        Cust: Record 18;
        Consignee: Record 50015;
}

