pageextension 50036 MyExtension extends "Purchase Invoice"
{
    layout
    {
        modify("No.")
        {
            Visible = true;
        }
        addafter("No.")
        {
            field("MAWB No."; Rec."MAWB No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
        }
        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            begin
                // *********************** TBL Validating Vendor Invoice number ***************** 05716090701
                TBLPurchaseInvoiceHeader.RESET;
                TBLPurchaseInvoiceHeader.FINDSET;
                REPEAT
                    IF (TBLPurchaseInvoiceHeader."Vendor Invoice No." = rec."Vendor Invoice No.") AND
                       (TBLPurchaseInvoiceHeader."Buy-from Vendor No." = rec."Buy-from Vendor No.") THEN BEGIN
                        ERROR('The Vendor Invoice No is already created for this vendor');
                        Rec."Vendor Invoice No." := '';
                        EXIT;
                    END;
                UNTIL TBLPurchaseInvoiceHeader.NEXT = 0;

                TBLPurchInvHeader.RESET;
                TBLPurchInvHeader.FINDSET;
                REPEAT
                    IF (TBLPurchInvHeader."Vendor Invoice No." = rec."Vendor Invoice No.") AND
                       (TBLPurchInvHeader."Buy-from Vendor No." = rec."Buy-from Vendor No.") THEN BEGIN
                        ERROR('The Vendor Invoice No is already posted for this vendor');
                        Rec."Vendor Invoice No." := '';
                        EXIT;
                    END;
                UNTIL TBLPurchInvHeader.NEXT = 0;

                // ******************************************************************************
            end;
        }
    }

    actions
    {
        addafter(RemoveFromJobQueue)
        {
            action("Get Dimensions")
            {
                Image = Find;
                ApplicationArea = All;
                trigger OnAction()
                BEGIN
                    InvLines.RESET;
                    InvLines.SETRANGE(InvLines."Document No.", Rec."No.");
                    InvLines.SETRANGE(InvLines."Document Type", Rec."Document Type");
                    IF InvLines.FINDSET THEN BEGIN
                        REPEAT
                            Dim.SetDimensionsPurch(InvLines."MAWB No.", InvLines);
                        UNTIL InvLines.NEXT = 0;
                    END;
                END;
            }
        }
    }
    var
        Dim: Codeunit "Invoicing Set Dimensions";
        InvLines: Record "Purchase Line";
        TBLPurchaseInvoiceHeader: Record "Purchase Header";
        TBLPurchInvHeader: Record "Purch. Inv. Header";
}