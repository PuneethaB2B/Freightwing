table 50050 "User Access to Cust Service"
{
    Caption = 'User Access to Customer Service';

    fields
    {
        field(1; "S.No"; Integer)
        {
        }
        field(2; UserID; Code[50])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                gRecUser.RESET;
                gRecUser.SETRANGE("User Name", UserID);
                IF gRecUser.FINDFIRST THEN
                    UserName := gRecUser."Full Name"
                ELSE
                    UserName := '';
            end;
        }
        field(3; UserName; Text[250])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "S.No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        gRecUser: Record 2000000120;
}

