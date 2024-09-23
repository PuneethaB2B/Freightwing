page 50118 "Airport Goods Receipt Header"
{
    InsertAllowed = false;
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
                    Caption = 'Manifest Date';
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
                    Editable = false;
                }
                field("Actual Arrival Time"; "Actual Arrival Time")
                {
                    Editable = false;
                }
                field("Arrival Date FWL"; "Arrival Date FWL")
                {
                }
                field("Arrival Time FWL"; "Arrival Time FWL")
                {
                }
            }
            part(; 50154)
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
                action(FWLCargoReceipt)
                {
                    Caption = 'FWL Cargo Receipt';
                    Ellipsis = false;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Actual Arrival Date");
                        //TESTFIELD("Actual Arrival Time");
                        IF CONFIRM(Text001) THEN
                         Status:=Status::"FWL Receipt";
                        "Arrival Date FWL":=TODAY;
                        "Arrival Time FWL":=TIME;
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process cargo receipt at FWL';
}

