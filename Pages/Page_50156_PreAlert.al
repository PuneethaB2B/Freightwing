page 50156 "Pre Alert"
{
    SourceTable = "Pre Alert Header";
    ApplicationArea = All;
    PageType = Card;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Visible = false;
                }
                field("MAWB No"; Rec."MAWB No")
                {
                    ShowMandatory = true;

                }
                field("Manifest No"; Rec."Manifest No")
                {
                    ShowMandatory = true;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = true;
                    ShowMandatory = true;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                    ShowMandatory = true;
                }
                field(Quantity; Rec.Quantity)
                {
                    ShowMandatory = true;
                }
                field("Delivery Agent"; Rec."Delivery Agent")
                {
                    ShowMandatory = true;
                }
                field("Flight No"; Rec."Flight No")
                {
                }
                field("Port of Origin"; Rec."Port of Origin")
                {
                }
                field("Port of Discharge"; Rec."Port of Discharge")
                {
                }
                field(VIA; Rec.VIA)
                {
                }
                field("Country of Origin"; Rec."Country of Origin")
                {
                }
                field("Country of Discharge"; Rec."Country of Discharge")
                {
                }
                field("Scheduled Date"; Rec."Scheduled Date")
                {
                    ShowMandatory = true;
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                    ShowMandatory = true;
                }
                field("Pre-Alert Date"; Rec."Pre-Alert Date")
                {
                    ShowMandatory = true;
                }
                field("Menifest Date"; Rec."Menifest Date")
                {
                    Caption = 'Manifest Date';
                    ShowMandatory = true;
                }
                field("MAWB Date"; Rec."MAWB Date")
                {
                    ShowMandatory = true;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                }
                field("IDF No"; Rec."IDF No")
                {
                    ShowMandatory = true;
                }
                field("CIF Value"; Rec."CIF Value")
                {
                    Visible = true;
                }
                field("Actual Arrival Date"; Rec."Actual Arrival Date")
                {
                    ShowMandatory = true;
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                    ShowMandatory = true;
                }
            }
            part(Page; "Pre Alert Subform")
            {
                SubPageLink = "Pre Alert No" = FIELD("No.");
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
                    RunObject = Page Flights;
                    RunPageLink = "Flight No." = FIELD("Flight Code"),
                                  "Source Code" = FIELD("Country of Origin"),
                                  "Destination Code" = FIELD("Country of Discharge");

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
                        Rec.TESTFIELD("Actual Arrival Date");
                        Rec.TESTFIELD("Actual Arrival Time");
                        IF CONFIRM(Text001) THEN
                            Rec.status := rec.Status::"Airport Receipt";
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process airport cargo receipt';
}

