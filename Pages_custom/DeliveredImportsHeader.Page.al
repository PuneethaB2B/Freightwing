page 50008 "Delivered Imports Header"
{
    Editable = false;
    SourceTable = Table50030;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                }
                field("Manifest No"; "Manifest No")
                {
                }
                field("MAWB No"; "MAWB No")
                {
                }
                field("Item No."; "Item No.")
                {
                    Editable = true;
                }
                field(Weight; Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                }
                field(Quantity; Quantity)
                {
                }
                field("Delivery Agent"; "Delivery Agent")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Flight No"; "Flight No")
                {
                }
                field("Port of Origin"; "Port of Origin")
                {
                }
                field("Port of Discharge"; "Port of Discharge")
                {
                }
                field(VIA; VIA)
                {
                }
                field("Country of Origin"; "Country of Origin")
                {
                }
                field("Country of Discharge"; "Country of Discharge")
                {
                }
                field("Scheduled Date"; "Scheduled Date")
                {
                }
                field("Scheduled Time"; "Scheduled Time")
                {
                }
                field("Pre-Alert Date"; "Pre-Alert Date")
                {
                }
                field("Menifest Date"; "Menifest Date")
                {
                }
                field("MAWB Date"; "MAWB Date")
                {
                }
                field("Mode of Payment"; "Mode of Payment")
                {
                }
                field("IDF No"; "IDF No")
                {
                }
                field("CIF Value"; "CIF Value")
                {
                }
                field("Actual Arrival Date"; "Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; "Actual Arrival Time")
                {
                }
            }
            part(; 50007)
            {
                SubPageLink = Pre Alert No=FIELD(No.);
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
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50032;
                    RunPageLink = Manifest No=FIELD(Flight Code),
                                  Delivery Agent=FIELD(Country of Discharge);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

