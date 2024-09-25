page 50107 "HAWB Subform"
{
    AutoSplitKey = true;
    Caption = 'House Airway Bill Subform';
    PageType = ListPart;
    SourceTable = 50074;

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
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                    Caption = 'Booked Weight';
                    Editable = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {

                    trigger OnValidate()
                    begin
                        BookingSheetLine.RESET;
                        BookingSheetLine.SETRANGE(BookingSheetLine."MAWB No.", Rec."MAWB No.");
                        IF BookingSheetLine.FINDFIRST THEN BEGIN
                            BookedWeight := BookingSheetLine."Booked Weight";
                        END;

                        HAWB.GET(Rec."HAWB No.");
                        HAWB.CALCFIELDS(HAWB."Total Weight");
                        GrossWeight := HAWB."Total Weight";
                        MESSAGE('%1', GrossWeight);
                    end;
                }
                field("Rate/Charge"; Rec."Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                }
                field("Custom Enrty No"; Rec."Custom Enrty No")
                {
                }
                field(Phyto; Rec.Phyto)
                {
                    Caption = 'KEPHIS Phyto Certificate';
                }
                field("Commercial Invoice No"; Rec."Commercial Invoice No")
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Certifiate of Origin"; Rec."Certifiate of Origin")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(GetHAWBItemLines)
                {
                    Caption = 'Get &HAWB Items';
                    Ellipsis = true;
                    Image = Shipment;

                    trigger OnAction()
                    begin
                        GetHAWBItem;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TESTFIELD(Quantity);
        Rec.TESTFIELD("Gross Weight");
    end;

    var
        BookingSheetLine: Record 50054;
        BookedWeight: Decimal;
        HAWBLine: Record 50074;
        GrossWeight: Decimal;
        HAWB: Record 50075;


    procedure GetHAWBItem()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get BS HAWB Item", Rec);
    end;
}

