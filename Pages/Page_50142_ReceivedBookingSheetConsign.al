page 50142 "Received Booking Sheet Consign"
{
    Caption = 'Booking Sheet Consignee Allocations';
    PageType = List;
    SourceTable = "Booking Sheet HAWB Allocation";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Consignee Code"; Rec."Consignee Code")
                {
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                }
                field("HAWB No."; Rec."HAWB No.")
                {
                    Visible = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Chargeable Weight"; Rec."Chargeable Weight")
                {
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
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
                RunObject = Page "Booking Sheet FAM Allocation";
                RunPageLink = "Booking Sheet No" = FIELD("Booking Sheet No."),
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
                    REPORT.RUN(Report::"Booking Sheet Pre Alert", TRUE, TRUE, Rec);
                end;
            }
        }
    }
}

