page 50110 "Posted Loading Sheet Subform"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = Table50061;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Editable = false;
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Skid Per"; "Skid Per")
                {
                }
                field(Quantity; Quantity)
                {
                    Caption = 'No. Of Boxes';
                }
                field("Shipper Code"; "Shipper Code")
                {
                    Editable = false;
                }
                field("MAWB No."; "MAWB No.")
                {
                    Editable = false;
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("FWL Docket Weight"; "FWL Docket Weight")
                {
                    Editable = false;
                }
                field("FWL Gross Weight"; "FWL Gross Weight")
                {
                    Editable = false;
                }
                field("Airline Docket Weight"; "Airline Docket Weight")
                {
                }
                field("Volume Metric Weight"; "Volume Metric Weight")
                {
                }
                field(Position; Position)
                {
                }
                field("Arrival Temperature"; "Arrival Temperature")
                {
                    Editable = false;
                }
                field("Departure Temperature"; "Departure Temperature")
                {
                }
                field("X-Ray"; "X-Ray")
                {
                    Editable = false;
                }
                field("Flight Code"; "Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                }
                field("Airline Code"; "Airline Code")
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
        CompanyInfo: Record "79";


    procedure GetBookingSheetLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Goods Receipt", Rec);
    end;
}

