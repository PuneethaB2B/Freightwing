tableextension 70000002 tableextension70000002 extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "MAWB No."; Code[20])
        {
            Editable = false;
            TableRelation = "HAWB Header".No.;
        }
        field(50001; "HAWB No."; Code[20])
        {
            Editable = false;
            TableRelation = "HS Codes".Code;
        }
        field(50002; "Division Code"; Code[20])
        {
            TableRelation = Division/Farm.Code;

            trigger OnValidate()
            begin
                MAWBLine.RESET;
                MAWBLine.SETRANGE(MAWBLine."MAWB No.","MAWB No.");
                MAWBLine.SETRANGE(MAWBLine."HAWB No.","HAWB No.");
                IF MAWBLine.FINDFIRST THEN BEGIN
                  "Division Code":=MAWBLine."Division/Farm Code";
                  //MESSAGE(FORMAT(MAWBLine."Division Code"));
                  MODIFY;
                END ELSE BEGIN END;
            end;
        }
        field(50003;"Split Weight";Decimal)
        {
            DecimalPlaces = 0:5;
        }
        field(50004;"Airline Code";Code[20])
        {
            TableRelation = Airline;
        }
        field(50005;"Consignee Code";Code[20])
        {
            TableRelation = Consignee;
        }
        field(50006;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight Code" WHERE (Airline Code=FIELD(Airline Code));
        }
        field(50007;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(50008;"Flight Date";Date)
        {
        }
        field(50009;"VAT Amount";Decimal)
        {
            Editable = false;
        }
        field(50010;"Cost Amount";Decimal)
        {
        }
        field(50011;"Freight Charge Code";Code[20])
        {
            TableRelation = "Freight Charge";
        }
        field(50012;"Split Factor";Decimal)
        {
        }
        field(50013;"Freight Cost";Boolean)
        {
            CalcFormula = Lookup("Freight Charge"."Freight Cost" WHERE (Code=FIELD(Freight Charge Code)));
            FieldClass = FlowField;
        }
        field(50014;"Margin %";Decimal)
        {
        }
        field(50015;"Margin Amount";Decimal)
        {
        }
    }

    procedure GetHSCode(): Code[50]
    var
        HSCodes: Record "50082";
        GLAccount: Record "15";
        Item: Record "27";
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

    var
        Text000: Label 'Invoice No. %1:';
        Text001: Label 'The program cannot find this purchase line.';
        MAWBLine: Record "50076";
}

