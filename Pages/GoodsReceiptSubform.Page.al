page 50131 "Goods Receipt Subform"
{
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = Table50051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                    Editable = false;
                }
                field("Consignee Name"; "Consignee Name")
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    ShowMandatory = true;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                    Caption = 'No. Of Boxes';
                    ShowMandatory = true;
                }
                field("Booked Weight"; "Booked Weight")
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
                    Caption = 'Actual Received Weight';
                    ShowMandatory = true;
                }
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Cut-off Time"; "Cut-off Time")
                {
                }
                field("Clearing Agent Code"; "Clearing Agent Code")
                {
                    ShowMandatory = true;
                }
                field("Type of Delivery"; "Type of Delivery")
                {
                }
                field("Arrival Temperature"; "Arrival Temperature")
                {
                    ShowMandatory = true;
                }
                field("X-Ray"; "X-Ray")
                {
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                }
                field(Length; Length)
                {
                }
                field(Width; Width)
                {
                }
                field(Height; Height)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action(GetBookingSheetLines)
                {
                    AccessByPermission = TableData 120 = R;
                    Caption = '&Get Booking Sheet Lines';
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        GetBookingSheetLines();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("& Notify Parties")
                {
                    Caption = '& Notify Parties';
                    Image = EntriesList;
                    RunObject = Page 50134;
                    RunPageLink = Good Receipt No.=FIELD(Good Receipt No.),
                                  Airline Code=FIELD(Airline Code),
                                  Flight Code=FIELD(Flight Code),
                                  Item No.=FIELD(Item No.),
                                  Shipper Code=FIELD(Shipper Code);
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("& Pallet/ULD Allocation")
                {
                    Caption = '& Pallet/ULD Allocation';
                    Description = 's';
                    Image = EntriesList;
                    RunObject = Page 50135;
                                    RunPageLink = Good Receipt No.=FIELD(Good Receipt No.),
                                  Airline Code=FIELD(Airline Code),
                                  MAWB No=FIELD(MAWB No.);
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    
    procedure GetBookingSheetLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Booking Sheet",Rec);
    end;
}

