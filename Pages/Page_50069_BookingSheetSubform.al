page 50069 "Booking Sheet Subform"
{
    AutoSplitKey = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = 50054;
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
                field("Estimated Arrival Time"; Rec."Estimated Arrival Time")
                {
                    Caption = 'ETA Time';
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
                field("Connected Flight ETD"; Rec."Connected Flight ETD")
                {
                }
                field("Connected Flight ETA"; Rec."Connected Flight ETA")
                {
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Send Email"; Rec."Send Email")
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
                action(GetDistributionLines1)
                {
                    AccessByPermission = TableData 120 = R;
                    Caption = '&Get Distribution Lines';
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        GetDistributionLines();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action("& Pallet/ULD Allocation")
                {
                    Caption = '& Pallet/ULD Allocation';
                    Image = EntriesList;
                    RunObject = Page 50072;
                    RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Shipper Code" = FIELD("Shipper Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport");
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        //TESTFIELD("MAWB No.");
                    end;
                }
                action("& Consignee/HAWB Allocation")
                {
                    Caption = '& Consignee/HAWB Allocation';
                    Image = EntriesList;
                    RunObject = Page 50073;
                    RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Shipper Code" = FIELD("Shipper Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport");
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        //TESTFIELD("MAWB No.");
                    end;
                }
                action("& Notify Parties")
                {
                    Caption = '& Notify Parties';
                    Image = EntriesList;
                    RunObject = Page 50074;
                    RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Item No." = FIELD("Item No."),
                                  "Shipper Code" = FIELD("Shipper Code"),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport");

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        //TESTFIELD("MAWB No.");
                    end;
                }
                action("<Page Booking Sheet MAWB Allocation")
                {
                    Caption = '& MAWB Allocations';
                    Image = EntriesList;
                    RunObject = Page "Booking Sheet MAWB Allocation";
                    RunPageLink = "Booking Sheet No" = FIELD("Booking Sheet No."),
                                  "Item No" = FIELD("Item No."),
                                  "Line No." = FIELD("Line No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight No" = FIELD("Flight Code"),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport"),
                                 "Shipper Code" = FIELD('Shipper Code');

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                        //TESTFIELD("MAWB No.");
                    end;
                }
                action("<Page Booking Sheet FAM Allocation")
                {
                    Caption = '& FAM Allocations';
                    Image = EntriesList;
                    RunObject = Page 50075;
                    RunPageLink = "Booking Sheet No" = FIELD("Booking Sheet No."),
                                  "Shipper Code" = FIELD("Shipper Code"),
                                  "Item No" = FIELD("Item No."),
                                  "Airline Code" = FIELD("Airline Code"),
                                  "Flight Code" = FIELD("Flight Code"),
                                  "Source Airport" = FIELD("Source Airport"),
                                  "Destination Airport" = FIELD("Destination Airport");
                    Visible = false;

                    trigger OnAction()
                    begin
                        IF Rec."Shipper Code" <> 'C000041' THEN
                            ERROR('');
                    end;
                }
            }
        }
    }

    //[Scope('Internal')]
    procedure GetDistributionLines()
    begin
        CODEUNIT.RUN(CODEUNIT::"Export.-Get Distribution", Rec);
    end;
}

