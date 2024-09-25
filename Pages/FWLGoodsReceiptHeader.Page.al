page 50009 "FWL Goods Receipt Header"
{
    InsertAllowed = false;
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
                    Editable = false;
                }
                field("Actual Arrival Time"; Rec."Actual Arrival Time")
                {
                    Editable = false;
                }
                field("Arrival Date FWL"; Rec."Arrival Date FWL")
                {
                    Editable = false;
                }
                field("Arrival Time FWL"; Rec."Arrival Time FWL")
                {
                    Editable = false;
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                }
                field("Delivery Time"; Rec."Delivery Time")
                {
                }
            }
            part(Page; 50154)
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
                action(Delivered)
                {
                    Caption = 'Delivered';
                    Ellipsis = false;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //TESTFIELD("Actual Arrival Date");
                        //TESTFIELD("Actual Arrival Time");
                        IF FORMAT(Rec."Delivery Date") = '' THEN BEGIN
                            Rec."Delivery Date" := TODAY;
                        END;
                        IF FORMAT(Rec."Delivery Time") = '' THEN BEGIN
                            Rec."Delivery Time" := TIME;
                        END;
                        IF CONFIRM(Text001) THEN BEGIN
                            Rec.Status := Rec.Status::Delivered;
                        END;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process cargo receipt at FWL';
}

