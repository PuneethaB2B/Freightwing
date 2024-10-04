report 50110 "Update Charges"
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem("HAWB Header"; "HAWB Header")
        {

            trigger OnAfterGetRecord()
            begin
                Charges.RESET;
                Charges.SETRANGE(Charges."MAWB No.", "HAWB Header"."No.");
                IF Charges.FINDFIRST THEN BEGIN
                END ELSE BEGIN
                    Ammen.CalculateMAWBCharges("HAWB Header"."No.");
                    Ammen.CalculateHandlingFees("HAWB Header"."No.");
                    MESSAGE('Ammending Sherges For %1', "HAWB Header"."No.");
                END;
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

    var
        Charges: Record "MAWB Invoice Notify Party";
        Ammen: Codeunit "Ammend Charges";
}

