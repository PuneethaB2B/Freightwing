page 50110 "Posted Loading Sheet Subform"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = 50061;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Skid Per"; Rec."Skid Per")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No. Of Boxes';
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                    Editable = false;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field("FWL Docket Weight"; Rec."FWL Docket Weight")
                {
                    Editable = false;
                }
                field("FWL Gross Weight"; Rec."FWL Gross Weight")
                {
                    Editable = false;
                }
                field("Airline Docket Weight"; Rec."Airline Docket Weight")
                {
                }
                field("Volume Metric Weight"; Rec."Volume Metric Weight")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Arrival Temperature"; Rec."Arrival Temperature")
                {
                    Editable = false;
                }
                field("Departure Temperature"; Rec."Departure Temperature")
                {
                }
                field("X-Ray"; Rec."X-Ray")
                {
                    Editable = false;
                }
                field("Flight Code"; Rec."Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Editable = false;
                }
                field("Airline Code"; Rec."Airline Code")
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
        CompanyInfo: Record 79;


    procedure GetBookingSheetLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Goods Receipt", Rec);
    end;
}

