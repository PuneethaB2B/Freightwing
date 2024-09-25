table 50015 Consignee
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
        field(3; "Internet Address"; Text[250])
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
        field(11;"E-Mail";Text[250])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(12;"No. Series";Code[10])
        {
        }
        field(13;"CC/Email";Text[250])
        {
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
          NoSeriesMgt.InitSeries(ImportExportSetup."Consignee Nos.",xRec."No. Series",0D,"No.","No. Series");
    end;

    var
        ImportExportSetup: Record 50010;
        NoSeriesMgt: Codeunit 396;
        Text001: Label 'You cannot delete Consignee %1 because there is at least one %2  associated with it.';
        Consignee: Record 50015;

    
    procedure AssistEdit(OldConsignee: Record 50015): Boolean
    begin
        WITH Consignee DO BEGIN
          Consignee := Rec;
          ImportExportSetup.GET;
          ImportExportSetup.TESTFIELD("Consignee Nos.");
          IF NoSeriesMgt.SelectSeries(ImportExportSetup."Consignee Nos.",OldConsignee."No. Series","No. Series") THEN BEGIN
            ImportExportSetup.GET;
            ImportExportSetup.TESTFIELD("Consignee Nos.");
            NoSeriesMgt.SetSeries("No.");
            Rec :=OldConsignee;
            EXIT(TRUE);
          END;
        END;
    end;
}

