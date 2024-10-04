page 50001 "Received Booking Sheet Subform"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Booking Sheet Line";
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
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Booked Weight"; Rec."Booked Weight")
                {
                    Caption = 'Booked Weight As per Distribution';
                    DecimalPlaces = 2 : 2;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                    Caption = 'Received Weight';
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Airline Code"; Rec."Airline Code")
                {
                    Editable = false;
                }
                field("Flight Code"; Rec."Flight Code")
                {
                    Editable = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Editable = false;
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field("ETD Time"; Rec."Departure Time")
                {
                }
                field("Shipment Delivery Time"; Rec."Shipment Delivery Time")
                {
                }
                field("Cut-off Time"; Rec."Cut-off Time")
                {
                    Editable = false;
                }
                field("Clearing Agent Code"; Rec."Clearing Agent Code")
                {
                }
                field("Type of Delivery"; Rec."Type of Delivery")
                {
                }
                field("Connecting Airline"; Rec."Connecting Airline")
                {
                }
                field("Connecting Flight No."; Rec."Connecting Flight No.")
                {
                }
                field("Connecting Flight Date"; Rec."Connecting Flight Date")
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
                action("Reopen Line Status")
                {

                    trigger OnAction()
                    begin
                        GoodReceiptHeader.RESET;
                        GoodReceiptHeader.SETRANGE(GoodReceiptHeader."No.", Rec."Good Receipt No.");
                        IF GoodReceiptHeader.FINDFIRST THEN BEGIN
                            GoodReceiptHeader.Status := GoodReceiptHeader.Status::Open;
                            GoodReceiptHeader.MODIFY;
                            MESSAGE('Good Receipt Header %1 reopenned for this line', GoodReceiptHeader."No.");
                        END ELSE BEGIN
                            IF CONFIRM('Do you want to reset the line Status?') THEN BEGIN
                                Rec."Good Receipt No." := '';
                                Rec.Status := Rec.Status::Open;
                                Rec.MODIFY;
                                BookingSheetHeader.RESET;
                                BookingSheetHeader.SETRANGE(BookingSheetHeader."No.", Rec."Booking Sheet No.");
                                IF BookingSheetHeader.FINDFIRST THEN BEGIN
                                    BookingSheetHeader.Status := BookingSheetHeader.Status::Submitted;
                                    BookingSheetHeader.MODIFY;
                                END;
                            END;
                        END;
                    end;
                }
            }
        }
    }

    var
        BookingSheetHeader: Record "Booking Sheet Header";
        GoodReceiptHeader: Record "Good Receipt Header";


    procedure GetDistributionLines()
    begin
    end;
}

