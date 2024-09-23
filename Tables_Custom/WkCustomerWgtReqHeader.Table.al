table 50047 "Wk. Customer Wgt. Req. Header"
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
        field(2; "Destination Code"; Code[20])
        {
            TableRelation = Country/Region;

            trigger OnValidate()
            begin
                Country.GET("Destination Code");
                "Destination Name":=Country.Name;
            end;
        }
        field(3;"Start Date";Date)
        {

            trigger OnValidate()
            begin
                "Start Day":= FORMAT("Start Date",0,'<Weekday Text>');
                "End Date":= CALCDATE('+6D',"Start Date");
                "End Day":=FORMAT("End Date",0,'<Weekday Text>');
                "Week No." := DATE2DWY("Start Date", 2);
                Year:=FORMAT("Start Date",0,'<Year4>');
                Description:=Text001+' '+FORMAT("Week No.") +'/'+ FORMAT(Year);
            end;
        }
        field(4;"End Date";Date)
        {
            Editable = false;
        }
        field(14;"No. Series";Code[20])
        {
        }
        field(15;"Week No.";Integer)
        {
            Editable = false;
        }
        field(16;"Start Day";Text[30])
        {
            Editable = false;
        }
        field(17;"End Day";Text[30])
        {
            Editable = false;
        }
        field(18;Year;Code[10])
        {
            Editable = false;
        }
        field(19;"Destination Name";Text[30])
        {
            Editable = false;
        }
        field(20;Description;Text[50])
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

    trigger OnDelete()
    begin
        WeeklyCustWgtReqLine.RESET;
        WeeklyCustWgtReqLine.SETRANGE("Weekly No.","No.");
        IF WeeklyCustWgtReqLine.FINDSET THEN
          ERROR(Text002,"No.");
    end;

    trigger OnInsert()
    begin
        ImportExportSetup.GET;
        IF "No."='' THEN
          NoSeriesMgt.InitSeries(ImportExportSetup."Weekly Analysis Nos.",xRec."No. Series",0D,"No.","No. Series");
        
        /*
        Cust.RESET;
        Cust.SETFILTER("Customer Type",'%1|%2',Cust."Customer Type"::"Third Party",Cust."Customer Type"::Group);
        IF Cust.FINDSET THEN BEGIN
          REPEAT
            WeeklyCustWgtReqLine."Weekly No.":="No.";
            WeeklyCustWgtReqLine."Customer No.":=Cust."No.";
            WeeklyCustWgtReqLine."Customer Name":=Cust.Name;
            WeeklyCustWgtReqLine."Customer Type":=Cust."Customer Type";
            WeeklyCustWgtReqLine."Country Code":="Country Code";
            WeeklyCustWgtReqLine.INSERT;
          UNTIL Cust.NEXT=0;
        END;
        */

    end;

    var
        Cust: Record "18";
        WeeklyCustWgtReqLine: Record "50048";
        ImportExportSetup: Record "50010";
        NoSeriesMgt: Codeunit "396";
        Country: Record "9";
        Text001: Label 'Customer Weight Requirements for Week';
        Text002: Label 'You cannot delete Weekly Analysis %1 because it has entries associated with it';
}

