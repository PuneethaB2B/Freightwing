table 50003 "Beneficiary Details"
{

    fields
    {
        field(1; "Bank Code"; Code[50])
        {
            TableRelation = "Bank Account"."No." WHERE (Blocked=FILTER(false));

            trigger OnValidate()
            begin
                Banks.GET("Bank Code");
                "Bank Name" := Banks.Name;
                "Account Number" := Banks."Bank Account No.";
                Branch := Banks."Bank Branch No.";
            end;
        }
        field(2; "Bank Name"; Code[50])
        {
            Editable = false;
            NotBlank = true;
        }
        field(3; "Account Number"; Code[50])
        {
        }
        field(4; "Beneficiary Name"; Code[50])
        {
        }
        field(5; "Intermediary Bank"; Code[50])
        {
            TableRelation = "Bank Account"."No." WHERE (Blocked=FILTER(true));
        }
        field(6; Branch; Code[50])
        {
        }
        field(50000; "Currency Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Intermediary Bank", "Bank Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Banks: Record 270;
}

