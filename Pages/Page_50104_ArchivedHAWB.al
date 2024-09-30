page 50104 "Archived HAWB"
{
    Caption = 'House Airway Bill';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = 50075;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field("Booking Sheet No."; Rec."Booking Sheet No.")
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
                }
                field("Flight Code"; Rec."Flight Code")
                {
                }
                field("Destination Code"; Rec."Destination Code")
                {
                }
                field("Flight Date"; Rec."Flight Date")
                {
                }
                field("Agent's IATA Code"; Rec."Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; Rec."Carrier Agent Code")
                {
                }
                field("Source Airport"; Rec."Source Airport")
                {
                }
                field("Destination Airport"; Rec."Destination Airport")
                {
                }
                field("Euro Form No."; Rec."Euro Form No.")
                {
                    ShowMandatory = true;
                }
                field("Customer Entry No."; Rec."Customer Entry No.")
                {
                }
                field("Phyto Certificate No."; Rec."Phyto Certificate No.")
                {
                    ShowMandatory = true;
                }
                field(Comments; Rec.Comments)
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
            }
            part(ArchivedHAWBSubform; "Archived HAWB Subform")
            {
                SubPageLink = "MAWB No." = FIELD("MAWB No.");
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
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Archive the Hawb No. ' + FORMAT(Rec."No.") + '?') THEN BEGIN
                        Rec.Status := Rec.Status::Submitted;
                        Rec.MODIFY();
                        CurrPage.CLOSE();
                    END;
                end;
            }
        }
    }

    var
        Text001: Label 'Do you want to Archive the HAWB No %1 ?';
}

