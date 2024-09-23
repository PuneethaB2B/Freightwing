page 50156 "Pre Alert"
{
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
                    ShowMandatory = true;
                }
                field("MAWB No"; "MAWB No")
                {
                    ShowMandatory = true;
                }
                field("Item No."; "Item No.")
                {
                    Editable = true;
                    ShowMandatory = true;
                }
                field(Weight; Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                    ShowMandatory = true;
                }
                field(Quantity; Quantity)
                {
                    ShowMandatory = true;
                }
                field("Delivery Agent"; "Delivery Agent")
                {
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Scheduled Time"; "Scheduled Time")
                {
                    ShowMandatory = true;
                }
                field("Pre-Alert Date"; "Pre-Alert Date")
                {
                    ShowMandatory = true;
                }
                field("Menifest Date"; "Menifest Date")
                {
                    Caption = 'Manifest Date';
                    ShowMandatory = true;
                }
                field("MAWB Date"; "MAWB Date")
                {
                    ShowMandatory = true;
                }
                field("Mode of Payment"; "Mode of Payment")
                {
                }
                field("IDF No"; "IDF No")
                {
                    ShowMandatory = true;
                }
                field("CIF Value"; "CIF Value")
                {
                    Visible = true;
                }
                field("Actual Arrival Date"; "Actual Arrival Date")
                {
                    ShowMandatory = true;
                }
                field("Actual Arrival Time"; "Actual Arrival Time")
                {
                    ShowMandatory = true;
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
                    RunObject = Page 50031;
                    RunPageLink = Flight No.=FIELD(Flight Code),
                                  Source Code=FIELD(Country of Origin),
                                  Destination Code=FIELD(Country of Discharge);

                    trigger OnAction()
                    begin
                        //DocPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(AirportCargoReceipt)
                {
                    Caption = 'Airport Cargo Receipt';
                    Ellipsis = false;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TESTFIELD("Actual Arrival Date");
                        TESTFIELD("Actual Arrival Time");
                        IF CONFIRM(Text001) THEN
                         Status:=Status::"Airport Receipt";
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

