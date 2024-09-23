report 50110 "Update Charges"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50075)
        {

            trigger OnAfterGetRecord()
            begin
                WITH "HAWB Header" DO BEGIN
                    Charges.RESET;
                    Charges.SETRANGE(Charges."MAWB No.", "HAWB Header"."No.");
                    IF Charges.FINDFIRST THEN BEGIN
                    END ELSE BEGIN
                        Ammen.CalculateMAWBCharges("HAWB Header"."No.");
                        Ammen.CalculateHandlingFees("HAWB Header"."No.");
                        MESSAGE('Ammending Sherges For %1', "HAWB Header"."No.");
                    END;
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
        Charges: Record "50072";
        Ammen: Codeunit "50031";
}

