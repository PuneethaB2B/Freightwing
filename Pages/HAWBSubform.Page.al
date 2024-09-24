page 50107 "HAWB Subform"
{
    AutoSplitKey = true;
    Caption = 'House Airway Bill Subform';
    PageType = ListPart;
    SourceTable = Table50074;

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
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
                    Caption = 'Booked Weight';
                    Editable = false;
                }
                field("Gross Weight"; "Gross Weight")
                {

                    trigger OnValidate()
                    begin
                        BookingSheetLine.RESET;
                        BookingSheetLine.SETRANGE(BookingSheetLine."MAWB No.", "MAWB No.");
                        IF BookingSheetLine.FINDFIRST THEN BEGIN
                            BookedWeight := BookingSheetLine."Booked Weight";
                        END;

                        HAWB.GET("HAWB No.");
                        HAWB.CALCFIELDS(HAWB."Total Weight");
                        GrossWeight := HAWB."Total Weight";
                        MESSAGE('%1', GrossWeight);
                    end;
                }
                field("Rate/Charge"; "Rate/Charge")
                {
                    Visible = false;
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                }
                field("Custom Enrty No"; "Custom Enrty No")
                {
                }
                field(Phyto; Phyto)
                {
                    Caption = 'KEPHIS Phyto Certificate';
                }
                field("Commercial Invoice No"; "Commercial Invoice No")
                {
                }
                field(Currency; Currency)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Certifiate of Origin"; "Certifiate of Origin")
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
        TESTFIELD(Quantity);
        TESTFIELD("Gross Weight");
    end;

    var
        BookingSheetLine: Record "50054";
        BookedWeight: Decimal;
        HAWBLine: Record "50074";
        GrossWeight: Decimal;
        HAWB: Record "50075";


    procedure GetHAWBItem()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get BS HAWB Item", Rec);
    end;
}

