tableextension 50001 SaleCrMemoLineExt extends "Sales Cr.Memo Line"
{
    procedure GetHSCode(): Code[50]
    var
        HSCodes: Record 50082;
        GLAccount: Record 15;
        Item: Record 27;
    begin
        CASE Type OF
            Type::"G/L Account":
                BEGIN
                    IF NOT GLAccount.GET("No.") THEN
                        EXIT;

                    EXIT(GLAccount."HS Code");
                END;
            Type::Item:
                BEGIN
                    IF NOT Item.GET("No.") THEN
                        EXIT;

                    EXIT(Item."HS Code");
                END;

        END;
    end;
}

