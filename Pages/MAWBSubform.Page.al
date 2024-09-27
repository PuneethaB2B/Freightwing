page 50099 "MAWB Subform"
{
    Caption = 'Master Airway Bill Subform';
    PageType = ListPart;
    SourceTable = 50076;
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
                field("Invoice No."; Rec."Invoice No.")
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

