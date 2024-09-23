page 50073 "Booking Sheet Consignee Alloca"
{
    Caption = 'Booking Sheet Consignee Allocations';
    PageType = List;
    SourceTable = 50056;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Consignee Name"; "Consignee Name")
                {
                }
                field("HAWB No."; "HAWB No.")
                {
                    Visible = false;
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Chargeable Weight"; "Chargeable Weight")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("FAM Allocation")
            {
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50075;
                RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No."),
                              "Shipper Code" = FIELD("Shipper Code"),
                              "Airline Code" = FIELD("Airline Code"),
                              "Source Airport" = FIELD("Source Airport"),
                              "Destination Airport" = FIELD("Destination Airport"),
                              "MAWB No" = FIELD("MAWB No."),
                              "Consignee Code" = FIELD("Consignee Code");
            }
            action("Print Pre Alert")
            {

                trigger OnAction()
                begin
                    REPORT.RUN(50060, TRUE, TRUE, Rec);
                end;
            }
            action(ULDs)
            {
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50072;
                RunPageLink = "Booking Sheet No." = FIELD("Booking Sheet No."),
                              "Airline Code" = FIELD("Airline Code"),
                              "Shipper Code" = FIELD("Shipper Code"),
                              "Flight Code" = FIELD("Flight Code"),
                              "MAVB No." = FIELD("MAWB No."),
                              "Source Airport" = FIELD("Source Airport"),
                              "Destination Airport" = FIELD("Destination Airport"),
                              Consignee = FIELD("Consignee Code");
            }
        }
    }
}

