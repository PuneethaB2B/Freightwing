page 50001 "Received Booking Sheet Subform"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Table50054;

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
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field("Booked Weight"; "Booked Weight")
                {
                    Caption = 'Booked Weight As per Distribution';
                    DecimalPlaces = 2 : 2;
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Actual Weight"; "Actual Weight")
                {
                    Caption = 'Received Weight';
                }
                field("MAWB No."; "MAWB No.")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("Airline Code"; "Airline Code")
                {
                    Editable = false;
                }
                field("Flight Code"; "Flight Code")
                {
                    Editable = false;
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("ETD Time"; "Departure Time")
                {
                }
                field("Shipment Delivery Time"; "Shipment Delivery Time")
                {
                }
                field("Cut-off Time"; "Cut-off Time")
                {
                    Editable = false;
                }
                field("Clearing Agent Code"; "Clearing Agent Code")
                {
                }
                field("Type of Delivery"; "Type of Delivery")
                {
                }
                field("Connecting Airline"; "Connecting Airline")
                {
                }
                field("Connecting Flight No."; "Connecting Flight No.")
                {
                }
                field("Connecting Flight Date"; "Connecting Flight Date")
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
                        GoodReceiptHeader.SETRANGE(GoodReceiptHeader."No.", "Good Receipt No.");
                        IF GoodReceiptHeader.FINDFIRST THEN BEGIN
                            GoodReceiptHeader.Status := GoodReceiptHeader.Status::Open;
                            GoodReceiptHeader.MODIFY;
                            MESSAGE('Good Receipt Header %1 reopenned for this line', GoodReceiptHeader."No.");
                        END ELSE BEGIN
                            IF CONFIRM('Do you want to reset the line Status?') THEN BEGIN
                                "Good Receipt No." := '';
                                Status := Status::Open;
                                MODIFY;
                                BookingSheetHeader.RESET;
                                BookingSheetHeader.SETRANGE(BookingSheetHeader."No.", "Booking Sheet No.");
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
        BookingSheetHeader: Record "50053";
        GoodReceiptHeader: Record "50052";


    procedure GetDistributionLines()
    begin
    end;
}

