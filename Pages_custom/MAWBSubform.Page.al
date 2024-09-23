page 50099 "MAWB Subform"
{
    Caption = 'Master Airway Bill Subform';
    PageType = ListPart;
    SourceTable = Table50076;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; "HAWB No.")
                {
                }
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Flight Date"; "Flight Date")
                {
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                }
                field(Comments; Comments)
                {
                }
                field("Custom Enrty No"; "Custom Enrty No")
                {
                }
                field(Phyto; Phyto)
                {
                    Caption = 'KEPHIS Phyto Certificate';
                }
                field(Lendth; Lendth)
                {
                    Editable = false;
                }
                field(Width; Width)
                {
                    Editable = false;
                }
                field(Height; Height)
                {
                    Editable = false;
                }
                field("Certificate of Origin"; "Certificate of Origin")
                {
                    Editable = false;
                }
                field("Invoice No."; "Invoice No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                Image = "Action";
                action(GetHAWBAllocationLines)
                {
                    Caption = 'Get &HAWB Allocation';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetHAWBAllocation;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Master Airway Bill No. %1 does not have any lines';
        TotalWeight: Decimal;
        BookedWeight: Decimal;
        BookingSheetLine: Record "50054";
        MAWBLine: Record "50076";
        LoadingSheetLine: Record "50061";
        ShippedWeight: Decimal;
        MAWBAllocation: Record "50070";

    [Scope('Internal')]
    procedure GetHAWBAllocation()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get HAWB Line", Rec);
    end;

    local procedure GetTotalWeight(MAWB: Code[50]) Total: Decimal
    var
        MAWBLine1: Record "50076";
    begin
        MAWBLine1.RESET;
        MAWBLine1.SETRANGE(MAWBLine1."MAWB No.", "MAWB No.");
        IF MAWBLine1.FIND('-') THEN BEGIN
            REPEAT
                Total := Total + MAWBLine1."Chargeable Weight";
            UNTIL MAWBLine1.NEXT = 0;
        END;
        EXIT(Total);
    end;
}

