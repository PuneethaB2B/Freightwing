page 50126 "Archived MAWB Subform"
{
    Caption = 'Master Airway Bill Subform';
    PageType = ListPart;
    SourceTable = 50076;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("HAWB No."; Rec."HAWB No.")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = true;
                }
                field(Description; Rec.Description)
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
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
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }

    var
        Text001: Label 'Master Airway Bill No. %1 does not have any lines';
        TotalWeight: Decimal;
        BookedWeight: Decimal;
        BookingSheetLine: Record 50054;
        MAWBLine: Record 50076;
        LoadingSheetLine: Record 50061;
        ShippedWeight: Decimal;
        MAWBAllocation: Record 50070;


    procedure GetHAWBAllocation()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get HAWB Line", Rec);
    end;

    local procedure GetTotalWeight(MAWB: Code[50]) Total: Decimal
    var
        MAWBLine1: Record 50076;
    begin
        MAWBLine1.RESET;
        MAWBLine1.SETRANGE(MAWBLine1."MAWB No.", Rec."MAWB No.");
        IF MAWBLine1.FIND('-') THEN BEGIN
            REPEAT
                Total := Total + MAWBLine1."Chargeable Weight";
            UNTIL MAWBLine1.NEXT = 0;
        END;
        EXIT(Total);
    end;
}

