tableextension 50013 ShippingAgentExt extends "Shipping Agent"
{
    fields
    {
        field(50000; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50001; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(50002; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code".City
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".City WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50003;"Phone No.";Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50004;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50005;Blocked;Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50006;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code"
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code" WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City,"Post Code",County,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50007;"E-Mail";Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50008;County;Text[50])
        {
        }
        field(50009;Type;Option)
        {
            OptionMembers = " ","C & F",Delivery,Carrier;
        }
    }

    var
        PostCode: Record 225;
}

