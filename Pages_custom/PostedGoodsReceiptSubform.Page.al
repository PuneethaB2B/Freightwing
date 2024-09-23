page 50138 "Posted Goods Receipt Subform"
{
    AutoSplitKey = true;
    Editable = false;
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
                }
                field("Division/Farm Code"; "Division/Farm Code")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Booked Weight"; "Booked Weight")
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
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
                }
                field("Type of Delivery"; "Type of Delivery")
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

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    [Scope('Internal')]
    procedure GetBookingSheetLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Booking Sheet",Rec);
    end;
}

