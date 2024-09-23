table 50022 Flight
{

    fields
    {
        field(1; "Airline Code"; Code[20])
        {
            TableRelation = Airline.Code;
        }
        field(2; "Flight Code"; Code[20])
        {
        }
        field(3; "Flight No."; Code[20])
        {
        }
        field(4; "Source Code"; Code[20])
        {
            TableRelation = Country/Region;
        }
        field(5;"Destination Code";Code[20])
        {
            TableRelation = Country/Region;
        }
        field(6;"Departure Time";Time)
        {

            trigger OnValidate()
            begin
                  "Cut Off Time":="Departure Time"-(("Shipment Delivery Time")*60*60*1000);
            end;
        }
        field(7;"Arrival Time";Time)
        {
        }
        field(8;"Source Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Source Code));
        }
        field(9;"Destination Airport";Code[50])
        {
            TableRelation = Airport.Code WHERE (Country Code=FIELD(Destination Code));
        }
        field(10;Frequency;Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Undefined';
            OptionMembers = Daily,Weekly,Monthly,Undefined;
        }
        field(11;"Shipment Delivery Time";Decimal)
        {

            trigger OnValidate()
            begin
                 "Cut Off Time":="Departure Time"-(("Shipment Delivery Time")*60*60*1000);
            end;
        }
        field(12;"Cut Off Time";Time)
        {

            trigger OnValidate()
            begin
                "Shipment Delivery Time":=("Departure Time"-"Cut Off Time")/(60*60*1000);
            end;
        }
        field(13;"Has Connection";Boolean)
        {
        }
    }

    keys
    {
        key(Key1;"Airline Code","Flight Code","Flight No.","Destination Airport","Source Airport","Destination Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Shipment Delivery Time":=5;
    end;

    var
        Text001: Label 'You cannot delete Flight %1 because there is at least one %2  associated with it.';
}

