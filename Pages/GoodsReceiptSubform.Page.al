page 50131 "Goods Receipt Subform"
{
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50051;

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
                    Editable = false;
                }
                field("Division/Farm Code"; Rec."Division/Farm Code")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                    Editable = false;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ShowMandatory = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'No. Of Boxes';
                    ShowMandatory = true;
                }
                field("Booked Weight"; Rec."Booked Weight")
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                    Caption = 'Actual Received Weight';
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Type of Delivery"; Rec."Type of Delivery")
                {
                }
                field("Arrival Temperature"; Rec."Arrival Temperature")
                {
                    ShowMandatory = true;
                }
                field("X-Ray"; Rec."X-Ray")
                {
                }
                /*   group(Dimensions)
                  {
                      Caption = 'Dimensions';
                  } */
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
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
                    RunPageLink = "Good Receipt No." = FIELD("Good Receipt No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "MAWB No" = FIELD("MAWB No.");
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
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Booking Sheet", Rec);
    end;
}

