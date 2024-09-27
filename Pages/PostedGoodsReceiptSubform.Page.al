page 50138 "Posted Goods Receipt Subform"
{
    AutoSplitKey = true;
    Editable = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50051;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Booked Weight"; Rec."Booked Weight")
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Cut-off Time"; Rec."Cut-off Time")
                {
                }
                field("Clearing Agent Code"; Rec."Clearing Agent Code")
                {
                }
                field("Type of Delivery"; Rec."Type of Delivery")
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
                action(GetBookingSheetLines1)
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
                    RunPageLink = "Good Receipt No." = FIELD("Good Receipt No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Shipper Code" = FIELD("Shipper Code");

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
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Booking Sheet", Rec);
    end;
}

