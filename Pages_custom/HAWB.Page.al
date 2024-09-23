page 50106 HAWB
{
    Caption = 'House Airway Bill';
    PageType = Card;
    SourceTable = Table50075;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ShowMandatory = true;
                    Visible = false;
                }
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
                field("Consignee Code"; "Consignee Code")
                {
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("Airline Code"; "Airline Code")
                {
                    Editable = false;
                }
                field("Flight Code"; "Flight Code")
                {
                    Editable = false;
                }
                field("Destination Code"; "Destination Code")
                {
                    Editable = false;
                }
                field("Flight Date"; "Flight Date")
                {
                    Editable = false;
                }
                field("Agent's IATA Code"; "Agent's IATA Code")
                {
                    Editable = false;
                }
                field("Carrier Agent Code"; "Carrier Agent Code")
                {
                    Editable = false;
                }
                field("Source Airport"; "Source Airport")
                {
                    Editable = false;
                }
                field("Destination Airport"; "Destination Airport")
                {
                    Editable = false;
                }
                field(Comments; Comments)
                {
                }
                field("Total Weight"; "Total Weight")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
            part(; 50107)
            {
                SubPageLink = MAWB No.=FIELD(MAWB No.),
                              Shipper Code=FIELD(Shipper Code),
                              Consignee Code=FIELD(Consignee Code);
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
                    IF CONFIRM('Do you want to Archive the Hawb No. '+FORMAT("No.")+'?') THEN
                    BEGIN
                     Status:=Status::Submitted;
                     MODIFY();
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
                    Status:=Status::Submitted;
                    MODIFY();
                end;
            }
        }
    }

    var
        Text001: Label 'Do you want to Archive the HAWB No %1 ?';
}

