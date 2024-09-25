page 50008 "Delivered Imports Header"
{
    Editable = false;
    SourceTable = 50030;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Manifest No"; Rec."Manifest No")
                {
                }
                field("MAWB No"; Rec."MAWB No")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = true;
                }
                field(Weight; Rec.Weight)
                {
                    Caption = 'Weight';
                    Editable = true;
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Delivery Agent"; Rec."Delivery Agent")
                {
                }
                field("Flight Code"; Rec."Flight Code")
                {
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
                }
                field("Scheduled Time"; Rec."Scheduled Time")
                {
                }
                field("Pre-Alert Date"; Rec."Pre-Alert Date")
                {
                }
                field("Menifest Date"; Rec."Menifest Date")
                {
                }
                field("MAWB Date"; Rec."MAWB Date")
                {
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                }
                field("IDF No"; Rec."IDF No")
                {
                }
                field("CIF Value"; Rec."CIF Value")
                {
                }
                field("Actual Arrival Date"; Rec."Actual Arrival Date")
                {
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                }
            }
            part(fw; 50007)
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
                    RunObject = Page 50032;
                    RunPageLink = "Manifest No" = FIELD("Flight Code"),
                                  "Delivery Agent" = FIELD("Country of Discharge");

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

