table 50017 "Notify Party"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                IF "No." <> xRec."No. Series" THEN
                    "No." := '';
            end;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; "Home Page"; Text[250])
        {
            Caption = 'Internet Address';
            ExtendedDatatype = URL;
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code".City
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".City WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(9;Blocked;Boolean)
        {
            Caption = 'Blocked';
        }
        field(10;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code"
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code" WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(11;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(12;"No. Series";Code[10])
        {
        }
        field(13;Type;Option)
        {
            OptionMembers = " ",Shipper,Consignee,Operations,Administrator,Management;
        }
        field(14;"Type Code";Code[10])
        {
            TableRelation = IF (Type=FILTER(Shipper)) Customer
                            ELSE IF (Type=FILTER(Consignee)) Consignee
                            ELSE IF (Type=FILTER(Operations)) Employee;

            trigger OnValidate()
            begin
                CASE Type OF
                  Type::Shipper:
                  BEGIN
                    Cust.GET("Type Code");
                    Name:=Cust.Name;
                  END;
                  Type::Consignee:
                  BEGIN
                    Consignee.GET("Type Code");
                    Name:=Consignee.Name;
                  END;
                  Type::Operations:
                  BEGIN
                    Employee.GET("Type Code");
                    Name:=Employee."First Name"+' '+Employee."Middle Name";
                  END;

                END;
            end;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No."='' THEN
          NoSeriesMgt.InitSeries(ImportExportSetup."Notify Party Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    var
        ImportExportSetup: Record 50010;
        NoSeriesMgt: Codeunit 396;
        Cust: Record 18;
        Consignee: Record 50015;
        NotifyParty: Record 50017;
        Employee: Record 5200;

    
    procedure AssistEdit(OldNotifyParty: Record 50017): Boolean
    begin
        WITH NotifyParty DO BEGIN
          NotifyParty := Rec;
          ImportExportSetup.GET;
          ImportExportSetup.TESTFIELD("Notify Party Nos.");
          IF NoSeriesMgt.SelectSeries(ImportExportSetup."Notify Party Nos.",OldNotifyParty."No. Series","No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Notify Party Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec :=OldNotifyParty;
            EXIT(TRUE);
          END;
        END;
    end;
}

