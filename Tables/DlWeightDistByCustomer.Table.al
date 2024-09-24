table 50042 "Dl. Weight Dist. By Customer"
{

    fields
    {
        field(1; "Daily No."; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Airline"."Daily No.";
        }
        field(2; "Airline Code"; Code[20])
        {
            TableRelation = "Dl. Weight Dist. By Airline"."Airline Code";
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer.No. WHERE (Customer Type=FILTER(Group|Third Party));

            trigger OnValidate()
            begin
                DailyWeightDistByAirline.RESET;
                DailyWeightDistByAirline.SETRANGE("Daily No.","Daily No.");
                DailyWeightDistByAirline.SETRANGE("Airline Code","Airline Code");
                DailyWeightDistByAirline.SETRANGE("Destination Code","Destination Code");
                DailyWeightDistByAirline.SETRANGE("Flight Code","Flight Code");
                IF DailyWeightDistByAirline.FINDFIRST THEN BEGIN
                  DailyWeightDistByAirline.TESTFIELD("Airline Code");
                  DailyWeightDistByAirline.TESTFIELD("Flight Code");
                  DailyWeightDistByAirline.TESTFIELD("Scheduled Departure Time");
                  DailyWeightDistByAirline.TESTFIELD("Cut-off Time");

                  "Distribution Date":=DailyWeightDistByAirline."Distribution Date";
                  "Day of Week":=DailyWeightDistByAirline."Day of Week";
                END;



                Cust.GET("Customer No.");
                "Customer Name":=Cust.Name;
            end;
        }
        field(4;"Customer Name";Text[50])
        {
            Editable = false;
        }
        field(5;"Gross Weight";Decimal)
        {
            CalcFormula = Sum("Dl. Weight Dist. By Item"."Gross Weight" WHERE ("Daily No."=FIELD("Daily No."),
                                                                               "Airline Code"=FIELD("Airline Code"),
                                                                               "Customer No."=FIELD("Customer No."),
                                                                               "Flight Code"=FIELD("Flight Code"),
                                                                               "Destination Code"=FIELD("Destination Code"),
                                                                               "Destination Airport"=FIELD("Destination Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Destination Code";Code[20])
        {
            Editable = true;
            TableRelation = "Dl. Weight Dist. By Airline"."Destination Code";
        }
        field(10;"Day of Week";Option)
        {
            Editable = true;
            OptionMembers = Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        }
        field(12;"Flight Code";Code[20])
        {
            TableRelation = Flight."Flight No.";

            trigger OnValidate()
            begin
                Flights.RESET;
                Flights.SETRANGE(Flights."Flight No.","Flight Code");
                IF Flights.FIND('-') THEN
                BEGIN
                  REPEAT

                  UNTIL Flights.NEXT = 0;
                END;
            end;
        }
        field(14;"Distribution Date";Date)
        {
        }
        field(17;"Destination Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE ("Country Code"=FIELD("Destination Code"));
        }
        field(18;"Shipped Weight";Decimal)
        {
            CalcFormula = Sum("Dl. Weight Dist. By Item"."Shipped Weight" WHERE ("Daily No."=FIELD("Daily No."),
                                                                                 "Airline Code"=FIELD("Airline Code"),
                                                                                 "Customer No."=FIELD("Customer No."),
                                                                                 "Flight Code"=FIELD("Flight Code"),
                                                                                 "Destination Code"=FIELD("Destination Code"),
                                                                                 "Destination Airport"=FIELD("Destination Airport")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Daily No.","Airline Code","Flight Code","Destination Code","Customer No.","Destination Airport","Distribution Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DailyWeightDistByAirline: Record 50041;
        Cust: Record 18;
        DailyWeightDistHeader: Record 50040;
        DayofWeek: Option Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday;
        Text001: Label 'Do you want to notify: %1';
        Text002: Label 'Do you want to send the notifications';
        WeightByItem: Record 50043;
        Flights: Record 50022;
        ByAirline: Record 50041;

    
    procedure EmailRecords(ShowRequestForm: Boolean;var DailyWeightDistByCust: Record 50042)
    begin
        SendRecords(ShowRequestForm,FALSE,DailyWeightDistByCust);
    end;

    local procedure SendRecords(ShowRequestForm: Boolean;SendAsEmail: Boolean;var DailyWeightDistByCust: Record 50042)
    var
        ReportSelections: Record 77;
    begin
        /*WITH DailyWeightDistByCust DO BEGIN
          COPY(Rec);
          ReportSelections.SETRANGE(Usage,ReportSelections.Usage::"Daily Weight Distribution");
          ReportSelections.SETFILTER("Report ID",'<>0');
          ReportSelections.FIND('-');
          REPEAT
           IF NOT CONFIRM(Text001,FALSE,"Customer Name") THEN
             EXIT;
            IF NOT SendAsEmail THEN BEGIN
              REPORT.RUNMODAL(ReportSelections."Report ID",ShowRequestForm,FALSE,DailyWeightDistByCust)
            END ELSE  BEGIN
            REPEAT
              SendReport(ReportSelections."Report ID",DailyWeightDistByCust);
            UNTIL DailyWeightDistByCust.NEXT=0;
            END;
          UNTIL ReportSelections.NEXT = 0;
        END; */
        
        //WITH DailyWeightDistByCust DO BEGIN
          //COPY(Rec);
          ReportSelections.SETRANGE(Usage,ReportSelections.Usage::"Daily Weight Distribution");
          ReportSelections.SETFILTER("Report ID",'<>0');
          ReportSelections.FIND('-');
          REPEAT
           //IF NOT CONFIRM(Text001,FALSE,"Customer Name") THEN
             //EXIT;
            IF NOT SendAsEmail THEN BEGIN
              REPORT.RUNMODAL(ReportSelections."Report ID",ShowRequestForm,FALSE,DailyWeightDistByCust)
            END ELSE  BEGIN
           // REPEAT
              SendReport(ReportSelections."Report ID",DailyWeightDistByCust);
           // UNTIL DailyWeightDistByCust.NEXT=0;
            END;
         UNTIL ReportSelections.NEXT = 0;
        //END;

    end;

    local procedure SendReport(ReportId: Integer;var DailyWeightDistByCust: Record 50042)
    var
        DocumentMailing: Codeunit 50013;
        FileManagement: Codeunit 419;
        ServerAttachmentFilePath: Text[250];
    begin
        ServerAttachmentFilePath := COPYSTR(FileManagement.ServerTempFileName('pdf'),1,250);
        REPORT.SAVEASPDF(ReportId,ServerAttachmentFilePath,DailyWeightDistByCust);
        COMMIT;
        DocumentMailing.EmailFileFromDailyWeightDistByCustomer(DailyWeightDistByCust,ServerAttachmentFilePath);
    end;
}

