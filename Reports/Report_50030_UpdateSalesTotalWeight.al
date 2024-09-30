report 50030 "Update Sales Total Weight"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            trigger OnAfterGetRecord()
            begin
                glDecSalesLineWeight := 0;
                gCodeTempHAWBNo := '';
                gRecSalesLine.RESET;
                gRecSalesLine.SETCURRENTKEY(gRecSalesLine."HAWB No.");
                gRecSalesLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                gRecSalesLine.SETFILTER("HAWB No.", '<>%1', '');
                IF gRecSalesLine.FINDSET THEN
                    REPEAT
                        IF gCodeTempHAWBNo <> gRecSalesLine."HAWB No." THEN
                            glDecSalesLineWeight += gRecSalesLine."Split Weight";
                        gCodeTempHAWBNo := gRecSalesLine."HAWB No.";
                    UNTIL gRecSalesLine.NEXT = 0
                ELSE BEGIN
                    gRecSalesLine.RESET;
                    gRecSalesLine.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    gRecSalesLine.SETFILTER("HAWB No.", '%1', '');
                    IF gRecSalesLine.FINDFIRST THEN
                        glDecSalesLineWeight := gRecSalesLine."Split Weight";
                END;

                "Sales Invoice Header"."Total Weight" := glDecSalesLineWeight;
                "Sales Invoice Header".MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        gCodeTempHAWBNo: Code[20];
        gRecSalesLine: Record 113;
        glDecSalesLineWeight: Decimal;
}

