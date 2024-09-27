page 50118 "Airport Goods Receipt Header"
{
    InsertAllowed = false;
    SourceTable = "Pre Alert Header";
    ApplicationArea = All;

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
                    Caption = 'Manifest Date';
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
                }
                field("Arrival Time FWL"; Rec."Arrival Time FWL")
                {
                }
            }
            part(PreAlertSubform; "Pre Alert Subform")
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
                            Rec.Status := Rec.Status::"FWL Receipt";
                        Rec."Arrival Date FWL" := TODAY;
                        Rec."Arrival Time FWL" := TIME;
                        CurrPage.CLOSE;
                    end;
                }
            }
        }
    }

    var
        Text001: Label 'Are you sure you want to process cargo receipt at FWL';
}

