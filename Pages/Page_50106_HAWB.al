page 50106 HAWB
{
    Caption = 'House Airway Bill';
    PageType = Card;
    SourceTable = "HAWB Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
                field("MAWB No."; Rec."MAWB No.")
                {
                }
                field("Shipper Code"; Rec."Shipper Code")
                {
                }
                field("Shipper Name"; Rec."Shipper Name")
                {
                }
                field("Shipper Address"; Rec."Shipper Address")
                {
                }
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field("Airline Code"; Rec."Airline Code")
                {
                    Editable = false;
                }
                field("Flight Code"; Rec."Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; Rec."Destination Code")
                {
                    Editable = false;
                }
                field("Flight Date"; Rec."Flight Date")
                {
                    Editable = false;
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                    Editable = false;
                }
                field("Carrier Agent Code"; Rec."Carrier Agent Code")
                {
                    Editable = false;
                }
                field("Source Airport"; Rec."Source Airport")
                {
                    Editable = false;
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                }
                field("Total Weight"; Rec."Total Weight")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(Page; "HAWB Subform")
            {
                SubPageLink = "MAWB No." = FIELD("MAWB No."),
                              "Shipper Code" = FIELD("Shipper Code"),
                              "Consignee Code" = FIELD("Consignee Code");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Archive)
            {
                Image = Archive;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Archive the Hawb No. ' + FORMAT(Rec."No.") + '?') THEN BEGIN
                        Rec.Status := Rec.Status::Submitted;
                        Rec.MODIFY();
                        CurrPage.CLOSE();
                    END;
                end;
            }
            action(Sumbit)
            {
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TESTFIELD("Phyto Certificate No.");
                    //TESTFIELD("Booking Sheet No.");
                    //TESTFIELD("Customer Entry No.");
                    Rec.Status := Rec.Status::Submitted;
                    Rec.MODIFY();
                end;
            }
        }
    }

    var
        Text001: Label 'Do you want to Archive the HAWB No %1 ?';
}

