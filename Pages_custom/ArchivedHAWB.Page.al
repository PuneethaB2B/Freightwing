page 50104 "Archived HAWB"
{
    Caption = 'House Airway Bill';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Table50075;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("MAWB No."; "MAWB No.")
                {
                }
                field("Shipper Code"; "Shipper Code")
                {
                }
                field("Shipper Name"; "Shipper Name")
                {
                }
                field("Shipper Address"; "Shipper Address")
                {
                }
                field("Booking Sheet No."; "Booking Sheet No.")
                {
                }
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                }
                field("Flight Code"; "Flight Code")
                {
                }
                field("Destination Code"; "Destination Code")
                {
                }
                field("Flight Date"; "Flight Date")
                {
                }
                field("Agent's IATA Code"; "Agent's IATA Code")
                {
                }
                field("Carrier Agent Code"; "Carrier Agent Code")
                {
                }
                field("Source Airport"; "Source Airport")
                {
                }
                field("Destination Airport"; "Destination Airport")
                {
                }
                field("Euro Form No."; "Euro Form No.")
                {
                    ShowMandatory = true;
                }
                field("Customer Entry No."; "Customer Entry No.")
                {
                }
                field("Phyto Certificate No."; "Phyto Certificate No.")
                {
                    ShowMandatory = true;
                }
                field(Comments; Comments)
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
            part(; 50105)
            {
                SubPageLink = MAWB No.=FIELD(MAWB No.);
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
                    IF CONFIRM('Do you want to Archive the Hawb No. ' + FORMAT("No.") + '?') THEN BEGIN
                        Status := Status::Submitted;
                        MODIFY();
                        CurrPage.CLOSE();
                    END;
                end;
            }
        }
    }

    var
        Text001: Label 'Do you want to Archive the HAWB No %1 ?';
}

