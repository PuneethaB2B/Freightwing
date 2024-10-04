page 50127 "MAWB Test"
{
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("MAWB No"; "MAWB No")
            {

                trigger OnValidate()
                begin
                    //MAWBTe.ChackAWBStatus("MAWB No");
                end;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OK)
            {
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF "MAWB No" = '' THEN BEGIN
        END ELSE BEGIN
            MAWBTe.ChackAWBStatus("MAWB No");
        END;
    end;

    var
        "MAWB No": Code[50];
        MAWBTe: Codeunit "Ammend Charges";
}

