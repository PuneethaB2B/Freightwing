page 50031 Flights
{
    PageType = List;
    PromotedActionCategories = ' New,Posting,Reports,Schedule,Category5_caption,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = Table50022;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Flight Code"; "Flight Code")
                {
                }
                field("Flight No."; "Flight No.")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("Departure Time"; "Departure Time")
                {
                }
                field("Arrival Time"; "Arrival Time")
                {
                }
                field(Frequency; Frequency)
                {
                }
                field("Shipment Delivery Time"; "Shipment Delivery Time")
                {
                }
                field("Cut Off Time"; "Cut Off Time")
                {
                }
                field("Has Connection"; "Has Connection")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Flight Schedule")
            {
                Caption = 'Flight Schedule';
                Image = Print;
                action("&Flight Schedule")
                {
                    Caption = '&Flight Schedule';
                    Ellipsis = false;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50032;
                    RunPageLink = No.=FIELD(Airline Code),
                                  Manifest No=FIELD(Flight Code);
                    Visible = false;

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("&Via Destination")
                {
                    Caption = '&Via Destination';
                    Ellipsis = false;
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page 50033;
                                    RunPageLink = Airline Code=FIELD(Airline Code),
                                  Flight Code=FIELD(Flight No.),
                                  Source Airport=FIELD(Source Airport),
                                  Destination Airport=FIELD(Destination Airport);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }
}

