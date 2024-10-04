page 50126 "Archived MAWB Subform"
{
    Caption = 'Master Airway Bill Subform';
    PageType = ListPart;
    SourceTable = "MAWB Line";
    ApplicationArea = All;

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
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Flight Date"; Rec."Flight Date")
                {
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Custom Enrty No"; Rec."Custom Enrty No")
                {
                }
                field(Phyto; Rec.Phyto)
                {
                    Caption = 'KEPHIS Phyto Certificate';
                }
                field(Lendth; Rec.Lendth)
                {
                    Editable = false;
                }
                field(Width; Rec.Width)
                {
                    Editable = false;
                }
                field(Height; Rec.Height)
                {
                    Editable = false;
                }
                field("Certificate of Origin"; Rec."Certificate of Origin")
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
        BookingSheetLine: Record "Booking Sheet Line";
        MAWBLine: Record "MAWB Line";
        LoadingSheetLine: Record "Loading Sheet Line";
        ShippedWeight: Decimal;
        MAWBAllocation: Record "Booking Sheet MAWB Allocation";


    // [Scope('Internal')]
    procedure GetHAWBAllocation()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get HAWB Line", Rec);
    end;

    local procedure GetTotalWeight(MAWB: Code[50]) Total: Decimal
    var
        MAWBLine1: Record "MAWB Line";
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

